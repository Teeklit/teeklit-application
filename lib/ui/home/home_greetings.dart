import 'package:flutter/material.dart';
import 'package:teeklit/config/colors.dart';

class HomeGreetings extends StatelessWidget {
  final String? nickname;

  const HomeGreetings({
    super.key,
    this.nickname,
  });

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) {
      return '좋은 아침이에요';
    } else if (hour >= 11 && hour < 14) {
      return '점심 꼭 챙겨요';
    } else if (hour >= 14 && hour < 18) {
      return '나른한 오후 힘내세요';
    } else if (hour >= 18 && hour < 21) {
      return '좋은 저녁이예요';
    } else if (hour >= 21 && hour < 24) {
      return '오늘도 고생했어요';
    } else {
      return '늦은밤 푹 쉬세요';
    }
  }

  String _getGreetingEmoji() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) {
      return '🌞';
    } else if (hour >= 11 && hour < 14) {
      return '🍜';
    } else if (hour >= 14 && hour < 18) {
      return '💪🏼';
    } else if (hour >= 18 && hour < 21) {
      return '🌙';
    } else {
      return '😴';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_getGreeting()}, ${nickname ?? '새싹랩'}님! ${_getGreetingEmoji()}',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}



