import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_regex/flutter_regex.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/active/active_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/active/secondary_active_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> header() {
      return [
        Text(
          "Daftarkan Akun",
          style: appTextTheme(context).titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 22.0,
              ),
        ),
        const SizedBox(height: 10.0),
        Text(
          "Silahkan masukan data diri anda",
          style: appTextTheme(context).bodyMedium?.copyWith(
                color: AppColor.neutral[400],
              ),
        ),
      ];
    }

    Widget registerForm() {
      return ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          AppValidatorTextField(
            controller: nameController,
            hintText: "Ketik nama lengkap",
            labelText: "Nama Lengkap",
            withUpperLabel: true,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Isi nama lengkap";
              }
              return null;
            },
          ),
          const SizedBox(height: 18.0),
          AppValidatorTextField(
            controller: phoneController,
            hintText: "Ketik nomor lengkap",
            labelText: "Nomor Telepon",
            inputType: TextInputType.phone,
            withUpperLabel: true,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Isi nomor lengkap";
              }
              if (!value!.isPhone()) {
                return "Nomor tidak valid";
              }
              return null;
            },
          ),
          const SizedBox(height: 18.0),
          AppValidatorTextField(
            controller: emailController,
            hintText: "Ketik email",
            labelText: "Email",
            withUpperLabel: true,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Isi email";
              }
              if (!value!.isEmail()) {
                return "Email tidak valid";
              }
              return null;
            },
          ),
          const SizedBox(height: 18.0),
          BlocBuilder<ActiveCubit, bool>(
            builder: (context, state) {
              return AppValidatorTextField(
                controller: passwordController,
                labelText: "Password",
                withUpperLabel: true,
                isMandatory: false,
                isObscure: !state,
                hintText: "Masukan Kata Sandi",
                suffixWidget: IconButton(
                  icon: Icon(state ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    context.read<ActiveCubit>().toggle(!state);
                  },
                ),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "Isi password";
                  }
                  if (value!.length < 6) {
                    return "Minimal 6 karakter";
                  }
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 32.0),
        ],
      );
    }

    Widget toc() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: BlocBuilder<SecondaryActiveCubit, bool>(
              builder: (context, state) {
                return SizedBox(
                  height: 16.0,
                  width: 16.0,
                  child: Checkbox(
                    value: state,
                    checkColor: Colors.white,
                    onChanged: (value) {
                      context.read<SecondaryActiveCubit>().toggle(!state);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        "Dengan menekan tombol Masuk Atau Daftar, Berarti Anda menyetujui ",
                    style: appTextTheme(context).bodyMedium?.copyWith(
                          color: AppColor.neutral[400],
                        ),
                  ),
                  TextSpan(
                    text: "Syarat & Ketentuan ",
                    style: appTextTheme(context).bodyMedium?.copyWith(
                          color: AppColor.primary[600],
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  TextSpan(
                    text: "dan ",
                    style: appTextTheme(context).bodyMedium?.copyWith(
                          color: AppColor.neutral[400],
                        ),
                  ),
                  TextSpan(
                    text: "Kebijakan Privasi ",
                    style: appTextTheme(context).bodyMedium?.copyWith(
                          color: AppColor.primary[600],
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  TextSpan(
                    text: "kami.",
                    style: appTextTheme(context).bodyMedium?.copyWith(
                          color: AppColor.neutral[400],
                        ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    Widget submitButton() {
      return AppPrimaryFullButton(
        "Daftar",
        () {
          if (formKey.currentState!.validate()) {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            if (!context.read<SecondaryActiveCubit>().state) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Harap berikan persetujuan TOC"),
                backgroundColor: Colors.red,
              ));
              return;
            }
          }
        },
      );
    }

    Widget loginSection() {
      return InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Wrap(
          children: [
            Text(
              "Sudah Mempunyai Akun? ",
              textAlign: TextAlign.center,
              style: appTextTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Text(
              "Masuk",
              textAlign: TextAlign.center,
              style: appTextTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColor.primary[600],
                  ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 18.0),
            ...header(),
            const SizedBox(height: 32.0),
            Expanded(child: registerForm()),
            toc(),
            const SizedBox(height: 16.0),
            submitButton(),
            const SizedBox(height: 16.0),
            loginSection(),
            const SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }
}
