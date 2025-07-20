part of 'prompt_bloc.dart';

@immutable
sealed class PromptEvent {}

class PromptInitialEvent extends PromptEvent {}

class PromptEnterEvente extends PromptEvent {
  final String prompt;

  PromptEnterEvente({required this.prompt});
}
