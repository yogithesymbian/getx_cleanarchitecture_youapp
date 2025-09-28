import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:youapp_clean_architecture/app/modules/auth/domain/entities/user.dart';
import 'package:youapp_clean_architecture/app/modules/dashboard/services/dashboard_service.dart';

import '../../../../common/ui.dart';
import '../../../services/background/user_service.dart';

class DashboardController extends GetxController {
  AnyDashboardService dashboardService;
  DashboardController({required this.dashboardService});

  dynamic data = [];
  final loading = false.obs;
  final loadingMessage = ''.obs;
  final Rx<User> currentUser = Get.find<UserService>().user;

  @override
  void onInit() async {
    await fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      loading.value = true;
      loadingMessage.value = 'fetching-data';
      // data = await dashboardService.fetchData();
      Future.delayed(const Duration(seconds: 5));
    } on DioException catch (e) {
      Get.showSnackbar(Ui.errorSnackBar(message: e.message.toString()));
    } finally {
      loading.value = false;
      loadingMessage.value = '';
    }
  }
}
