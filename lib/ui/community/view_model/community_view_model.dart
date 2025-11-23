import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teeklit/data/repositories/community_firebase_repository.dart';
import 'package:teeklit/domain/model/community/posts.dart';

class CommunityViewModel extends ChangeNotifier {
  final CommunityFirebaseRepository _repo = CommunityFirebaseRepository();

  String? selectedPostId;
  List<Posts> postList = [];
  Posts? post;

  bool isLoading = false;
  
  /// main에서 게시글 선택 시, 게시글 id 저장
  void selectedPost(String selectedPostId){
    this.selectedPostId = selectedPostId;
    notifyListeners();
  }

  /// 게시글 하나 불러오기
  Future<void> loadPost(String postId) async{
    isLoading = true;
    notifyListeners();

    post = await _repo.readOnePost(postId);

    isLoading = false;
    notifyListeners();
  }

  /// 게시글 저장하기
  Future<void> addPost(String postTitle, String postContents, String category, List<XFile> images) async{

    // 사진 저장하는 repo method 생성, 리스트로 보내줌
    // -> service에서 사진 저장하는 코드 만들기, return 값은 저장 경로 String
    // -> repo에서 리스트 in으로 반복해서 저장경로 갖고있는 리스트 반환
    // -> 여기서 받아서 post에 추가한 후 다시 게시글 저장하는 repo 코드로 보내줌

    final Posts newPost = Posts(
      postTitle: postTitle,
      postContents: postContents,
      category: switch (category){
        '티클' => PostCategory.teekle.value,
        '자유게시판' => PostCategory.free.value,
        '정보' => PostCategory.info.value,
        _ => throw UnimplementedError(),
      },
      createAt: DateTime.now(),
      userId: 'sdfa',
      imgUrls: await _repo.saveImages(images),
    );

    await _repo.addPost(newPost);
    /// TODO 저장 후, 게시글 리스트로 이동해야 하니, 게시글 불러오는 함수 실행

  }
}