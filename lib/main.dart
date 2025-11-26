// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:teeklit/login/app_router.dart';
import 'package:teeklit/login/login_screen.dart';
import 'package:teeklit/onboarding/onboarding_screen.dart';
import 'package:teeklit/routing/go_router.dart';
import 'package:teeklit/ui/community/view_model/community_view_model.dart';
import 'package:teeklit/ui/community/view_model/report_view_model.dart';
import 'package:teeklit/ui/teekle/providers/teekle_stats_provider.dart';
import 'ui/core/providers/user_provider.dart';
import 'ui/teekle/widgets/teekle_main.dart';
import 'package:teeklit/ui/mypage/widgets/mypage.dart';
import 'ui/teekle/widgets/teekle_setting_test.dart';
import 'ui/teekle/widgets/teekle_setting_test2.dart';

//파이어베이스
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ← 중요
  await Firebase.initializeApp(
    // ← 중요
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔥 세로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FirebaseFirestore.instance.collection('test').get().then((snapshot) {
    print('🔥 Firestore 연결 성공! 문서 개수: ${snapshot.docs.length}');
  }).catchError((e) {
    print('🔥 Firestore 연결 실패: $e');
  });


  FirebaseFirestore.instance.collection('test').get().then((snapshot) {
    print('🔥 Firestore 연결 성공! 문서 개수: ${snapshot.docs.length}');
  }).catchError((e) {
    print('🔥 Firestore 연결 실패: $e');
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeekleStatsProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CommunityViewModel()),
        ChangeNotifierProvider(create: (_) => ReportViewModel()),
      ],
      child: const Teeklit(),
    ),
  );
}


class Teeklit extends StatelessWidget {
  const Teeklit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Paperlogy'),
      locale: const Locale('ko', 'KR'),

      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

    );
  }
}
