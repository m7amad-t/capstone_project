import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'language_bloc_event.dart';
part 'language_bloc_state.dart';

class LanguageBloc extends HydratedBloc<LanguageBlocEvent, LanguageBlocState> {
  LanguageBloc() : super(const AppLanguageState(local: Locale('en'))) {
    on<ChangeLanguage>((event, emit) {
        emit(AppLanguageState(local: event.local));
    });
  }

  @override
  LanguageBlocState? fromJson(Map<String, dynamic> json) {
    final String key = json['language'];
    if (key == 'ku') {
      const Locale local = Locale('ku');
      return const AppLanguageState(local: local);
    } else if (key == 'en') {
      const Locale local = Locale('en');
      return const AppLanguageState(local: local);
    } else if (key == 'ar') {
      const Locale local = Locale('ar');
      return const AppLanguageState(local: local);
    } else {
      const Locale local = Locale('ku');
      return const AppLanguageState(local: local);
    }
  }

  @override
  Map<String, dynamic>? toJson(LanguageBlocState state) {
    return {"language": state.local.toString()};
  }
}
