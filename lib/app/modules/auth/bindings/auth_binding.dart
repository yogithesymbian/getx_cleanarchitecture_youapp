import 'package:get/get.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/datasources/auth_remote_datasource.dart';
import 'package:youapp_clean_architecture/app/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/usecase/login_usecase.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/usecase/register_usecase.dart';
import 'package:youapp_clean_architecture/app/modules/auth/presentation/controllers/register_controller.dart';
import 'package:youapp_clean_architecture/app/providers/dio_client.dart';

import '../presentation/controllers/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Core
    Get.lazyPut(() => DioClient());

    // Data layer
    Get.lazyPut<AuthRemoteDatasource>(
      () => AuthRemoteDataSourceImpl(Get.find<DioClient>()),
    );

    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find<AuthRemoteDatasource>()),
    );

    // Domain layer (usecase)
    Get.lazyPut(() => LoginUsecase(Get.find<AuthRepository>()));
    Get.lazyPut(() => RegisterUsecase(Get.find<AuthRepository>()));

    // Presentation layer (controller)
    Get.lazyPut(() => LoginController(Get.find<LoginUsecase>()));
    Get.lazyPut(() => RegisterController(Get.find<RegisterUsecase>()));
  }
}
// class AuthBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(() => DioClient());
//     Get.lazyPut<AuthRemoteDatasource>(
//       () => AuthRemoteDataSourceImpl(Get.find()),
//     );
//     Get.lazyPut(() => AuthRepositoryImpl(Get.find()));

//     Get.lazyPut(() => LoginUsecase(Get.find<AuthRepositoryImpl>()));
//     Get.lazyPut(() => LoginController(Get.find<LoginUsecase>()));

//     Get.lazyPut(() => RegisterUsecase(Get.find<AuthRepositoryImpl>()));
//     Get.lazyPut(() => RegisterController(Get.find<RegisterUsecase>()));
//   }
// }
