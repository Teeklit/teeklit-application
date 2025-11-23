import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teeklit/domain/model/community/comments.dart';

enum PostCategory {
  teekle(value: '티클'),
  free(value: '자유게시판'),
  info(value: '정보');
  
  final String value;

  const PostCategory({required this.value});
}

// 게시글 식별값은 doc id를 사용.
class Posts {
  final String? postId; // 게시글 식별값
  final String postTitle; // 게시글 제목
  final String postContents; // 게시글 내용
  final String category; // 게시글 카테고리
  final int postView; // 조회수
  final List<String>? imgUrls; // 이미지 링크들
  final String? teekleId; // 티클 ID
  final DateTime createAt; // 게시글 생성 날짜
  final DateTime? updateAt; // 게시글 마지막 수정 날짜
  final List<String>? postLike; // 좋아요 누른 사람들
  final String userId; // 게시글 작성자 UID
  final List<Comments>? comment; // 댓글

  Posts({
    this.postId,
    required this.postTitle,
    required this.postContents,
    required this.category,
    this.postView = 0,
    this.imgUrls,
    this.teekleId,
    required this.createAt,
    this.updateAt,
    this.postLike,
    required this.userId,
    this.comment,
  });

  /// db에 json 형태로 저장되있는 값들을 Posts 클래스 형태로 변환 후 반환
  factory Posts.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Posts(
      postId: doc.id,
      postTitle: data['postTitle'],
      postContents: data['postContents'],
      category: data['category'],
      postView: data['postView'],
      imgUrls: data['imgUrls'],
      teekleId: data['teekleId'],
      createAt: data['createAt'],
      updateAt: data['updateAt'],
      postLike: data['postLike'],
      userId: data['userId'],
      comment: data['comment'],
    );
  }

  /// db에 저장하기 위해 Posts 클래스로 받은 값들을 json 형태로 만들어서 반환
  Map<String, dynamic> toJson() {
    return {
      'postTitle': postTitle,
      'postContents': postContents,
      'category': category,
      'imgUrls': imgUrls,
      'teekleId': teekleId,
      'createAt': createAt,
      'updateAt': updateAt,
      'postLike': postLike,
      'userId': userId,
      'comment': comment,
    };
  }
}
