import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teeklit/config/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTrendingPostCard extends StatelessWidget {
  final List<Map<String, dynamic>> popularPosts;

  const HomeTrendingPostCard({
    super.key,
    required this.popularPosts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '지금 다른 사람들은? 🔥',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                // backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                context.go('/community');
              },
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
        const SizedBox(height: 4),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularPosts.length,
            itemBuilder: (context, index) {
              return _PostCard(postInfo: popularPosts[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _PostCard extends StatelessWidget {
  final Map<String, dynamic> postInfo;

  const _PostCard({
    required this.postInfo,
  });

  @override
  Widget build(BuildContext context) {
    final String postTitle = postInfo['postTitle'] ?? '';
    final String postContents = postInfo['postContents'] ?? '';
    final String picUrl = postInfo['picUrl'] ?? 'null';
    final String category = postInfo['category'] ?? '';
    final int commentCount = postInfo['commentCount'] ?? 0;

    return GestureDetector(
      onTap: () {
        context.push('/community/view');
      },
      child: Container(
        width: 310,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.RoundboxDarkBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: picUrl != 'null' ? 3 : 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          postContents,
                          style: const TextStyle(
                            color: AppColors.TxtLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (picUrl != 'null') ...[
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          picUrl,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.BtnDarkBg,
                              child: const Icon(
                                Icons.broken_image,
                                color: AppColors.TxtGrey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),

            /// 게시판 카테고리 표시
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.Orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 6, horizontal: 12,
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: AppColors.TxtDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),

                /// 댓글 갯수 표시
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/comment.svg',
                      width: 14,
                      height: 14,
                      colorFilter: ColorFilter.mode(
                        AppColors.TxtLight,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$commentCount',
                      style: const TextStyle(
                        color: AppColors.TxtLight,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



