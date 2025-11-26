import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teeklit/config/colors.dart';
import 'package:teeklit/data/repositories/repository_teekle.dart';
import 'package:teeklit/data/services/api/workout_api_service.dart';
import 'package:teeklit/domain/model/teekle.dart';
import 'package:teeklit/domain/model/teekle/workout_video.dart';
import 'package:teeklit/ui/home/home_app_bar.dart';
import 'package:teeklit/ui/home/home_greetings.dart';
import 'package:teeklit/ui/home/home_myteekle_card.dart';
import 'package:teeklit/ui/home/home_trending_post_card.dart';
import 'package:teeklit/ui/home/home_top5_workout_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TeekleRepository _teekleRepository = TeekleRepository();
  final WorkoutApiService _workoutApiService = WorkoutApiService();

  String? _nickname;
  List<Teekle> _todayTeekles = []; // 화면에 표시할 티클 (isDone == false인 것들만, 최대 3개)
  List<Teekle> _allTodayTeekles = []; // 오늘의 모든 티클 (진행률 계산용)
  List<Map<String, dynamic>> _popularPosts = [];
  List<WorkoutVideo> _popularWorkouts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      /// 사용자 닉네임 가져오기
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          _nickname = userDoc.data()?['nickname'] ?? '사용자';
        }
      }

      /// 오늘 날짜의 티클 가져오기
      final today = DateTime.now();
      _allTodayTeekles = await _teekleRepository.getTeeklesByDate(today);
      // isDone == false인 티클만 필터링하고 최대 3개만 표시
      _todayTeekles = _allTodayTeekles
          .where((t) => !t.isDone)
          .take(3)
          .toList();

      /// 인기 커뮤니티 글 가져오기 (더미 데이터)
      _loadPopularPosts();

      /// 인기 운동 비디오 가져오기
      final workoutResponse = await _workoutApiService.fetchWorkouts(
        page: 1,
        perPage: 5,
      );
      if (!mounted) return;

      _popularWorkouts = workoutResponse.data.take(5).toList();
    } catch (e) {
      print('데이터 로드 오류: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _loadPopularPosts() {
    /// 더미 데이터 (db 연동 필요함!)
    _popularPosts = [
      {
        'postTitle': '오늘 아침 6시 기상 성공! 🌅',
        'postContents': '요즘 계속 늦잠 자다가 오늘 드디어 일찍 일어나서 할일들을 해치웠는데 너무 뿌듯합니다! 다른 분들도 오늘 하루 화이팅 입니다.',
        'picUrl':
            'https://www.sputnik.kr/article_img/202405/article_1714655499.jpg',
        'category': '일상',
        'commentCount': 24,
      },
      {
        'postTitle': '복지정책 관련 질문 있어요!',
        'postContents': '요즘 계속 안나가게 되니까 배달을 시켜먹게 되서.. 배고픈데 장봐서 밥해먹어야겠죠',
        'picUrl': 'null',
        'category': '일상',
        'commentCount': 12,
      },
    ];
  }

  Future<void> _handleTeekleToggle(Teekle teekle) async {
    try {
      // 티클 완료 상태 토글
      final updatedTeekle = Teekle(
        teekleId: teekle.teekleId,
        taskId: teekle.taskId,
        type: teekle.type,
        execDate: teekle.execDate,
        title: teekle.title,
        tag: teekle.tag,
        isDone: !teekle.isDone,
        noti: teekle.noti,
        url: teekle.url,
      );
      await _teekleRepository.updateTeekle(updatedTeekle);
      
      // 전체 티클 목록 업데이트
      final today = DateTime.now();
      _allTodayTeekles = await _teekleRepository.getTeeklesByDate(today);
      
      // 2초 딜레이 후에 완료된 티클을 목록에서 제거 (사용자가 완료 상태를 시각적으로 인지할 수 있도록)
      // 애니메이션이 완료될 때까지 대기 (애니메이션 300ms + 여유 200ms)
      await Future.delayed(const Duration(milliseconds: 2500));
      
      if (mounted) {
        // 새로운 미완료 티클 목록 가져오기
        final notDoneTeekles = _allTodayTeekles.where((t) => !t.isDone).toList();
        
        setState(() {
          // 현재 표시 중인 티클 개수 확인 (제거 전)
          final targetCount = 3;
          
          // 완료된 티클을 목록에서 제거
          _todayTeekles.removeWhere((t) => t.teekleId == teekle.teekleId);
          
          // 현재 표시 중인 티클 ID 목록
          final currentTeekleIds = _todayTeekles.map((t) => t.teekleId).toSet();
          
          // 새로운 미완료 티클 중에서 아직 표시되지 않은 것들 찾기
          final newTeekles = notDoneTeekles
              .where((t) => !currentTeekleIds.contains(t.teekleId))
              .take(targetCount - _todayTeekles.length)
              .toList();
          
          // 새로운 티클 추가
          _todayTeekles.addAll(newTeekles);
          
          // 최대 3개로 제한
          _todayTeekles = _todayTeekles.take(targetCount).toList();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('티클 업데이트 실패: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.Bg,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.Green,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.Bg,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          color: AppColors.Green,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 상단 헤더 (텍스트 로고 + notification)
                  const SizedBox(height: 15),
                  const HomeAppBar(),
                  const SizedBox(height: 30),

                  /// 시간대 별로 멘트 바뀌는 greetings
                  HomeGreetings(nickname: _nickname),
                  const SizedBox(height: 16),

                  /// 내 티클 박스
                  HomeMyTeekleCard(
                    todayTeekles: _todayTeekles,
                    allTodayTeekles: _allTodayTeekles,
                    onTeekleToggle: _handleTeekleToggle,
                  ),
                  const SizedBox(height: 24),

                  /// 인기글 박스
                  HomeTrendingPostCard(popularPosts: _popularPosts),
                  const SizedBox(height: 34),

                  /// 인기 운동 TOP5 박스
                  HomeTop5WorkoutCard(popularWorkouts: _popularWorkouts),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
