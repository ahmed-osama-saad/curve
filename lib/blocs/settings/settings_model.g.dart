// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      bgm: json['bgm'] as bool? ?? true,
      reps: json['reps'] as int? ?? 5,
      up: json['up'] as int? ?? 4,
      down: json['down'] as int? ?? 6,
      top: json['top'] as int? ?? 5,
      bottom: json['bottom'] as int? ?? 5,
      speed: json['speed'] as int? ?? 4,
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'bgm': instance.bgm,
      'reps': instance.reps,
      'up': instance.up,
      'down': instance.down,
      'top': instance.top,
      'bottom': instance.bottom,
      'speed': instance.speed,
    };
