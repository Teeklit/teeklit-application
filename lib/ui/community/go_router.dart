import 'package:go_router/go_router.dart';
import 'package:teeklit/ui/My/my_page.dart';
import 'package:teeklit/ui/community/community_main_page.dart';
import 'package:teeklit/ui/community/community_post_view_page.dart';
import 'package:teeklit/ui/community/community_post_write_page.dart';
import 'package:teeklit/ui/home/home_page.dart';
import 'package:teeklit/ui/home/navigation_view.dart';
import 'package:teeklit/domain/model/enums.dart';
import 'package:teeklit/ui/teekle/teekle_main.dart';
import 'package:teeklit/ui/teekle/widgets/teekle_setting_page.dart';
import 'package:teeklit/ui/teekle/widgets/teekle_select_workout.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, shellChild) {
        return NavigationView(child: shellChild);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/teekle',
          name: 'teekle',
          builder: (context, state) => const TeekleMainScreen(),
        ),
        GoRoute(
          path: '/community',
          name: 'communityMain',
          builder: (context, state) => const CommunityMainPage(),
        ),
        GoRoute(
          path: '/my',
          name: 'my',
          builder: (context, state) => const MyPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/community/write',
      name: 'communityWrite',
      builder: (context, state) => const CommunityPostWritePage(),
    ),
    GoRoute(
      path: '/community/view',
      name: 'communityView',
      builder: (context, state) => const CommunityPostViewPage(),
    ),
    GoRoute(
      path: '/teekle/addTodo',
      name: 'teekleAddTodo',
      builder: (context, state) => const TeekleSettingPage(type: TeeklePageType.addTodo,),
    ),
    GoRoute(
      path: '/teekle/editTodo',
      name: 'teekleEditTodo',
      builder: (context, state) => const TeekleSettingPage(type: TeeklePageType.editTodo,),
    ),
    GoRoute(
      path: '/teekle/addWorkout',
      name: 'teekleAddWorkout',
      builder: (context, state) => const TeekleSettingPage(type: TeeklePageType.addWorkout,),
    ),
    GoRoute(
      path: '/teekle/editWorkout',
      name: 'teekleEditWorkout',
      builder: (context, state) => const TeekleSettingPage(type: TeeklePageType.editWorkout,),
    ),
    GoRoute(
      path: '/teekle/selectWorkout',
      name: 'teekleSelectWorkout',
      builder: (context, state) => const TeekleSelectWorkoutScreen(),
    ),
  ],
);