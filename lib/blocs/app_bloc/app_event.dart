part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class ChangeSplashDataFetchText extends AppEvent {
  final String text;
  ChangeSplashDataFetchText(this.text);
}
