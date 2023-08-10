import 'package:chat_app/domains/user/domain/usecases/get_profile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import '/shared_libraries/utils/usecase/usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileCubit({required this.getProfileUseCase})
      : super(ProfileState(profileState: ViewData.initial()));

  void getProfile() async {
    emit(ProfileState(profileState: ViewData.loading()));
    final result = await getProfileUseCase.call(const NoParams());
    result.fold(
      (failure) => emit(
        ProfileState(
          profileState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        ProfileState(
          profileState: ViewData.loaded(
            data: result,
          ),
        ),
      ),
    );
  }
}
