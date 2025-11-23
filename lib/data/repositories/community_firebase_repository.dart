import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:teeklit/data/services/db/community_firebase_service.dart';
import 'package:teeklit/domain/model/community/posts.dart';

class CommunityFirebaseRepository {
  // 커뮤니티에서 사용하는 firestore service
  final CommunityFirebaseService _communityService = CommunityFirebaseService();

  Future<void> addPost(Posts post) {
    return _communityService.addPost(post);
  }

  Future<Posts> readOnePost(String postId) {
    return _communityService.readOnePosts(postId);
  }

  /// 이미지 저장 TODO 구현 예정, 이거 자체를 repo로 보내기?
  Future<List<String>?> saveImages(List<XFile>? images) async {

    if(images == null){
      return null;
    }

    // 경로 저장할 list
    final List<String> pathList = [];
    final String storagePath = 'gs://teeklit.firebasestorage.app/image/community/';

    // XFile -> File 변환
    for(XFile i in images){
      File image = File(i.path);
      String imageName = i.name;

      String fileName = await _communityService.saveImage(image, imageName);

      pathList.add(storagePath + fileName);
    }

    return pathList;
  }


}