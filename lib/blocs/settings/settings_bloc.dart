import 'package:curve/blocs/settings/settings_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.g.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState.initial()) {
    on<ChangeRepsSettingsEvent>(
      (event, emit) {
        final newSettings = state.settings.copyWith(reps: event.reps);
        emit(SettingsState(newSettings));
      },
    );
    on<ChangeBottomSettingsEvent>(
      (event, emit) {
        final newSettings = state.settings.copyWith(bottom: event.bottom);
        emit(SettingsState(newSettings));
      },
    );
    on<ChangeTopSettingsEvent>(
      (event, emit) {
        final newSettings = state.settings.copyWith(top: event.top);
        emit(SettingsState(newSettings));
      },
    );
    on<ChangeUpSettingsEvent>(
      (event, emit) {
        final newSettings = state.settings.copyWith(up: event.up);
        emit(SettingsState(newSettings));
      },
    );
    on<ChangeDownSettingsEvent>(
      (event, emit) {
        final newSettings = state.settings.copyWith(down: event.down);
        emit(SettingsState(newSettings));
      },
    );
  }

  @override
  fromJson(Map<String, dynamic> json) => _$SettingsStateFromJson(json);

  @override
  Map<String, dynamic> toJson(SettingsState state) =>
      _$SettingsStateToJson(state);
}
