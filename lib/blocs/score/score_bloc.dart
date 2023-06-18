import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'score_event.dart';
part 'score.dart';

class ScoreBloc extends Bloc<ScoreEvent, Score> {
  ScoreBloc() : super(Score.initial()) {
    on<IncreaseScoreEvent>((event, emit) {
      emit(state.copyWith(score: state.score + 1));
    });
    on<ResetScoreEvent>((event, emit) => emit(Score.initial()));
  }
}
