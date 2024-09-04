part of 'app_bloc.dart';

class AppState extends Equatable {
  final String? splashText;

  AppState({required this.splashText});

  factory AppState.initial() {
    return AppState(splashText: "Initializing...");
  }

  AppState copyWith({
    String? splashText,
  }) {
    return AppState(splashText: splashText ?? this.splashText);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    splashText,
  ];
}
