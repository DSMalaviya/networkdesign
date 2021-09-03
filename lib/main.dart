import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:networkdesign/networklayer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Networkavailability netaval = Networkavailability();
  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi) {
        netaval.networksink.add(networkstat.Mobile);
      } else if (event == ConnectivityResult.mobile) {
        netaval.networksink.add(networkstat.Wifi);
      } else if (event == ConnectivityResult.none) {
        netaval.networksink.add(networkstat.Disconnected);
      }
    });
  }

  @override
  void dispose() {
    netaval.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<Networkavailability>.value(
      value: netaval,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHome(),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    var providerdemo = context.watch<Networkavailability>();
    providerdemo.networkstream.listen((event) {
      if (event == networkstat.Disconnected) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Disconnected")));
        print("disconnected");
      } else if (event == networkstat.Mobile) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Mobile")));
        print("mobile");
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Wifi")));
        print("wifi");
      }
    });
    return Scaffold(
      body: Center(
        child: Text("network val"),
      ),
    );
  }
}
