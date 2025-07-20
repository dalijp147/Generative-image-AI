import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:aigenerativeimage/features/prompt/repos/prompt_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptInitialEvent>(promptInitialEvent);
    on<PromptEnterEvente>(promptEnterEvente);
  }
  FutureOr<void> promptEnterEvente(
    PromptEnterEvente event,
    Emitter<PromptState> emit,
  ) async {
    emit(PromptGeneratingImageLoadState());
    Uint8List? bytes = await PromptRepository.genrateImage(event.prompt);
    if (bytes != null) {
      emit(PromptGeneratingImageSucesState(bytes));
    } else {
      emit(PromptGeneratingImageErrorState());
    }
  }

  FutureOr<void> promptInitialEvent(
    PromptInitialEvent event,
    Emitter<PromptState> emit,
  ) async {
    Uint8List bytes = await rootBundle
        .load('assets/file.png')
        .then((value) => value.buffer.asUint8List());
    emit(PromptGeneratingImageSucesState(bytes));
  }
}
