import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('===Change==${change.toString()}');
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('===Closed==${bloc.toString()}');
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint('==created=======${bloc.toString()}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('==ERooor===${error.toString()}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('=OnEvent====${event.toString()}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('==OnTransition===${transition.toString()}');
  }
}
