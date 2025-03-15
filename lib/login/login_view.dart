import 'package:bloc_structure/common_widget/custom_svg_widget.dart';
import 'package:bloc_structure/common_widget/text_widget.dart';
import 'package:bloc_structure/routes/generate_routes.dart';
import 'package:bloc_structure/style_theme/app_dimension.dart';
import 'package:bloc_structure/style_theme/color_resource.dart';
import 'package:bloc_structure/style_theme/image_resource.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common_widget/asset_widget.dart';
import '../common_widget/body_widget.dart';
import '../common_widget/button_widget.dart';
import '../common_widget/text_input_widget.dart';
import '../form_bloc/bloc/form_bloc.dart';
import '../form_bloc/bloc/form_event.dart';
import '../form_bloc/bloc/form_state.dart';
import '../style_theme/string_resource.dart';
import '../app_utils/common_util_methods.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import '../login/bloc/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FormBloc>(create: (BuildContext context) =>
              FormBloc()
          ),
          BlocProvider<LoginBloc>(create: (BuildContext context) =>
          LoginBloc()..add(InitEvent(context: context))
          ),
        ],
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) => _buildPage(context),
        )
    );

  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    final formBloc = BlocProvider.of<FormBloc>(context);
    return CustomBodyWidget(
        loader: bloc.state.loader,
        child: SizedBox(
            width: 100.sw,
            height: 100.sh,
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20.dp, 25.dp, 20.dp, 15.dp),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: formBloc.formKey,
                            child: BlocBuilder<FormBloc, FormUiState>(
                              builder: (context, state) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10.dp,
                                    ),
                                    AssetImageWidget(
                                      assetName: ImageResource.logo,
                                      width: 150.dp,
                                      height: 150.dp,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 50.dp,
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
                                          hintText: "Email",
                                          maxLines: 1,
                                          onChanged: (value) {
                                            formBloc.add(EmailValidationEvent(value));
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
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Column(
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
                                    ),
                                    SizedBox(
                                      height: 15.dp,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CustomTextWidget(
                                        text: forgotPassword,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        textColor: ColorResource.lableColor,
                                        onTap: () {
                                          AppRouter.goPush(AppRouter.forgotpasswordPage);
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20.sp,bottom: 40.sp),
                                      child: CustomButton(
                                        text: loginButton,
                                        width: 100.sw,
                                        elevation: 2,
                                        height: 50,
                                        onTap: () {
                                          formBloc.add(UnfocusEvent());
                                          AppRouter.go(AppRouter.dashboardPage);
                                          if (formBloc.formKey.currentState!.validate()) {
                                            bloc.add(LoginSubmittedEvent(
                                                password: formBloc.state.password,
                                                email: formBloc.state.email
                                            ));
                                          }
                                        },
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: dontHaveAccount,
                                        style: TextStyle(
                                          color: ColorResource.lableColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: " $signUp",
                                            style: TextStyle(
                                              color: ColorResource.buttonColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                              AppRouter.goPush(AppRouter.signupPage);
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                          )
                          )
                        ],
                    ),
                ))));
  }
}
