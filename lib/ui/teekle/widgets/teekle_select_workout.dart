import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teeklit/ui/core/themes/colors.dart';

import '../../../data/services/api/workout_api_service.dart';
import '../../../domain/model/teekle/workout_response.dart';

class TeekleSelectWorkoutScreen extends StatefulWidget {
  const TeekleSelectWorkoutScreen({super.key});

  @override
  State<TeekleSelectWorkoutScreen> createState() =>
      _TeekleSelectWorkoutScreenState();
}

class _TeekleSelectWorkoutScreenState extends State<TeekleSelectWorkoutScreen> {
  bool _isBookmarkMode = false;
  final WorkoutApiService _api = WorkoutApiService();
  late Future<WorkoutResponse> _futureWorkouts;

  @override
  void initState() {
    super.initState();
    _futureWorkouts = _api.fetchWorkouts(page: 1, perPage: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
          color: AppColors.txtGray,
        ),
        title: Text(
          '운동 선택하기',
          style: TextStyle(
            fontFamily: 'Paperlogy',
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildTabBar(),

          Expanded(
            child: FutureBuilder<WorkoutResponse>(
              future: _futureWorkouts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '데이터를 불러오는 중 오류가 발생했어요 😢\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                    child: Text(
                      '표시할 데이터가 없어요',
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                }

                final videos = snapshot.data!.data;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final videoId = videos[index].videoUrl.split('/').last;

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.txtGray),
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
                                fit: BoxFit.cover,
                                width: 160,
                                height: 90,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 160,
                                    height: 90,
                                    color: Colors.grey[800],
                                    child: const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        color: Colors.white54,
                                        size: 32,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    vertical: 6.0,
                                  ),
                                  child: Text(
                                    videos[index].title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Paperlogy',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/flowbite_link-outline.svg',
                                      ),
                                      const SizedBox(width: 4.0),
                                      SvgPicture.asset(
                                        'assets/icons/bookmark_uncheck.svg',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isBookmarkMode = false;
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 48,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: !_isBookmarkMode
                          ? AppColors.green
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: Text(
                  '전체',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Paperlogy',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: !_isBookmarkMode
                        ? AppColors.green
                        : AppColors.txtGray,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isBookmarkMode = true;
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 48,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _isBookmarkMode
                          ? AppColors.green
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: Text(
                  '북마크',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Paperlogy',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: _isBookmarkMode
                        ? AppColors.green
                        : AppColors.txtGray,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
