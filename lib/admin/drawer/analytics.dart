import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late FirebaseAnalytics analytics;

  @override
  void initState() {
    super.initState();
    analytics = FirebaseAnalytics.instance;
    trackScreen();
  }

  void trackScreen() {
    analytics.setCurrentScreen(screenName: 'AnalyticsPage');
  }

  void trackCustomEvent() {
    analytics.logEvent(
      name: 'custom_event',
      parameters: {
        'param1': 'value1',
        'param2': 'value2',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics"),
        elevation: 0,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            trackCustomEvent();
          },
          child: const Text('Track Event'),
        ),
      ),
    );
  }
}
