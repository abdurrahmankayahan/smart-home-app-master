import 'package:smart360/service/navigation_service.dart';
import 'package:smart360/view/home_screen_view_model.dart';
import 'package:smart360/view/smart_ac_view_model.dart';
import 'package:smart360/view/smart_light_view_model.dart';
import 'package:smart360/view/smart_fan_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => HomeScreenViewModel());
  getIt.registerFactory(() => SmartLightViewModel());
  getIt.registerFactory(() => SmartACViewModel());
  getIt.registerFactory(() => SmartFanViewModel());
}
