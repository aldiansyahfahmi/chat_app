import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class UploadPhotoState extends Equatable {
  final ViewData<TaskSnapshot> uploadPhotoState;

  const UploadPhotoState({required this.uploadPhotoState});

  @override
  List<Object?> get props => [uploadPhotoState];
}
