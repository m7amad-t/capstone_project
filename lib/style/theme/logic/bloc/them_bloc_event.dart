part of 'them_bloc_bloc.dart';

sealed class ThemeBlocEvent extends Equatable {
  final BuildContext context; 
  const ThemeBlocEvent({required this.context });

  @override
  List<Object> get props => [context];
}


class ChangeTheme extends ThemeBlocEvent {
 const ChangeTheme({required super.context});

}