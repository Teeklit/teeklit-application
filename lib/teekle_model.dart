enum DaysOfWeek { mon, tue, wed, thu, fri, sat, sun }

//알림 설정용
mixin AlarmSetting {
  bool hasAlarm = false;
  DateTime? alarmTime;
}

//반복 설정용
mixin RepeatSetting {
  bool hasRepeat = false;
  String? repeatUnit;
  int repeatInterval = 0;
  List<DaysOfWeek> selectedDays = [];
}

//각 날짜별 실행 정보 저장용
class TeekleInstance {
  DateTime date;
  bool isDone;

  TeekleInstance({
    required this.date,
    this.isDone = false,
  });
}

//모든 티클(투두,운동)의 공통 베이스 속성 (이름, 생성일, 날짜별 실행 정보 리스트)
abstract class BaseTeekle {
  final DateTime createdTime;
  String title;
  List<TeekleInstance> instances;

  BaseTeekle({
    required this.createdTime,
    required this.title,
  }) : instances = [TeekleInstance(date: createdTime)];
}

//투두 티클
class TodoTeekle extends BaseTeekle with AlarmSetting, RepeatSetting {
  String tag;

  TodoTeekle({
    required super.createdTime,
    required super.title,
    required this.tag,
  });
}

//운동 티클
class WorkoutTeekle extends BaseTeekle with AlarmSetting, RepeatSetting {
  String videoUrl;
  //String thumnailPath;

  WorkoutTeekle({
    required super.createdTime,
    required super.title,
    required this.videoUrl,
  });
}
