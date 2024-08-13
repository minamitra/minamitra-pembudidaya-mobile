import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/login/view/login_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/register/view/register_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class LoginRegisterView extends StatefulWidget {
  const LoginRegisterView({super.key});

  @override
  State<LoginRegisterView> createState() => _LoginRegisterViewState();
}

class _LoginRegisterViewState extends State<LoginRegisterView> {
  @override
  Widget build(BuildContext context) {
    Widget headerSection() {
      return Expanded(
        flex: 3,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.circleImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 5,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              AppAssets.logoIcon,
                              height: 56.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Image.asset(
                  AppAssets.fisherManImage,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget fieldSection() {
      return Expanded(
        flex: 2,
        child: Column(
          children: [
            const SizedBox(height: 24.0),
            Text(
              "Selamat Datang Mitra 3M",
              textAlign: TextAlign.center,
              style: appTextTheme(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
            ),
            const SizedBox(height: 12.0),
            Text(
              "Platform inovatif yang dirancang khusus untuk mendukung para petani ikan patin di OKU Timur",
              textAlign: TextAlign.center,
              style: appTextTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppPrimaryFullButton(
                "Masuk",
                () {
                  Navigator.of(context).push(AppTransition.pushTransition(
                    const LoginPage(),
                    LoginPage.route,
                  ));
                },
              ),
            ),
            const SizedBox(height: 18.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppPrimaryOutlineFullButton(
                "Daftar",
                () {
                  Navigator.of(context).push(AppTransition.pushTransition(
                    const RegisterPage(),
                    RegisterPage.routeSettings,
                  ));
                },
              ),
            ),
            const Expanded(child: SizedBox()),
            Text(
              "Koperasi Produsen Mina Mitra Mandiri",
              textAlign: TextAlign.center,
              style: appTextTheme(context).bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      );
    }

    return Column(
      children: [
        headerSection(),
        fieldSection(),
      ],
    );
  }
}
