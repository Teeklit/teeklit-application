import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teeklit/ui/home/custom_bottom_navigation_bar.dart';

class NavigationView extends StatefulWidget {
  final Widget child;

  const NavigationView({
    super.key,
    required this.child,
  });

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int _getCurrentIndex(String location) {
    if (location.startsWith('/')) return 0;
    if (location.startsWith('/teekle')) return 1;
    if (location.startsWith('/community')) return 2;
    if (location.startsWith('/my')) return 3;
    return 0;
  }

  void _onNavTap(int index) {
    final routes = ['/', '/teekle', '/community', '/my'];
    context.go(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final currentIndex = _getCurrentIndex(location);

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomBottomNavigationBar(
        idx: currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}