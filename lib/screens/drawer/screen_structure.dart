import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:zoom_drawer/utils/custom_color.dart';

import 'drawer_screen.dart';

class ScreenStructure extends StatelessWidget {
  final String? title;
  final Widget? child;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;

  const ScreenStructure({
    Key? key,
    this.title,
    this.child,
    this.actions,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = CustomColor.primaryColor;
    const angle = 0.0;
    final _currentPage = context.select<MenuProvider, int>((provider) => provider.currentPage);
    final container = Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: _goToScreen(_currentPage),
    );

    return PlatformScaffold(
      backgroundColor: Colors.transparent,
      appBar: PlatformAppBar(
        automaticallyImplyLeading: false,
        material: (_, __) => MaterialAppBarData(elevation: elevation),
        title: PlatformText(
          DrawerScreen.mainMenu[_currentPage].title,
        ),
        leading: Transform.rotate(
          angle: angle,
          child: PlatformIconButton(
            icon: const Icon(
              Icons.menu,
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          ),
        ),
        trailingActions: actions,
        backgroundColor: CustomColor.primaryColor,
      ),
      bottomNavBar: PlatformNavBar(
        material: (_, __) => MaterialNavBarData(
          selectedLabelStyle: TextStyle(color: color),
        ),
        currentIndex: _currentPage,
        itemChanged: (index) => Provider.of<MenuProvider>(context, listen: false).updateCurrentPage(index),
        items: DrawerScreen.mainMenu
            .map(
              (item) => BottomNavigationBarItem(
            label: item.title,
            icon: Icon(
              item.icon,
              color: color,
            ),
          ),
        )
            .toList(),
      ),
      body: kIsWeb
          ? container
          : Platform.isAndroid
          ? container
          : SafeArea(
        child: container,
      ),
    );
  }

  _goToScreen(int currentPage) {
    switch (currentPage) {
      case 0:
        return const Text('home');
      case 1:
        return const Text('cart');
      case 2:
        return const Text('buy');
      case 3:
        return const Text('profile');
    }
  }
}