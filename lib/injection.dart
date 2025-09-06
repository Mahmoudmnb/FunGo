import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:network_info/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;
Future<void> init() async {
  //! External packages
  sl.registerLazySingleton<Client>(() => Client());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo.instance);
  SharedPreferences sh = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sh);
}
