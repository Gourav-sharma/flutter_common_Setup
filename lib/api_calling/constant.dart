import 'package:get_storage/get_storage.dart';
import 'api_client.dart';

ApiClient apiClient = ApiClient();
GetStorage storage = GetStorage();

String baseUrl = "https://" ;

String loginAPI = "v1/Account/Login";
String forgotPasswordAPI = "v1/Account/ForgotPassword";