import 'package:get/get.dart';
import 'package:youapp_clean_architecture/app/middlewares/auth_middleware.dart';

import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/presentation/views/login_view.dart';
import 'app_routes.dart';

class AppPages {
  static var INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
      name: Routes.ROOT,
      page: () => const RootView(),
      binding: RootBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
        name: Routes.LOGIN,
        page: () => const LoginView(),
        binding: AuthBinding()),
  ];
}
