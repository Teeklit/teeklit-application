import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teeklit/domain/model/tag.dart';

class TagRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'tags';

  /// Tag 저장 메소드(Tag 생성 시 호출되면서 Firestore에 저장됨)
  Future<String> createTag(Tag tag) async {
    try {
      await _firestore.collection(_collectionName).doc(tag.tagId).set(
        tag.toMap(),
        SetOptions(merge: true),
      );
      return tag.tagId;
    } catch (e) {
      throw Exception('Tag 생성 실패: $e');
    }
  }

  /// Tag 업데이트
  Future<void> updateTag(Tag tag) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(tag.tagId)
          .update(tag.toMap());
    } catch (e) {
      throw Exception('Tag 업데이트 실패: $e');
    }
  }

  /// userId로 Tag 리스트 조회
  Future<List<Tag>> TagsByUserId(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          .get();

      return querySnapshot.docs
          .map((doc) => Tag.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('사용자별 Tag 목록 조회 실패: $e');
    }
  }

  /// Tag 삭제
  Future<void> deleteTag(String tagId) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(tagId)
          .delete();
    } catch (e) {
      throw Exception('태그 삭제 실패: $e');
    }
  }
}