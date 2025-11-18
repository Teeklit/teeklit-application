import 'package:flutter/material.dart';
import 'package:teeklit/domain/model/noti.dart';

class AlarmViewModel extends ChangeNotifier {
  bool _hasAlarm = false;
  DateTime _selectedTime;

  AlarmViewModel({DateTime? initTime})
    : _selectedTime = initTime ?? DateTime.now();

  ///getter (읽기 전용)
  bool get hasAlarm => _hasAlarm;
  DateTime get selectedTime => _selectedTime;

  ///setter (상태 변경)
  void setAlarmTime(DateTime newTime) {
    _selectedTime = newTime;
    print('✅ ViewModel setAlarmTime 호출됨: $_selectedTime');
    notifyListeners();
  }

  void setHasAlarm(bool alarmStatus) {
    _hasAlarm = alarmStatus;
    print('✅ ViewModel setHasAlarm 호출됨: $_hasAlarm');
    notifyListeners();
  }

  void resetAlarm() {
    _hasAlarm = false;
    _selectedTime = DateTime.now();
    print('✅ ViewModel resetAlarm 호출됨');
    notifyListeners();
  }

  /// ViewModel의 상태를 Noti Model로 변환
  Noti toNotiModel() {
    return Noti(hasNoti: _hasAlarm, notiTime: _hasAlarm ? _selectedTime : null);
  }

  /// Noti Model을 받아서 ViewModel 상태 업데이트
  void fromNotiModel(Noti noti) {
    _hasAlarm = noti.hasNoti;
    _selectedTime = noti.notiTime ?? DateTime.now();
    notifyListeners();
  }
}
