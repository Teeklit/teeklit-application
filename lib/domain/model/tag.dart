class Tag {
  final String userId;
  final String tagId;
  final String tagName;

  Tag({
    required this.userId,
    required this.tagId,
    required this.tagName,
});

  Map<String, dynamic>toMap() {
    return {
      'userId' : userId,
      'tagId' : tagId,
      'tagName' : tagName,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      userId: map['userId'] ?? '',
      tagId: map['tagId'] ?? '',
      tagName: map['tagName'] ?? '',
    );
  }
}