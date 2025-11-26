import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teeklit/config/colors.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback? onNotificationTap;

  const HomeAppBar({
    super.key,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/icons/teeklit_text_logo.svg',
          height: 24,
          colorFilter: const ColorFilter.mode(
            AppColors.Green,
            BlendMode.srcIn,
          ),
        ),
        // IconButton(
        //   icon: SvgPicture.asset(
        //     'assets/icons/notification.svg',
        //     width: 24,
        //     height: 24,
        //   ),
        //   onPressed:
        //       onNotificationTap ??
        //       () {
        //         /// 알림 화면으로 이동하는 코드 추가해야함
        //       },
        // ),
      ],
    );
  }
}
