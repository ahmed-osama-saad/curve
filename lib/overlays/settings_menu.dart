import 'dart:ui';

import 'package:curve/blocs/settings/settings_bloc.dart';
import 'package:curve/curve_game.dart';
import 'package:curve/overlays/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// This represents the settings menu overlay.
class SettingsMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'SettingsMenu';

  // Reference to parent game.
  final CurveGame gameRef;

  const SettingsMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black.withAlpha(100),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocSelector<SettingsBloc, SettingsState, int>(
                      selector: (state) {
                        return state.settings.reps;
                      },
                      builder: (context, reps) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Number of reps $reps',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Slider(
                                  label: 'Number of reps $reps',
                                  value: reps.toDouble(),
                                  min: 0,
                                  max: 30,
                                  onChanged: (value) {
                                    context.read<SettingsBloc>().add(
                                        ChangeRepsSettingsEvent(value.toInt()));
                                  }),
                            ],
                          ),
                        );
                      },
                    ),
                    BlocSelector<SettingsBloc, SettingsState, int>(
                      selector: (state) {
                        return state.settings.speed;
                      },
                      builder: (context, speed) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Speed $speed',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Slider(
                                  value: speed.toDouble(),
                                  min: 0,
                                  max: 30,
                                  onChanged: (value) {
                                    context.read<SettingsBloc>().add(
                                        ChangeSpeedSettingsEvent(
                                            value.toInt()));
                                  }),
                            ],
                          ),
                        );
                      },
                    ),
                    BlocSelector<SettingsBloc, SettingsState, int>(
                      selector: (state) {
                        return state.settings.bottom;
                      },
                      builder: (context, bottom) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rest duration $bottom',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Slider(
                                  value: bottom.toDouble(),
                                  min: 0,
                                  max: 30,
                                  onChanged: (value) {
                                    context.read<SettingsBloc>().add(
                                        ChangeBottomSettingsEvent(
                                            value.toInt()));
                                  }),
                            ],
                          ),
                        );
                      },
                    ),
                    BlocSelector<SettingsBloc, SettingsState, int>(
                      selector: (state) {
                        return state.settings.up;
                      },
                      builder: (context, up) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Positive duration $up',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Slider(
                                  value: up.toDouble(),
                                  min: 0,
                                  max: 30,
                                  onChanged: (value) {
                                    context.read<SettingsBloc>().add(
                                        ChangeUpSettingsEvent(value.toInt()));
                                  }),
                            ],
                          ),
                        );
                      },
                    ),
                    BlocSelector<SettingsBloc, SettingsState, int>(
                      selector: (state) {
                        return state.settings.top;
                      },
                      builder: (context, top) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hold duration $top',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Slider(
                                  value: top.toDouble(),
                                  min: 0,
                                  max: 30,
                                  onChanged: (value) {
                                    context.read<SettingsBloc>().add(
                                        ChangeTopSettingsEvent(value.toInt()));
                                  }),
                            ],
                          ),
                        );
                      },
                    ),
                    BlocSelector<SettingsBloc, SettingsState, int>(
                      selector: (state) {
                        return state.settings.down;
                      },
                      builder: (context, down) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Negative duration $down',
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Slider(
                                  value: down.toDouble(),
                                  min: 0,
                                  max: 30,
                                  onChanged: (value) {
                                    context.read<SettingsBloc>().add(
                                        ChangeDownSettingsEvent(value.toInt()));
                                  }),
                            ],
                          ),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        gameRef.overlays.remove(SettingsMenu.id);
                        gameRef.overlays.add(MainMenu.id);
                      },
                      child: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
