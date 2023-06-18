part of 'score_bloc.dart';

@immutable
class Score {
  const Score({required this.score});
  factory Score.initial() => const Score(score: 0);
  final int score;

  Score copyWith({
    int? score,
  }) {
    return Score(
      score: score ?? this.score,
    );
  }
}
