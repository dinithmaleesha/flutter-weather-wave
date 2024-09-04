import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial()) {
    on<ChangeSplashDataFetchText>(_onChangeSplashDataFetchText);
  }

  Future<void> _onChangeSplashDataFetchText(
      ChangeSplashDataFetchText event,
      emit,
      ) async {
    emit(state.copyWith(splashText: event.text));
  }
}
