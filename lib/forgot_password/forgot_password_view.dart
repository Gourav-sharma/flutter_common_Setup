import 'package:bloc_structure/common_widget/body_widget.dart';
import 'package:bloc_structure/style_theme/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common_widget/asset_widget.dart';
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
import 'package:bloc_structure/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:bloc_structure/forgot_password/bloc/forgot_password_event.dart';
import 'bloc/forgot_password_state.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<FormBloc>(create: (BuildContext context) =>
              FormBloc()
          ),
          BlocProvider<ForgotPasswordBloc>(create: (BuildContext context) =>
          ForgotPasswordBloc()..add(InitEvent())
          ),
        ],
        child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) => _buildPage(context,state),
        )
    );
  }

  Widget _buildPage(BuildContext context, ForgotPasswordState state) {
    final bloc = BlocProvider.of<ForgotPasswordBloc>(context);
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.dp,
                                  ),
                                  Center(
                                    child: AssetImageWidget(
                                      assetName: ImageResource.logo,
                                      width: 150.dp,
                                      height: 150.dp,
                                      fit: BoxFit.fill,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 50.dp,
                                  ),
                                  CustomTextWidget(
                                      text: forgotPassword,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w400,
                                      textColor: ColorResource.lableColor
                                  ),
                                  CustomTextWidget(
                                      text: forgotPasswordSubTitle,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      textColor: ColorResource.lableColor
                                  ),
                                  SizedBox(height: 20.sp),
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
                                    margin: EdgeInsets.only(top: 20.sp,bottom: 40.sp),
                                    child: CustomButton(
                                      text: submit,
                                      width: 100.sw,
                                      elevation: 2,
                                      height: 50,
                                      onTap: () {
                                        if (formBloc.formKey.currentState!.validate()) {
                                          bloc.add(ForgotPasswordSubmitEvent(
                                              email: formBloc.state.email
                                          ));
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                        )
                    )
                  ],
                ),
              ))),
    );
  }
}

