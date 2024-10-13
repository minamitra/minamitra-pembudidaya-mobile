import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/feature/change_password/logic/change_password_cubit.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget oldPasswordField() {
      return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
        builder: (context, state) {
          return AppValidatorTextField(
            controller: _oldPasswordController,
            labelText: "Password lama",
            withUpperLabel: true,
            isMandatory: true,
            isObscure: state.isObscureOldPassword,
            hintText: "Masukan Kata Sandi",
            suffixWidget: IconButton(
              icon: Icon(!state.isObscureOldPassword
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: () {
                context.read<ChangePasswordCubit>().onChangeObscure(
                    isObscureOldPassword: !state.isObscureOldPassword);
              },
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Password tidak boleh kosong";
              } else if (value.length < 6) {
                return "Password minimal 6 karakter";
              }
              return null;
            },
          );
        },
      );
    }

    Widget newPasswordField() {
      return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
        builder: (context, state) {
          return AppValidatorTextField(
            controller: _newPasswordController,
            labelText: "Password baru",
            withUpperLabel: true,
            isMandatory: true,
            isObscure: state.isObscureNewPassword,
            hintText: "Masukan Kata Sandi",
            suffixWidget: IconButton(
              icon: Icon(!state.isObscureNewPassword
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: () {
                context.read<ChangePasswordCubit>().onChangeObscure(
                    isObscureNewPassword: !state.isObscureNewPassword);
              },
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Password tidak boleh kosong";
              } else if (value.length < 6) {
                return "Password minimal 6 karakter";
              }
              return null;
            },
          );
        },
      );
    }

    Widget confirmNewPasswordField() {
      return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
        builder: (context, state) {
          return AppValidatorTextField(
            controller: _confirmPasswordController,
            labelText: "Konfirmasi password baru",
            withUpperLabel: true,
            isMandatory: true,
            isObscure: state.isObscureConfirmPassword,
            hintText: "Masukan Kata Sandi",
            suffixWidget: IconButton(
              icon: Icon(!state.isObscureConfirmPassword
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: () {
                context.read<ChangePasswordCubit>().onChangeObscure(
                    isObscureConfirmPassword: !state.isObscureConfirmPassword);
              },
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Password tidak boleh kosong";
              } else if (value.length < 6) {
                return "Password minimal 6 karakter";
              } else if (value != _newPasswordController.text) {
                return "Password tidak sama";
              }
              return null;
            },
          );
        },
      );
    }

    Widget body() {
      return ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 24.0),
          oldPasswordField(),
          const SizedBox(height: 18.0),
          newPasswordField(),
          const SizedBox(height: 18.0),
          confirmNewPasswordField(),
        ],
      );
    }

    Widget saveButton() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: AppPrimaryFullButton(
          "Simpan",
          () {
            if (_formKey.currentState!.validate()) {
              context.read<ChangePasswordCubit>().updatePassword(
                    _oldPasswordController.text,
                    _newPasswordController.text,
                  );
            }
            return null;
          },
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(child: body()),
            saveButton(),
          ],
        ),
      ),
    );
  }
}
