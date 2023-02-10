import 'package:flutter/material.dart';

class PopupIconMenuItem extends PopupMenuItem<String> {
  final String title;
  final IconData icon;

  PopupIconMenuItem({
    super.key,
    required this.title,
    required this.icon,
  }) : super(
          value: title,
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
        );
}
