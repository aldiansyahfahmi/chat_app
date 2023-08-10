import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class UploadPhotoEvent extends Equatable {
  const UploadPhotoEvent();
}

class UploadPhoto extends UploadPhotoEvent {
  final XFile photo;

  const UploadPhoto({required this.photo});

  @override
  List<Object?> get props => [photo];
}
