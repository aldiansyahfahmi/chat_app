import 'package:equatable/equatable.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class SplashState extends Equatable {
  final ViewData splashState;

  const SplashState({required this.splashState});

  @override
  List<Object?> get props => [splashState];
}
