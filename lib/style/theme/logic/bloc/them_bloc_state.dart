part of 'them_bloc_bloc.dart';

sealed class ThemeBlocState extends Equatable {
  final ThemeMode mode; 
  const ThemeBlocState({required this.mode});
  
  @override
  List<Object> get props => [mode];
}


final class AppThemeData extends ThemeBlocState {
  const AppThemeData({required super.mode});

}
