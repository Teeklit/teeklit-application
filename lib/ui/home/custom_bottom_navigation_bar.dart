import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teeklit/utils/colors.dart';

class NavItem {
  final String iconPath;
  final String label;
  final String routeName;

  const NavItem({
    required this.iconPath,
    required this.label,
    required this.routeName,
  });
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int idx;
  final Function(int)? onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.idx,
    this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _idx = widget.idx;

  final List<NavItem> _navItems = [
    NavItem(
      iconPath: 'assets/icons/nav_home.svg',
      label: '홈',
      routeName: '/',
    ),
    NavItem(
      iconPath: 'assets/icons/nav_myteekle.svg',
      label: '내 티클',
      routeName: '/myteekle',
    ),
    NavItem(
      iconPath: 'assets/icons/nav_community.svg',
      label: '커뮤니티',
      routeName: '/community',
    ),
    NavItem(
      iconPath: 'assets/icons/nav_my.svg',
      label: 'MY',
      routeName: '/my',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.StrokeGrey, width: 1)),
      ),
      child: BottomNavigationBar(
        backgroundColor: AppColors.Bg,
        selectedItemColor: Colors.white,
        unselectedItemColor: AppColors.InactiveTxtGrey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
        ),
        currentIndex: _idx,
        onTap: (index) {
          setState(() {
            _idx = index;
          });
          widget.onTap?.call(index);
        },
        items: _navItems.asMap().entries.map((entry) {
          final idx = entry.key;
          final item = entry.value;

          return BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(0, 8, 0, 5),
              child: SvgPicture.asset(
                item.iconPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  (_idx == idx) ? Colors.white : AppColors.InactiveTxtGrey,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}
