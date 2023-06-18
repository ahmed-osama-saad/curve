part of 'settings_bloc.dart';

@JsonSerializable()
class SettingsState {
  final Settings settings;

  SettingsState(this.settings);

  factory SettingsState.initial() => SettingsState(const Settings());

  SettingsState copyWith({
    Settings? settings,
  }) {
    return SettingsState(
      settings ?? this.settings,
    );
  }
}
