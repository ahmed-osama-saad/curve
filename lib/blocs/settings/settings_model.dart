import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_model.g.dart';

@immutable
@JsonSerializable()
class Settings {
  const Settings({
    this.bgm = true,
    this.reps = 5,
    this.up = 4,
    this.down = 6,
    this.top = 5,
    this.bottom = 5,
    this.speed = 4,
  });

  final bool bgm;
  final int reps;
  final int up;
  final int down;
  final int top;
  final int bottom;
  final int speed;

  Settings copyWith({
    bool? bgm,
    int? reps,
    int? up,
    int? down,
    int? top,
    int? bottom,
    int? speed,
  }) {
    return Settings(
      bgm: bgm ?? this.bgm,
      reps: reps ?? this.reps,
      up: up ?? this.up,
      down: down ?? this.down,
      top: top ?? this.top,
      bottom: bottom ?? this.bottom,
      speed: speed ?? this.speed,
    );
  }

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}
