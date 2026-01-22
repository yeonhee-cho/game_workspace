import 'dart:ui';

import 'package:flutter/cupertino.dart';

class GameItem {
  final String id;
  final String name;
  final Color color;
  final IconData icon;

  GameItem(
    {
      required this.id,
      required this.name,
      required this.color,
      required this.icon
    }
  );
}