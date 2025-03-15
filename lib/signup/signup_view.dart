
import 'package:bloc_structure/common_widget/custom_file_widget.dart';
import 'package:bloc_structure/style_theme/app_dimension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common_widget/body_widget.dart';
import '../common_widget/button_widget.dart';
import '../common_widget/custom_svg_widget.dart';
import '../common_widget/text_input_widget.dart';
import '../common_widget/text_widget.dart';
import '../form_bloc/bloc/form_bloc.dart';
import '../form_bloc/bloc/form_event.dart';
import '../form_bloc/bloc/form_state.dart';
import '../routes/generate_routes.dart';
import '../style_theme/color_resource.dart';
import '../style_theme/image_resource.dart';
import '../style_theme/string_resource.dart';
import '../app_utils/common_util_methods.dart';
import 'bloc/signup_bloc.dart';
import '../signup/bloc/signup_event.dart';
import 'bloc/signup_state.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FormBloc>(create: (BuildContext context) =>
              FormBloc()
          ),
          BlocProvider<SignupBloc>(create: (BuildContext context) =>
               SignupBloc()..add(InitEvent(context: context))
          ),
        ],
        child: BlocBuilder<SignupBloc, SignupState>(
          builder: (context, state) => _buildPage(context),
         )
        );

  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<SignupBloc>(context);
    final formBloc = BlocProvider.of<FormBloc>(context);

    return CustomBodyWidget(
      showAppBar: true,
      backIcon: true,
      loader: bloc.state.loader,
      backIconTap: () {
        AppRouter.goBack();
      },
      child: SizedBox(
        width: 100.sw,
        height: 100.sh,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20.dp, right: 20.dp, top: 20.dp, bottom:MediaQuery.of(context).viewInsets.bottom+30.dp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: formBloc.formKey,
                child: BlocBuilder<FormBloc, FormUiState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          state.profileImagePath == null ?
                          Center(
                            child: GestureDetector(
                                onTap: () {
                                },
                                child: CustomSvgWidget(assetName: ImageResource.photoUploadSvg,height: 150.dp, width: 100.dp,)),
                          )
                              : Center(
                                child: CustomFileWidget(
                                filePath: state.profileImagePath,
                                height: 150.dp,
                                width: 150.dp,
                                                            ),
                              ),
                          SizedBox(height: 20.sp,),
                          CustomTextWidget(
                              text: signUp,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w400,
                              textColor: ColorResource.blackColor
                          ),
                          SizedBox(height: 20.sp,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                  text: fNameLable,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  textColor: ColorResource.lableColor
                              ),
                              SizedBox(height: 5.sp),
                              CustomTextFormField(
                                focusNode: formBloc.state.firstNameFocusNode,
                                hintText: fNameLable,
                                onChanged: (value) {
                                  formBloc.add(FirstNameEvent(value));
                                },
                                borderColor: Colors.grey,
                                validator: (value) {
                                  if (CommonUtilMethods.isValueEmpty(
                                      value ?? "")) {
                                    return firstNameValidationMessage;
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.dp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                  text: lNameLable,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  textColor: ColorResource.lableColor
                              ),
                              SizedBox(height: 5.sp),
                              CustomTextFormField(
                                focusNode: formBloc.state.lastNameFocusNode,
                                hintText: lNameLable,
                                onChanged: (value) {
                                  formBloc.add(LastNameEvent(value));
                                },
                                borderColor: Colors.grey,
                                validator: (value) {
                                  if (CommonUtilMethods.isValueEmpty(
                                      value ?? "")) {
                                    return firstNameValidationMessage;
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.dp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                  text: emailHint,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  textColor: ColorResource.lableColor
                              ),
                              SizedBox(height: 5.sp),
                              CustomTextFormField(
                                focusNode: formBloc.state.emailFocusNode,
                                hintText: emailHint,
                                onChanged: (value) {
                                  formBloc.add(EmailValidationEvent(value));
                                  // bloc.add(UsernameChangedEvent(value));
                                },
                                borderColor: Colors.grey,
                                prefixWidget: Padding(
                                  padding:  EdgeInsets.only(right: 10.sp, left: 10.sp),
                                  child: CustomSvgWidget(assetName: ImageResource.smsSvg),
                                ),
                                validator: (value) {
                                  if (CommonUtilMethods.isValueEmpty(
                                      value ?? "")) {
                                    return emailValidationMessage;
                                  } else if (!CommonUtilMethods
                                      .isEmailValid(value!)) {
                                    return emailValidationMessage2;
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.dp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                  text: passwordHint,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  textColor: ColorResource.lableColor
                              ),
                              SizedBox(height: 5.sp),
                              CustomTextFormField(
                                focusNode: formBloc.state.passwordFocusNode,
                                hintText: "Password",
                                showPassword: formBloc.state.isPassword,
                                isPassword: true,
                                onChanged: (value) {
                                  formBloc.add(PasswordValidationEvent(value));
                                },
                                borderColor: Colors.grey,
                                prefixWidget: Padding(
                                  padding:  EdgeInsets.only(right: 10.sp, left: 10.sp),
                                  child: CustomSvgWidget(assetName: ImageResource.passwordSvg),
                                ),
                                suffixWidget: Padding(
                                  padding:  EdgeInsets.only(right: 15.sp, left: 10.sp),
                                  child: CustomSvgWidget(assetName: formBloc.state.isPassword == false ? ImageResource.eyeOpenSvg : ImageResource.eyeCloseSvg),
                                ),
                                suffixTap: () {
                                  formBloc.add(OnPasswordTap(showPassword: formBloc.state.isPassword == false ? true : false));
                                },
                                validator: (value) {
                                  if (CommonUtilMethods.isValueEmpty(
                                      value ?? "")) {
                                    return passwordValidationMessage;
                                  } else if (!CommonUtilMethods
                                      .isPasswordValid(value!)) {
                                    return passwordLengthValidationMessage;
                                  }
                                  return null;
                                },
                              ),

                            ],
                          ),

                          SizedBox(
                            height: 10.dp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                  text: confirmPasswordHint,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  textColor: ColorResource.lableColor
                              ),
                              SizedBox(height: 5.sp),
                              CustomTextFormField(
                                focusNode: formBloc.state.confirmPasswordFocusNode,
                                hintText: confirmPasswordHint,
                                showPassword: formBloc.state.isConfirmPassword,
                                isPassword: true,
                                onChanged: (value) {
                                  formBloc.add(ConfirmPasswordValidationEvent(value));
                                },
                                borderColor: Colors.grey,
                                prefixWidget: Padding(
                                  padding:  EdgeInsets.only(right: 10.sp, left: 10.sp),
                                  child: CustomSvgWidget(assetName: ImageResource.passwordSvg),
                                ),
                                isSuffixShow: true,
                                suffixWidget: Padding(
                                  padding:  EdgeInsets.only(right: 15.sp, left: 10.sp),
                                  child: CustomSvgWidget(assetName: formBloc.state.isConfirmPassword == false ? ImageResource.eyeOpenSvg : ImageResource.eyeCloseSvg),
                                ),
                                suffixTap: () {
                                  formBloc.add(ConfirmPasswordTapEvent(showConfirmPassword: formBloc.state.isConfirmPassword == false ? true : false));
                                },
                                validator: (value) {
                                  if (CommonUtilMethods.isValueEmpty(
                                      value ?? "")) {
                                    return confirmPasswordValidationMessage;
                                  } else if (!CommonUtilMethods
                                      .isConfirmPasswordValid(formBloc.state.password??"",value!)) {
                                    return confirmPasswordValidationMessage2;
                                  }
                                  return null;
                                },
                              ),

                            ],
                          ),
                          SizedBox(height: 30,),
                          CustomButton(
                              text: submit,
                              onTap: () {
                                if(formBloc.formKey.currentState!.validate()){
                                  bloc.add(
                                      SubmitEvent(
                                         firstName:  formBloc.state.firstName,
                                         lastName: formBloc.state.lastName,
                                         email: formBloc.state.email,
                                         password: formBloc.state.password,
                                         confirmPassword: formBloc.state.confirmPassword)
                                      );
                                }
                              },
                              height: 50,
                              width: 100.sw,
                              elevation: 10
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.dp),
                            child:RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "By signing up, I agree to App ",
                                style: TextStyle(
                                  color: ColorResource.lableColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: " Terms of Service",
                                    style: TextStyle(
                                      color: ColorResource.buttonColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                      },
                                  ),
                                  TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      color: ColorResource.lableColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " Privacy Policy",
                                    style: TextStyle(
                                      color: ColorResource.buttonColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

