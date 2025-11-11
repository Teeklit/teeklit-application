import 'package:flutter/material.dart';
import 'package:teeklit/bottom_sheet.dart';

void main() {
  runApp(const AddTeekleTodo());
}

class AddTeekleTodo extends StatelessWidget {
  const  AddTeekleTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddTodoScreen(),
    );
  }
}

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  bool _alarmEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2C2C2E),
      appBar: AppBar(title: Text('앱바 자리차지용')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '투두 이름',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            //투두 이름 입력
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '할일을 입력해주세요.',
                hintStyle: const TextStyle(color: Color(0xff8E8E93)),
                filled: true,
                fillColor: const Color(0xff3A3A3C),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 알림 설정
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff3A3A3C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // 알림 (토글)
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    title: const Text('알림',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                    trailing: Switch.adaptive(
                      value: _alarmEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          _alarmEnabled = value;
                        });
                      },
                      activeThumbColor: Colors.white,
                      activeTrackColor: Color(0xffB1C39F),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey.shade700,
                    ),
                  ),
                  Divider(color: Color(0xff2C2C2E), height: 1),

                  // 반복 (화살표 아이콘)
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    title: const Text('반복',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.white70),
                    onTap: () {
                      // 바텀시트 띄우기
                      showTeekleRepeatSheet(context);
                    },
                  ),
                  Divider(color: Color(0xff2C2C2E), height: 1),

                  // 태그 (화살표 아이콘)
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    title: const Text('태그',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.white70),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('앱바 자리차지용')),
//         body: Container(
//             width: double.infinity,
//             height: double.infinity,
//             color: Color(0xff2C2C2E),
//             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
//
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('투두 이름',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 CustomInputField(
//                   hintText: '할일을 입력해주세요...',
//                   errorText: '20자 이내로 입력해주세요.',
//                 ),
//               ],
//             ),
//           ),
//       ),
//     );
//   }
// }
