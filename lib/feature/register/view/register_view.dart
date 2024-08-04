import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
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

    List<Widget> registerForm() {
      return [
        AppValidatorTextField(
          controller: nameController,
          hintText: "Ketik nama lengkap",
          labelText: "Nama Lengkap",
          withUpperLabel: true,
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: phoneController,
          hintText: "Ketik nomor lengkap",
          labelText: "Nomor Telepon",
          inputType: TextInputType.phone,
          withUpperLabel: true,
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: emailController,
          hintText: "Ketik email",
          labelText: "Email",
          withUpperLabel: true,
        ),
        const SizedBox(height: 18.0),
        AppValidatorTextField(
          controller: passwordController,
          labelText: "Password",
          withUpperLabel: true,
          isMandatory: false,
          hintText: "Masukan Kata Sandi",
          suffixWidget: IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 32.0),
      ];
    }

    Widget toc() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: SizedBox(
              height: 16.0,
              width: 16.0,
              child: Checkbox(
                value: true,
                checkColor: Colors.white,
                onChanged: (value) {},
              ),
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
        () {},
      );
    }

    Widget loginSection() {
      return Wrap(
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
            ...registerForm(),
            const Expanded(flex: 3, child: SizedBox()),
            toc(),
            const Expanded(flex: 2, child: SizedBox()),
            submitButton(),
            const Expanded(flex: 2, child: SizedBox()),
            loginSection(),
            const SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }
}
