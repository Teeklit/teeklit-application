import 'package:teeklit/domain/model/tag.dart';

import 'enums.dart';
import 'noti.dart';

///==================== Teekle 모델 정의 ====================
class Teekle {
  final String userId;
  final String teekleId;
  final String taskId;
  final TaskType type;
  final DateTime execDate;
  final String title;
  final Tag? tag;
  bool isDone;
  final Noti noti;
  final String? url;

  Teekle({
    required this.userId,
    required this.teekleId,
    required this.taskId,
    required this.type,
    required this.execDate,
    required this.title,
    this.tag,
    this.isDone = false,
    required this.noti,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId' : userId,
      'teekleId' : teekleId,
      'taskId' : taskId,
      'type' : type.name,
      'execDate' : execDate.toIso8601String(),
      'title' : title,
      'isDone' : isDone,
      'noti' : noti.toMap(),
      'url' : url,
      'tag' : tag?.toMap(),
    };
  }

  factory Teekle.fromMap(Map<String, dynamic> map) {
    if (map['teekleId'] == null ||
        map['taskId'] == null ||
        map['type'] == null ||
        map['execDate'] == null ||
        map['title'] == null ||
        map['noti'] == null ) {
      throw Exception('필수 필드 누락: $map');
    }

    return Teekle(
      userId: map['userId'] as String? ?? 'guest',
      teekleId: map['teekleId'] as String? ?? '',
      taskId: map['taskId'] as String? ?? '',
      type: TaskType.values.firstWhere(
            (e) => e.name == map['type'],
        orElse: () => TaskType.todo,
      ),
      execDate: DateTime.tryParse(map['execDate'] as String? ?? '') ?? DateTime.now(),
      title: map['title'] as String? ?? '제목 없음',
      tag: map['tag'] != null ? Tag.fromMap(map['tag'] as Map<String, dynamic>) : null,
      isDone: (map['isDone'] as bool?) ?? false,
      noti: map['noti'] != null
          ? Noti.fromMap(map['noti'] as Map<String, dynamic>)
          : Noti(hasNoti: false),
      url: map['url'] as String?,
    );
  }

}

