import 'package:bloc_structure/routes/generate_routes.dart';
import 'package:bloc_structure/style_theme/app_dimension.dart';
import 'package:bloc_structure/app_utils/common_util_methods.dart';
import 'package:bloc_structure/app_utils/notification_handling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import 'app_bloc/app_bloc.dart';
import 'app_bloc/app_bloc_event.dart';
import 'app_bloc/app_bloc_state.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();
  await GetStorage.init();
  runApp(
    BlocProvider(
      create: (BuildContext context) => AppBloc()..add(AppBlocInitEvent()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<AppBloc, AppBlocState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: AppRouter.router,
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: CommonUtilMethods.manageTheme(false),
              darkTheme: CommonUtilMethods.manageTheme(true),
              themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            );
          },
        );
      },
    );
  }
}


