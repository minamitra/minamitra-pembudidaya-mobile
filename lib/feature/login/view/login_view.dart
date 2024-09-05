import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_regex/flutter_regex.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/active/active_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/location_service/location_permission.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/dashboard/views/dashboard_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/logic/login_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/repositories/login_request.dart';
import 'package:minamitra_pembudidaya_mobile/feature/register/view/register_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    Widget headerSection() {
      return Expanded(
        flex: 3,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.circleImage),
              fit: BoxFit.fill,
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              AppAssets.logoIcon,
              height: 56.0,
            ),
          ),
        ),
      );
    }

    Widget fieldSection() {
      return Expanded(
        flex: 7,
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 32.0),
            Text(
              "Selamat Datang",
              textAlign: TextAlign.center,
              style: appTextTheme(context).titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 22.0,
                  ),
            ),
            const SizedBox(height: 12.0),
            Text(
              "Silahkan masuk ke akun anda",
              textAlign: TextAlign.center,
              style: appTextTheme(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColor.neutral[400],
                  ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppValidatorTextField(
                controller: emailController,
                labelText: "Email",
                withUpperLabel: true,
                isMandatory: false,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                hintText: "Masukan Email",
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Email tidak boleh kosong";
                  } else if (!value.contains("@")) {
                    return "Email tidak valid";
                  } else if (!value.isEmail()) {
                    return "Email tidak valid";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 18.0),
            BlocBuilder<ActiveCubit, bool>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: AppValidatorTextField(
                    controller: passwordController,
                    labelText: "Password",
                    withUpperLabel: true,
                    isMandatory: false,
                    isObscure: !state,
                    hintText: "Masukan Kata Sandi",
                    suffixWidget: IconButton(
                      icon:
                          Icon(state ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        context.read<ActiveCubit>().toggle(!state);
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
                  ),
                );
              },
            ),
            const SizedBox(height: 18.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Lupa Password ?",
                  textAlign: TextAlign.right,
                  style: appTextTheme(context).bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.primary[600],
                      ),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppPrimaryFullButton(
                "Masuk",
                () {
                  if (formKey.currentState!.validate()) {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    context.read<LoginCubit>().login(LoginRequest(
                          username: emailController.text,
                          password: passwordController.text,
                        ));
                    return;
                  }
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget bottomRegister() {
      return Wrap(
        children: [
          Text(
            "Belum Mempunyai Akun? ",
            textAlign: TextAlign.center,
            style: appTextTheme(context).bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(AppTransition.pushTransition(
                const RegisterPage(),
                RegisterPage.routeSettings,
              ));
            },
            child: Text(
              "Daftar",
              textAlign: TextAlign.center,
              style: appTextTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColor.primary[600],
                  ),
            ),
          ),
        ],
      );
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          headerSection(),
          fieldSection(),
          bottomRegister(),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
