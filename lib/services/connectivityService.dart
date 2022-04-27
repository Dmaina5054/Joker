import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final _connectivity = Connectivity();
  late StreamController<ConnectivityResult> connectactivityStream =
      StreamController();

  ConnectivityService() {
    //check connect status and add event to strean
    _connectivity.onConnectivityChanged.listen((event) {
      connectactivityStream.add(event);
    });
  }
}
