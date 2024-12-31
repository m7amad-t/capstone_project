part of 'language_bloc_bloc.dart';

sealed class LanguageBlocEvent extends Equatable {
  final Locale local ; 
  const LanguageBlocEvent({required this.local});

  @override
  List<Object> get props => [local];
}


class ChangeLanguage extends LanguageBlocEvent{
  const ChangeLanguage({required super.local});

}
