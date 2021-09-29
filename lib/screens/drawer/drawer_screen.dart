import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:zoom_drawer/screens/drawer/screen_structure.dart';

import 'menu_screen.dart';

class DrawerScreen extends StatefulWidget {
  static List<MenuItem> mainMenu = [
    const MenuItem('Home', Icons.home, 0),
    const MenuItem('Cart', Icons.add_shopping_cart, 1),
    const MenuItem('Buy', Icons.shopping_bag_outlined, 2),
    const MenuItem('Profile', Icons.person, 3),
  ];

  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final _drawerController = ZoomDrawerController();

  final int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      style: DrawerStyle.Style1,
      menuScreen: MenuScreen(
        DrawerScreen.mainMenu,
        callback: _updatePage,
        current: _currentPage,
      ),
      mainScreen: const MainScreen(),
      borderRadius: 24.0,
     showShadow: true,
      angle: 0.0,
      mainScreenScale: .3,
      slideWidth: MediaQuery.of(context).size.width * 0.6,
      clipMainScreen: false,
      openCurve: Curves.fastOutSlowIn,
      // closeCurve: Curves.bounceIn,
    );
  }

  void _updatePage(index) {
    Provider.of<MenuProvider>(context, listen: false).updateCurrentPage(index);
    _drawerController.toggle!();
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DrawerState>(
      valueListenable: ZoomDrawer.of(context)!.stateNotifier!,
      builder: (context, state, child) {
        return AbsorbPointer(
          absorbing: state != DrawerState.closed,
          child: child,
        );
      },
      child: GestureDetector(
        child: const ScreenStructure(),
        onPanUpdate: (details) {
          if (details.delta.dx < 6) {
            ZoomDrawer.of(context)!.toggle();
          }
        },
      ),
    );
  }
}

class MenuProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void updateCurrentPage(int index) {
    if (index != currentPage) {
      _currentPage = index;
      notifyListeners();
    }
  }
}