import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopping_app/data/controllers/form_controllers.dart';
import 'package:shopping_app/data/helpers/style_helper.dart';
import 'package:shopping_app/data/helpers/validation_helper.dart';
import 'package:shopping_app/data/provider/global_provider.dart';
import 'package:shopping_app/data/provider/onboarding/onboarding_provider.dart';
import 'package:shopping_app/data/utils/notify_user.dart';
import 'package:shopping_app/view/widgets/appbutton.dart';
import 'package:shopping_app/view/widgets/appformfield.dart';
import 'package:shopping_app/data/utils/spacer.dart';
import 'package:shopping_app/view/presentation/dashboard_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final onBoardingVm = ref.watch(onboardingViewModel);
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: EdgeInsets.only(
              left: 20.w, top: 20.h, right: 20.w, bottom: 30.18.h),
          child: SingleChildScrollView(
            child: Form(
              key: signUpFormKey,
              child: Column(
                children: [
                  Image.asset(
                      width: 54, height: 62, "assets/images/app_logo.png"),
                  SpacerUtil.hspace(20.h),
                  Text(
                    "Sign Up",
                    style: Styles.mediumText(),
                  ),
                  SpacerUtil.hspace(33.h),
                  AppFormField(
                    isObscure: false,
                    validator: (data) => ValidationHelper.isValidInput(data!),
                    controller: sUsername,
                    image: "Profile.png",
                    title: "Name",
                  ),
                  SpacerUtil.hspace(16.h),
                  AppFormField(

                    isObscure: false,
                    validator: (data) => ValidationHelper.isValidEmail(data!),
                    controller: sEmail,
                    image: "Message.png",
                    title: "Email",
                  ),
                  SpacerUtil.hspace(16.h),
                  AppFormField(

                    isObscure: false,
                    validator: (data) => ValidationHelper.isValidInput(data!),
                    controller: sPassword,
                    image: "Lock.png",
                    title: "Password",
                  ),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: Checkbox(
                            activeColor: const Color(0xffF67952),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r)),
                            value: ref.watch(isCheckedProvider),
                            onChanged: (value) {
                              ref.read(isCheckedProvider.notifier).state =
                                  value as bool;
                            }),
                      ),
                      RichText(
                          text: TextSpan(
                        style: Styles.smallText(color: Colors.grey),
                        children: <TextSpan>[
                          const TextSpan(text: "I accept to all the "),
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            text: 'Terms & Condition',
                            style: Styles.smallText(
                                color: const Color(0xff230a06)),
                          ),
                        ],
                      )),
                    ],
                  ),
                  AppButton(
                      isLoading: onBoardingVm.signUpData.loading,
                      title: "Sign Up",
                      function: ref.watch(isCheckedProvider)
                          ? () async {
                              if (signUpFormKey.currentState!.validate()) {
                                final success = await ref
                                    .read(onboardingViewModel)
                                    .signUp(
                                        username: sUsername.text,
                                        password: sPassword.text,
                                        email: sEmail.text);
                                if (!success) {
                                  NotifyUser.showAlert(
                                      "An Error Occured while Signing Up");
                                } else {
                                  NotifyUser.showAlert("Sign Up Successful");
                                  Get.to(() => const DashBoardScreen());
                                }
                              } else {
                                return;
                              }
                            }
                          : null,
                      isLarge: false),
                  SpacerUtil.hspace(50.h),
                  SizedBox(
                    width: 200.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: const Text("Or"),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SpacerUtil.hspace(43.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          width: 70.88,
                          height: 70.88,
                          "assets/images/fb_logo.png"),
                      Image.asset(
                          width: 70.88,
                          height: 70.88,
                          "assets/images/google_logo.png")
                    ],
                  ),
                  SpacerUtil.hspace(10.h),
                  RichText(
                      text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                    children: <TextSpan>[
                      const TextSpan(text: "Already have an account? "),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.back();
                          },
                        text: 'Log In',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

final payload = {
  "email": sEmail.text,
  " username": sUsername.text,
  "password": sPassword.text,
  "name": {"firstname": 'John', "lastname": 'Doe'},
  " address": {
    " city": 'kilcoole',
    "street": '7835 new road',
    "number": 3,
    "zipcode": '12926-3874',
    "geolocation": {"lat": '-37.3159', "long": '81.1496'}
  },
  "phone": '1-570-236-7033'
};
