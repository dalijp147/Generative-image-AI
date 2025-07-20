part of 'prompt_bloc.dart';

@immutable
sealed class PromptState {}

final class PromptInitial extends PromptState {}

final class PromptGeneratingImageLoadState extends PromptState {}

final class PromptGeneratingImageErrorState extends PromptState {}

final class PromptGeneratingImageSucesState extends PromptState {
  final Uint8List uint8List;
  PromptGeneratingImageSucesState(this.uint8List);
}
