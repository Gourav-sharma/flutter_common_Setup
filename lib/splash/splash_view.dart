
import 'package:bloc_structure/style_theme/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_widget/asset_widget.dart';
import '../common_widget/body_widget.dart';
import '../style_theme/image_resource.dart';
import 'bloc/splash_bloc.dart';
import '../splash/bloc/splash_event.dart';
import 'bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => SplashBloc()..add(InitEvent()),
      child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {

    return CustomBodyWidget(
      appBarHeight: 0.0,
      child: SizedBox(
        width: 100.sw,
        height: 100.sh,
        child: Center(
            child: AssetImageWidget(
              assetName: ImageResource.logo,
              width: 60.sw,
              height: 30.sh,
              fit: BoxFit.fill,
            )
        ),
      ),

    );
  }
}

