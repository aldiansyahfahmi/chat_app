import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'photo_picker_state.dart';

class PhotoPickerCubit extends Cubit<PhotoPickerState> {
  PhotoPickerCubit()
      : super(PhotoPickerState(photoPickerState: ViewData.loaded(data: null)));

  void pickPhoto() async {
    final ImagePicker picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      emit(
        PhotoPickerState(
          photoPickerState: ViewData.loaded(
            data: result,
          ),
        ),
      );
    }
  }
}
