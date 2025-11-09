import 'package:flutter/material.dart';
import 'package:teeklit/ui/teekle/widgets/move_list_item.dart';

class TeekleMainScreen extends StatelessWidget {
  const TeekleMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //상단 헤더
              const SizedBox(height: 12),
              const Text('내 티클',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 20),

              //const ProgressCard(),
              const SizedBox(height: 16),
              //const RandomMoveCard(),
              const SizedBox(
                height: 24,
              ),

              const Text('리스트',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MoveListItem(
                          title: '분리수거하기',
                          tag: '정리',
                          color: Colors.green[200]!,
                          time: '7:30 AM'),
                      MoveListItem(
                          title: '아침에 10분 명상하기',
                          tag: '마음',
                          color: Colors.blue[200]!,
                          time: '7:30 AM'),
                      MoveListItem(
                          title: '운동처방 - 뻣뻣한 몸이 10분만에 말랑말랑!',
                          tag: '운동',
                          color: Colors.orange[300]!,
                          time: '7:30 AM'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.checklist), label: '내 티클'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '커뮤니티'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
        ],
      ),
    );
  }
}
