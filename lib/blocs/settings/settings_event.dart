part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class ChangeRepsSettingsEvent extends SettingsEvent {
  final int reps;

  ChangeRepsSettingsEvent(this.reps);
}

class ChangeSpeedSettingsEvent extends SettingsEvent {
  final int speed;

  ChangeSpeedSettingsEvent(this.speed);
}

class ChangeBottomSettingsEvent extends SettingsEvent {
  final int bottom;

  ChangeBottomSettingsEvent(this.bottom);
}

class ChangeTopSettingsEvent extends SettingsEvent {
  final int top;

  ChangeTopSettingsEvent(this.top);
}

class ChangeUpSettingsEvent extends SettingsEvent {
  final int up;

  ChangeUpSettingsEvent(this.up);
}

class ChangeDownSettingsEvent extends SettingsEvent {
  final int down;

  ChangeDownSettingsEvent(this.down);
}
