part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class ToggleSFXSettingEvent extends SettingsEvent {}

class ToggleBgmSettingsEvent extends SettingsEvent {}

class ChangeRepsSettingsEvent extends SettingsEvent {
  final int reps;

  ChangeRepsSettingsEvent(this.reps);
}
