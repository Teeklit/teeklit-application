import 'package:flutter/material.dart';
import 'package:teeklit/domain/model/enums.dart';
import 'package:teeklit/ui/teekle/widgets/teekle_setting_page.dart';
import 'package:teeklit/ui/teekle/view_model/vm_alarm_setting.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    /// 페이지를 띄울 때, 해당 페이지에서만 사용할 Provider를 함께 생성
                    ChangeNotifierProvider(
                      create: (_) => AlarmViewModel(),
                      child: const TeekleSettingPage(
                          type: TeeklePageType.addTodo),
                    ),
                  ),
                );
              },
              child: const Text(
                '투두 추가하기',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TeekleSettingPage(type: TeeklePageType.editTodo,)),
                );
              },
              child: const Text(
                '투두 수정하기',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TeekleSettingPage(type: TeeklePageType.addWorkout,)),
                );
              },
              child: const Text(
                '운동 추가하기',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TeekleSettingPage(type: TeeklePageType.editWorkout,)),
                );
              },
              child: const Text(
                '운동 수정하기',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}