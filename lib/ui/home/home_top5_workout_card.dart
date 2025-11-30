import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:teeklit/config/colors.dart';
import 'package:teeklit/domain/model/teekle/workout_video.dart';

class HomeTop5WorkoutCard extends StatelessWidget {
  final List<WorkoutVideo> popularWorkouts;

  const HomeTop5WorkoutCard({
    super.key,
    required this.popularWorkouts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '최근 인기 많은 운동 TOP5 💪',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 157,
          child: popularWorkouts.isEmpty
              ? Center(
                  child: Text(
                    '운동 영상을 불러올 수 없습니다',
                    style: TextStyle(
                      color: AppColors.TxtGrey,
                      fontSize: 14,
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularWorkouts.length,
                  itemBuilder: (context, index) {
                    return _WorkoutCard(workout: popularWorkouts[index]);
                  },
                ),
        ),
      ],
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final WorkoutVideo workout;

  const _WorkoutCard({
    required this.workout,
  });

  @override
  Widget build(BuildContext context) {
    final videoId = workout.videoUrl.split('/').last;
    final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';

    return GestureDetector(
      onTap: () async {
        try {
          final url = Uri.parse(workout.videoUrl);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('YouTube 앱을 열 수 없습니다'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('링크를 열 수 없습니다: $e'),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.RoundboxDarkBg,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                thumbnailUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.BtnDarkBg,
                    // child: const Center(
                    //   child: Icon(
                    //     Icons.broken_image,
                    //     color: AppColors.TxtGrey,
                    //     size: 48,
                    //   ),
                    // ),
                  );
                },
              ),
            ),
            /// 썸네일 위에 겹치는 그라데이션 오버레이
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.BottomSheetBg.withValues(alpha: 1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            /// 북마크 아이콘
            // Positioned(
            //   top: 12,
            //   right: 12,
            //   child: GestureDetector(
            //     onTap: () {
            //       // 북마크 기능
            //     },
            //     child: Container(
            //       padding: const EdgeInsets.all(8),
            //       decoration: BoxDecoration(
            //         color: AppColors.BottomSheetBg.withValues(alpha: 0.8),
            //         shape: BoxShape.rectangle,
            //         borderRadius: BorderRadius.all(Radius.circular(10)),
            //       ),
            //       child: const Icon(
            //         Icons.bookmark_border,
            //         color: Colors.white,
            //         size: 18,
            //       ),
            //     ),
            //   ),
            // ),
            /// 운동 동영상 타이틀
            Positioned(
              bottom: 12,
              left: 12,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                width: 200, /// 카드 절반 길이
                decoration: BoxDecoration(
                  color: AppColors.Pink,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: SizedBox(
                  width: 70,
                  child: Text(
                    workout.title,
                    style: const TextStyle(
                      color: AppColors.TxtDark,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



