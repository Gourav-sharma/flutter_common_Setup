import 'package:bloc_structure/dashboard/dashboard_view.dart';
import 'package:bloc_structure/list_page/list_page_view.dart';
import 'package:bloc_structure/login/login_view.dart';
import 'package:bloc_structure/main.dart';
import 'package:bloc_structure/signup/signup_view.dart';
import 'package:bloc_structure/splash/splash_view.dart';
import 'package:bloc_structure/app_utils/common_util_methods.dart';
import 'package:go_router/go_router.dart';

import '../forgot_password/forgot_password_view.dart';
import '../welcome/welcome_view.dart';


class AppRouter {

 static String splash = '/splash';
 static String loginPage = '/login';
 static String signupPage = '/signup';
 static String forgotpasswordPage = '/forgotpassword';
 static String welcomePage = '/welcomePage';
 static String profileSetupPage = '/profileSetupPage';
 static String dashboardPage = '/dashboard';
 static String listpage = '/listpage';

  static final GoRouter _router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>  SplashPage(),
      ),
      GoRoute(
        path: loginPage,
        builder: (context, state) =>  LoginPage(),
      ),
      GoRoute(
        path: signupPage,
        builder: (context, state) =>  SignupPage(),
      ),
      GoRoute(
        path: forgotpasswordPage,
        builder: (context, state) =>  ForgotPasswordPage(),
      ),
      GoRoute(
        path: welcomePage,
        builder: (context, state) =>  WelcomePage(),
      ),

      GoRoute(
        path: dashboardPage,
        builder: (context, state) =>  DashboardPage(),
      ),
      GoRoute(
        path: listpage,
        builder: (context, state) =>  ListPage(),
      ),
    ],
  );

  static GoRouter get router => _router;



  static Future<void> go(String location) async {
   await CommonUtilMethods.closeKeyboard(navigatorKey.currentState!.context);
    _router.go(location);
  }

  static Future<void> goNamed(String namedRoute) async {
   await CommonUtilMethods.closeKeyboard(navigatorKey.currentState!.context);
    _router.goNamed(namedRoute);
  }
  static Future<void> goPush(String namedRoute) async {
  await  CommonUtilMethods.closeKeyboard(navigatorKey.currentState!.context);
  await Future.delayed(Duration(milliseconds: 200));
    _router.push(namedRoute);
  }
  static Future<void> goBack() async {
   await CommonUtilMethods.closeKeyboard(navigatorKey.currentState!.context);
    _router.pop();
  }


}



