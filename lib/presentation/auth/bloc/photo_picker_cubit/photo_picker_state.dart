import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '/shared_libraries/utils/state/view_data_state.dart';

class PhotoPickerState extends Equatable {
  final ViewData<XFile> photoPickerState;

  const PhotoPickerState({required this.photoPickerState});

  @override
  List<Object?> get props => [photoPickerState];
}
