import 'package:chat_app/shared_libraries/component/text_field/bloc/custom_text_field_state.dart';
import 'package:chat_app/shared_libraries/utils/state/view_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextFieldCubit extends Cubit<CustomTextFieldState> {
  CustomTextFieldCubit()
      : super(
          CustomTextFieldState(
            customTextFieldState: ViewData.initial(),
          ),
        );

  void isSecureText({required bool isSecured}) {
    emit(
      CustomTextFieldState(
        customTextFieldState: ViewData.loaded(data: !isSecured),
      ),
    );
  }
}
