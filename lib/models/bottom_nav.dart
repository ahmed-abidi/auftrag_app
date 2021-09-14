import 'package:flutter/material.dart';

class BottomNav {
  final String name;
  final IconData defaultIcon;
  final IconData activeIcon;

  BottomNav({this.name, this.defaultIcon, this.activeIcon});
}

List<BottomNav> bottomNavItems = [
  BottomNav(
    name: 'Orders',
    defaultIcon: Icons.home,
    activeIcon: Icons.home,
  ),
  BottomNav(
    name: 'Invoices',
    defaultIcon: Icons.payment_outlined,
    activeIcon: Icons.messenger_rounded,
  ),
  /*BottomNav(
    name: 'Notificaitons',
    defaultIcon: Icons.notifications_none,
    activeIcon: Icons.notifications,
  ),*/
];
