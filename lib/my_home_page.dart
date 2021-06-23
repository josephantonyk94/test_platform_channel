import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<void> _launchUrl() async {
    String batteryLevel;
    try {
      await platform.invokeMethod('launchUrl');
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
  }

  Future<void> _openMain() async {
    try {
      /// SHOULD RETURN MAIN ACTIVITY ANDROID SIDE

      await platform.invokeMethod('openMain');
    } on PlatformException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'the battery level is $_batteryLevel',
            ),
            TextButton(
              onPressed: () => _getBatteryLevel(),
              child: Text(
                'get Battery level',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            TextButton(
              onPressed: () => _launchUrl(),
              child: Text(
                'launch url',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            TextButton(
              onPressed: () => _openMain(),
              child: Text(
                'open Main',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
