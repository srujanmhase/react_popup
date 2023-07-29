part of 'reaction_bloc.dart';

class ReactionState {
  const ReactionState({
    required this.isReactionsTrayOpen,
    required this.react,
    required this.close,
  });
  final bool isReactionsTrayOpen;
  final bool react;
  final bool close;
}
