import 'package:flutter/material.dart';

class Coalition {
  final String name;
  final String imageUrl;
  final Color color;

  Coalition.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        imageUrl = json['image_url'],
        color = Color(
            int.parse(json['color'].substring(1), radix: 16) + 0xFF000000);
}
