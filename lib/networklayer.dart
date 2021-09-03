import 'dart:async';

enum networkstat {
  Mobile,
  Wifi,
  Disconnected,
}

class Networkavailability {
  StreamController<networkstat> _networkstateController =
      StreamController<networkstat>.broadcast();

  StreamSink get networksink => _networkstateController.sink;
  Stream get networkstream => _networkstateController.stream;

  addconnectionStatus(networkstat data) {
    networksink.add(data);
  }

  dispose() {
    _networkstateController.close();
  }
}
