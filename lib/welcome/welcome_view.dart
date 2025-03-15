import 'package:bloc_structure/common_widget/button_widget.dart';
import 'package:bloc_structure/common_widget/custom_svg_widget.dart';
import 'package:bloc_structure/common_widget/text_widget.dart';
import 'package:bloc_structure/routes/generate_routes.dart';

import 'package:bloc_structure/style_theme/app_dimension.dart';
import 'package:bloc_structure/style_theme/color_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../common_widget/body_widget.dart';
import '../style_theme/image_resource.dart';
import 'bloc/welcome_bloc.dart';
import './bloc/welcome_event.dart';
import './bloc/welcome_state.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WelcomeBloc()..add(InitEvent()),
      child: BlocBuilder<WelcomeBloc, WelcomeState>(
        builder: (context, state) => _buildPage(context,state),
      )
    );
  }

  Widget _buildPage(BuildContext context, WelcomeState state) {

    return CustomBodyWidget(
      child: SizedBox(
        width: 100.sw,
        height: 100.sh,
        child:Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: CircularPercentIndicator(
                  radius: 140.sp/2-10,
                  lineWidth: 3.0,
                  percent: 0.5,
                  backgroundColor: ColorResource.borderColor,
                  progressColor: ColorResource.appThemeColor,
                  center:CustomSvgWidget(assetName: ImageResource.noProfileSvg,),
                ),
              ),
              SizedBox(
                height: 20.dp,
              ),
              CustomTextWidget(
                  text: "Welcome to App! ",
                  textColor: ColorResource.blackColor,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w400
              ),
              SizedBox(
                height: 10.dp,),
              CustomTextWidget(
                  text: "To make the most of your experience, please take a moment to set up your profile.",
                  textColor: ColorResource.blackColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center
              ),
              SizedBox(
                height: 20.dp,
              ),
              CustomButton(
                width: 100.sw,
                height: 50.dp,
                backgroundColor: ColorResource.appThemeColor,
                  text: "Complete Profile",
                  textColor: ColorResource.whiteColor,
                  fontSize: 16.sp,
                onTap:() {
                  AppRouter.go(AppRouter.profileSetupPage);
                },
              )
            ]
          ),
        )
      ),
    );
  }
}

