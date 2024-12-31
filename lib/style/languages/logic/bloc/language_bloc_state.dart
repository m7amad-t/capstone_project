part of 'language_bloc_bloc.dart';

sealed class LanguageBlocState extends Equatable {
  final Locale local ; 
  const LanguageBlocState({required this.local});
  
  @override
  List<Object> get props => [local];
}

class AppLanguageState extends LanguageBlocState{
  const AppLanguageState({required super.local});
}
