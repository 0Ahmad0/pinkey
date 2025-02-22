import 'package:animate_do/animate_do.dart';
import 'package:pinkey/view/resourse/const_manager.dart';
import 'package:pinkey/view/resourse/string_manager.dart';
import 'package:pinkey/view/resourse/style_manager.dart';
import '../../../controller/auth_controller.dart';
import '../../book_course/book_course_view.dart';
import '/view/home/home_view.dart';
import '/view/navbar/navbar.dart';
import '/view/signup/signup_view.dart';
import '/view/manager/widgets/ShadowContainer.dart';
import '/view/manager/widgets/textformfiled_app.dart';
import '/view/resourse/assets_manager.dart';
import '/view/resourse/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../manager/widgets/button_app.dart';
import '../../resourse/color_manager.dart';

class LoginViewBody extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgetPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthController authController;

  LoginViewBody({required this.authController});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppPadding.p20),
          children: [
            const SizedBox(
              height: AppSize.s20,
            ),
            Text(
              AppStringsManager.welcome_back,
              style: getRegularStyle(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                  fontSize: 20.sp),
            ),
            const SizedBox(
              height: AppSize.s14,
            ),
            Text(
                authController.authProvider.text,
              //AppStringsManager.login_to_complete_book,
              style: getRegularStyle(
                  color: Theme.of(context).textTheme.subtitle2!.color,
                  fontSize: 12.sp),
            ),
            const SizedBox(
              height: AppSize.s30,
            ),
            Text(
                AppStringsManager.login_now,
              style: getRegularStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20.sp,
              ),
            ),
            const SizedBox(
              height: AppSize.s30,
            ),
            Text(
              AppStringsManager.phone_number + " " +AppStringsManager.or+ " "
                  +AppStringsManager.email ,
              style: getRegularStyle(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                  fontSize: 12.sp),
            ),

            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              controller: emailController,
                iconData: Icons.phone_android,
                hintText: AppStringsManager.type + " " +AppStringsManager.phone_number+ " " +AppStringsManager.or+ " "
                    +AppStringsManager.email ),
            const SizedBox(
              height: AppSize.s40,
            ),
            Text(
              AppStringsManager.password,
              style: getRegularStyle(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                  fontSize: 12.sp),

            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            TextFiledApp(
              controller: passwordController,
              iconData: Icons.lock,
              hintText: AppStringsManager.type + " " +AppStringsManager.password,
              obscureText: true,
              suffixIcon: true,
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      _showForgetPasswordDialog(context);
                    },
                    child: Text(
                      AppStringsManager.forget_password,
                      style: getRegularStyle(
                          color: Theme.of(context).textTheme.subtitle1!.color,
                          fontSize: 12.sp),
                    ))
              ],
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            ButtonApp(text: AppStringsManager.login, onPressed: () async {
              if(!formKey.currentState!.validate()){
                Get.snackbar("خطأ", "قم بملئ الحقول أولا");
              }else{
                await authController.login(context, email: emailController.text, password: passwordController.text);
              }
            }),
            const SizedBox(
              height: AppSize.s10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Get.off(() => const SignupView());
                    },
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                          text: AppStringsManager.do_not_have_account,
                          style: getRegularStyle(
                              color: Theme.of(context).textTheme.subtitle2!.color,
                              fontSize: 12.sp)),
                      TextSpan(
                          text: AppStringsManager.sign_up,
                          style: getRegularStyle(
                              color: Theme.of(context).textTheme.subtitle1!.color,
                              fontSize: 12.sp))
                    ])))
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showForgetPasswordDialog(BuildContext context) {
    Get.dialog(Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p20),
          margin: const EdgeInsets.all(AppMargin.m20),
          height: 25.h,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppSize.s14)),
          child: Column(
            children: [
              TextFiledApp(
                  controller: forgetPasswordController,
                  iconData: Icons.email,
                  hintText: AppStringsManager.recovery_email),
              Spacer(),
              ButtonApp(
                  textColor: ColorManager.white,
                  text: AppStringsManager.send,
                  onPressed: () async {
                    await authController.sendPasswordResetEmail(context, email: forgetPasswordController.text);
                    Get.back();
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
