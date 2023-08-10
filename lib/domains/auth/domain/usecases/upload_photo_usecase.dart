import 'package:dartz/dartz.dart';
import 'package:chat_app/domains/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoUseCase extends UseCase<TaskSnapshot, XFile> {
  final AuthRepository authRepository;

  UploadPhotoUseCase({required this.authRepository});

  @override
  Future<Either<FailureResponse, TaskSnapshot>> call(XFile params) async =>
      await authRepository.uploadPhoto(photo: params);
}
