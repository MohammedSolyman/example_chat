import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class BaseNetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements BaseNetworkInfo {
  final InternetConnectionChecker internetChecker;

  NetworkInfo({required this.internetChecker});

  @override
  Future<bool> get isConnected => internetChecker.hasConnection;
}
