import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'background_state.dart';

class BackgroundCubit extends Cubit<BackgroundState> {
  BackgroundCubit()
      : super(
          BackgroundState(
            backgroundColor: const Color(0xFFFFFBBF),
            colorWasChanged: false,
          ),
        );

  changeColor(Color color, bool changed) => emit(
        BackgroundState(
          backgroundColor: color,
          colorWasChanged: changed,
        ),
      );

  changeStateColorWasChanged(bool changed) => emit(
        BackgroundState(
          backgroundColor: state.backgroundColor,
          colorWasChanged: changed,
        ),
      );
}
