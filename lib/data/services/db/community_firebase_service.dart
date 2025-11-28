import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:teeklit/domain/model/community/comments.dart';
import 'package:teeklit/domain/model/community/posts.dart';

class CommunityFirebaseService {
  final postRef = FirebaseFirestore.instance.collection('posts');
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String comments = 'comments';

  /// post add 게시글 추가
  Future<void> addPost(Posts post) async {
    await postRef.add(post.toJson());
  }

  /// 게시글 수정
  Future<void> modifyPost(Posts copyPost, String postId) async{
    await postRef.doc(postId).update(copyPost.toJson());
  }

  /// post one read 게시글 하나 읽기
  Future<Posts> readOnePosts(String postId) async {
    final documentSnapshot = await postRef.doc(postId).get();

    return Posts.fromJson(documentSnapshot);
  }

  /// post update 게시글 업데이트
  Future<void> updatePost(Posts post) async {
    await postRef.doc(post.postId).set(post.toJson());
  }

  /// post delete 게시글 삭제
  Future<void> deletePost(String postId) async {
    await postRef.doc(postId).delete();
  }

  /// save Image 사진 저장, Firebase Storage 기능
  Future<String> saveImage(File image) async {
    // ref
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('image')
        .child('community')
        .child('${DateTime.now().millisecondsSinceEpoch}');

    // 저장
    await storageRef.putFile(image);

    // 저장 경로 반환
    return storageRef.getDownloadURL();
  }

  // 무한 스크롤 백업
/*  Future<(List<Posts>, DocumentSnapshot?)> loadPosts({DocumentSnapshot? startAfter, required int limitCount}) async {
    Query query = postRef
        .orderBy('createAt', descending: true)
        .limit(limitCount);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();

    final List<Posts> postList = snapshot.docs
        .map((e) => Posts.fromJson(e))
        .toList();
    final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

    return (postList, lastDoc);
  }*/

  /// 무한 스크롤
  Future<(QuerySnapshot, DocumentSnapshot?)> loadPosts({DocumentSnapshot? startAfter, required int limitCount}) async {
    Query query = postRef
        .where('isHided', isEqualTo: false).orderBy('createAt', descending: true)
        .limit(limitCount);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();

    final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

    return (snapshot, lastDoc);
  }

  /// 댓글 저장
  void commentWrite(Comments newComment, String postId) async{
    postRef.doc(postId).collection(comments).add(newComment.toJson());
  }

  /// 댓글 가져오기
  Future<List<Comments>> readComment(String postId) async {
    List<Comments> getComments = [];

    final documentSnapshot = await postRef.doc(postId).collection(comments).where('isHided', isEqualTo: false).orderBy('createAt',).get();

    for(var i in documentSnapshot.docs){
      getComments.add(Comments.fromJson(i));
    }

    return getComments;
  }

  /// 좋아요 추가
  Future<void> addLike(String postId, String userId) async{
    await postRef.doc(postId).update({'postLike':FieldValue.arrayUnion([userId])});
  }

  /// 좋아요 제거
  Future<void> removeLike(String postId, String userId) async {
    await postRef.doc(postId).update({'postLike':FieldValue.arrayRemove([userId])});
  }

  /// 좋아요 누른 사람들 목록 가져오기
  Future<List<String>> getPostLikeUser(String postId) async {
    final documentSnapshot = await postRef.doc(postId).get();

    final data = documentSnapshot.data();

    List<String> postLikeUserList = [];

    if(data != null){
      postLikeUserList = List.from(data['postLike']);
    }

    return postLikeUserList;
  }

  /// 게시글 숨기기 기능
  Future<void> hidePost(String postId) async{
    await postRef.doc(postId).update({'isHided': true});
  }

  /// 댓글 숨기기 기능
  Future<void> hideComment(String postId,String commentId) async{
    await postRef.doc(postId).collection(comments).doc(commentId).update({'isHided': true});
  }

  /// 댓글 삭제
  Future<void> deleteComment(String postId, String commentId) async{
    await postRef.doc(postId).collection(comments).doc(commentId).delete();
  }

  // 댓글 5개 이상의 게시글 추출
  Future<List<Posts>> popularPosts() async{
    List<Posts> popularPostsList = [];

    // post 전체를 읽어옴
    final documentSnapshot = await postRef.get();

    // 읽어온 post들을 반복시킴
    for(var i in documentSnapshot.docs){

      // i라는 post의 id를 갖고 post의 sub collection인 comment에 접근해서 comment 전부 가져옴
      final commentSnapshot = await postRef.doc(i.id).collection(comments).get();
      List<Comments> commentList = [];

      // comment 반복시켜서 임시 저장시킴
      for(var j in commentSnapshot.docs){
        commentList.add(Comments.fromJson(j));
      }

      // 임시 저장시킨 댓글이 5개 이상이면, 그 댓글들을 갖고 있는 post를 반환시킬 list에 추가
      if(commentList.length >= 5){
        popularPostsList.add(Posts.fromJson(i));
      }

      // 반환시킬 list가 5개를 넘어서면 즉시 반환, 함수 종료
      if(popularPostsList.length >= 5){
        return popularPostsList;
      }
      print('인기글 갯수 : ${popularPostsList.length}');
    }

    // 5개를 안넘어가도 현재 갖고 있는 값만 전달
    return popularPostsList;
  }

}