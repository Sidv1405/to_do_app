import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkConnection {
  Future<bool> get isConnected;
}

class NetworkConnectionImpl implements NetworkConnection {
  final InternetConnectionChecker checker;

  NetworkConnectionImpl(this.checker);

  @override
  Future<bool> get isConnected => checker.hasConnection;
}
