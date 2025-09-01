
import 'package:flutter/cupertino.dart';

class Status {
  String? title;
  String? body;
  Color? color;
  IconData? icon;

  Status({
    this.title,
    this.body,
    this.color,
    this.icon,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Status &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          body == other.body &&
          color == other.color &&
          icon == other.icon;

  @override
  int get hashCode =>
      title.hashCode ^ body.hashCode ^ color.hashCode ^ icon.hashCode;
}
