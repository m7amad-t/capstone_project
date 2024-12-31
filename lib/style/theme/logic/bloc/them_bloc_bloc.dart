import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'them_bloc_event.dart';
part 'them_bloc_state.dart';

class ThemeBloc extends Bloc<ThemeBlocEvent, ThemeBlocState> {
  ThemeBloc() : super(const AppThemeData(mode: ThemeMode.light)) {
    on<ChangeTheme>((event, emit) {
      // get current theme mode
      final themeBrightness = Theme.of(event.context).brightness; 


      // check if current mode is dark  
      final bool isDark = themeBrightness == Brightness.dark;

      // toggle theme brightness mode.. (dark -> light) (light -> dark)
      ThemeMode themeMode = isDark ? ThemeMode.light : ThemeMode.dark;

      // send new mode to UI (rebuild UI)
      emit(AppThemeData(mode: themeMode));
    });
  }
}
