part of 'score_bloc.dart';

@immutable
abstract class ScoreEvent {}

class IncreaseScoreEvent extends ScoreEvent {}

class ResetScoreEvent extends ScoreEvent {}
