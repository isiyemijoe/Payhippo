import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:payhippo/_core_/data/local/local_storage.dart';
import 'package:payhippo/modules/authentication/splash/viewmodels/splash_viewmodel.dart';

import 'splash_viewmodel_test.mocks.dart';

@GenerateMocks([LocalStorageServiceImpl])
void main() {
  late final SplashViewModel viewModel;

  setUpAll(() async {
    viewModel =
        SplashViewModel(localStorageService: MockLocalStorageServiceImpl());
  });

  group("SplashScreen", () {
    test(
        'Test that value for isFirstLaunch is fetched from local storage correctly',
        () {
      //@Arrange
      when(viewModel.isFirstLaunch()).thenAnswer((realInvocation) => true);

      //@Act
      final isFirstLaunch = viewModel.isFirstLaunch();

      //@Assert
      expect(isFirstLaunch, true);
    });
  });

  group("SplashScreen", () {
    test('Test that countdown successfully return true after waiting', () {
      //@Arrange
      when(viewModel.countdown());

      //@Act
      final countdownStream = viewModel.countdown();

      //@Assert
      expect(countdownStream, emits(true));
    });
  });

  tearDownAll(() async {
    viewModel.dispose();
  });
}
