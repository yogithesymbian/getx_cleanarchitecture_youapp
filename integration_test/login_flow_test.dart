import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_clean_architecture/app/services/background/local_storage_service.dart';
import 'package:youapp_clean_architecture/app/services/background/user_service.dart';
import 'package:youapp_clean_architecture/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // init for dependencies GetX manual for test
    await Get.putAsync(() => LocalStorageService().init());
    Get.put(UserService());
  });

  tearDownAll(() async {
    Get.reset();
  });

  /* MissingPluginException(No implementation found for method getAll on channel plugins.flutter.io/shared_preferences)  */
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    UserService().removeCurrentUser();
  });

  testWidgets('full login flow', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('emailField')),
      'yogi@yogiveloper.com',
    );
    await tester.enterText(
      find.byKey(const Key('usernameField')),
      'yogiveloper',
    );
    await tester.enterText(
      find.byKey(const Key('passwordField')),
      'password',
    );
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    // tester.binding.printTree();
    expect(find.byKey(const Key('dashboardTitle')), findsOneWidget);
    // expect(find.text('Dashboard'), findsOneWidget);
  });
}
