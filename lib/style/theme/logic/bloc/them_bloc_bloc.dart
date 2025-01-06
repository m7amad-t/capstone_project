import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'them_bloc_event.dart';
part 'them_bloc_state.dart';

class ThemeBloc extends HydratedBloc<ThemeBlocEvent, ThemeBlocState> {
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
  
  @override
  ThemeBlocState? fromJson(Map<String, dynamic> json) {
   if(json['themeMode']==1){
    return const AppThemeData(mode: ThemeMode.light); 
   } else {
    return const AppThemeData(mode: ThemeMode.dark); 

   }
  }
  
  @override
  Map<String, dynamic>? toJson(ThemeBlocState state) {
    if(state is AppThemeData){
      if(state.mode == ThemeMode.light){
        return {'themeMode': 1};
      }else {
        return {'themeMode': 0};
      }
    }

    return {'themeMode': 1};
  }
}
