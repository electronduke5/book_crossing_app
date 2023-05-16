import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../data/models/user.dart';
import '../cubits/models_status.dart';
import '../cubits/profile/profile_cubit.dart';
import '../di/app_module.dart';

class SnackBarInfo {
  SnackBarInfo.show(
      {required BuildContext context,
      required String message,
      required bool isSuccess}) {
    final snackBar = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      content: Text(message),
      backgroundColor:
          isSuccess ? const Color.fromRGBO(15, 202, 122, 1) : Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  SnackBarInfo.showTop(
      {required BuildContext context,
      required String message,
      required bool isSuccess}) {
    final snackBar = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: 10,
        right: 10,
      ),
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static PersistentBottomSheetController<dynamic> addPhoneNumberSheet(BuildContext context, String title) {
    final _phoneMask = MaskTextInputFormatter(
        mask: '+7 (###) ###-##-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    TextEditingController phoneController = TextEditingController();
    final GlobalKey<FormState> phoneNumberFormKey = GlobalKey<FormState>();
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return Form(
                key: phoneNumberFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: phoneController,
                          inputFormatters: [_phoneMask],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Введите номер телефона';
                            }
                            return null;
                          },
                          maxLines: 1,
                          maxLength: 18,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: '+7 (000) 000-00-00',
                            labelText: 'Номер телефона',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (phoneNumberFormKey.currentState!.validate()) {
                            final phoneNumber = phoneController.value.text;
                            phoneController.clear();
                            await context
                                .read<ProfileCubit>()
                                .updateProfile(phoneNumber: phoneNumber)
                                .then((value) {
                              if(value != null){
                                AppModule.getProfileHolder().user = value;
                              }
                              SnackBarInfo.show(
                                  context: context,
                                  message: 'Номер телефона обновлен',
                                  isSuccess: true);
                              Navigator.of(context).pop();
                            });
                          }
                        },
                        child: () {
                          if (state.status is LoadingStatus<User>) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return const Text('Сохранить');
                        }(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
