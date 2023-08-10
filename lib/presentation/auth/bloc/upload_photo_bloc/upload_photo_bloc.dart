import 'package:chat_app/domains/auth/domain/usecases/upload_photo_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'upload_photo_state.dart';
import 'upload_photo_event.dart';

class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  final UploadPhotoUseCase uploadPhotoUseCase;

  UploadPhotoBloc({required this.uploadPhotoUseCase})
      : super(
          UploadPhotoState(
            uploadPhotoState: ViewData.initial(),
          ),
        ) {
    on<UploadPhoto>(
      (event, emit) async {
        emit(
          UploadPhotoState(
            uploadPhotoState: ViewData.loading(),
          ),
        );
        final result = await uploadPhotoUseCase.call(event.photo);
        result.fold(
          (failure) async => emit(
            UploadPhotoState(
              uploadPhotoState: ViewData.error(
                message: failure.errorMessage,
                failure: failure,
              ),
            ),
          ),
          (result) async {
            emit(
              UploadPhotoState(
                uploadPhotoState: ViewData.loaded(data: result),
              ),
            );
          },
        );
      },
    );
  }
}
