import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:teeklit/config/colors.dart';
import 'package:teeklit/domain/model/teekle.dart';

class HomeMyTeekleCard extends StatelessWidget {
  final List<Teekle> todayTeekles; // 화면에 표시할 티클 (isDone == false인 것들만, 최대 3개)
  final List<Teekle> allTodayTeekles; // 오늘의 모든 티클 (진행률 계산용)
  final Function(Teekle) onTeekleToggle;

  const HomeMyTeekleCard({
    super.key,
    required this.todayTeekles,
    required this.allTodayTeekles,
    required this.onTeekleToggle,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dateStr = DateFormat('M월 d일', 'ko_KR').format(today);
    // 전체 티클 기준으로 진행률 계산
    final doneCount = allTodayTeekles.where((t) => t.isDone).length;
    final totalCount = allTodayTeekles.length;
    final progress = totalCount > 0 ? doneCount / totalCount : 0.0;
    final allDone = totalCount > 0 && doneCount == totalCount;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 4, 0, 8),
      decoration: BoxDecoration(
        color: AppColors.RoundboxDarkBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '내 티클',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '$dateStr',
                    style: const TextStyle(
                      color: AppColors.TxtLight,
                      fontSize: 14,
                      height: 0,
                      letterSpacing: -.1,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  context.go('/teekle');
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  '더보기',
                  style: TextStyle(
                    color: AppColors.TxtLight,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          /// 진행 바 그래프
          Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: AppColors.BtnDarkBg,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.Green,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  totalCount > 0 ? '$doneCount / $totalCount' : '0 / 0',
                  style: const TextStyle(
                    color: AppColors.TxtGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 티클 목록
          if (totalCount == 0)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '오늘 예정된 티클이 없어요 🧐',
                  style: TextStyle(
                    color: AppColors.TxtLight,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          else if (allDone)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '오늘의 모든 티클을 완료했어요! 대단해요 🎉',
                  style: TextStyle(
                    color: AppColors.Green,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          else if (todayTeekles.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '오늘 예정된 티클이 없어요 🧐',
                  style: TextStyle(
                    color: AppColors.TxtLight,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          else
            ...todayTeekles.asMap().entries.map(
              (entry) => _AnimatedTeekleItem(
                key: ValueKey(entry.value.teekleId),
                teekle: entry.value,
                onTap: () => onTeekleToggle(entry.value),
              ),
            ),
        ],
      ),
    );
  }
}

class _AnimatedTeekleItem extends StatefulWidget {
  final Teekle teekle;
  final VoidCallback onTap;

  const _AnimatedTeekleItem({
    super.key,
    required this.teekle,
    required this.onTap,
  });

  @override
  State<_AnimatedTeekleItem> createState() => _AnimatedTeekleItemState();
}

class _AnimatedTeekleItemState extends State<_AnimatedTeekleItem>
    with SingleTickerProviderStateMixin {
  late bool _isDone;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _isRemoving = false;

  @override
  void initState() {
    super.initState();
    _isDone = widget.teekle.isDone;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    // 초기에는 완전히 보이도록 설정
    _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(_AnimatedTeekleItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.teekle.teekleId != widget.teekle.teekleId) {
      // 새로운 티클이 추가될 때 페이드 인 애니메이션
      _isDone = widget.teekle.isDone;
      _isRemoving = false;
      _controller.value = 0.0;
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    // 즉시 UI 업데이트 (화면 번쩍임 방지)
    setState(() {
      _isDone = !_isDone;
    });
    
    // 백그라운드에서 실제 업데이트 수행 (즉시 호출)
    widget.onTap();
    
    // 완료 상태가 되면 2초 후 페이드 아웃 애니메이션 시작
    if (_isDone) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted && !_isRemoving) {
          setState(() {
            _isRemoving = true;
          });
          // 페이드 아웃 애니메이션 시작
          _controller.reverse();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.teekle.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                decoration: _isDone ? TextDecoration.lineThrough : null,
                decorationColor: Colors.white,
                decorationThickness: 2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: _handleTap,
            child: SvgPicture.asset(
              _isDone
                  ? 'assets/icons/check_with_logo_active.svg'
                  : 'assets/icons/check_with_logo_inactive.svg',
              width: 20,
            ),
          ),
        ],
      ),
    );

    // 제거 중이 아닐 때만 FadeTransition 적용
    if (_isRemoving) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: content,
      );
    }
    
    // 일반 상태에서는 그냥 표시
    return content;
  }
}


