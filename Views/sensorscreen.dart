import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../Models/sensordata.dart';




// ignore: use_key_in_widget_constructors
class SensorTrackingPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SensorTrackingPageState createState() => _SensorTrackingPageState();
}

class _SensorTrackingPageState extends State<SensorTrackingPage> {
  final List<SensorData> _accelerometerData = [];
  final List<SensorData> _gyroscopeData = [];
  StreamSubscription? _accelerometerSubscription;
  StreamSubscription? _gyroscopeSubscription;

  @override
  void initState() {
    super.initState();

    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      setState(() {
        _accelerometerData.add(
          SensorData(event.x, event.y, event.z, DateTime.now()),
        );
      });
      _checkForAlert(event.x, event.y);
    });

    _gyroscopeSubscription = gyroscopeEventStream().listen((event) {
      setState(() {
        _gyroscopeData.add(
          SensorData(event.x, event.y, event.z, DateTime.now()),
        );
      });
      _checkForAlert(event.x, event.y);
    });
  }

  void _checkForAlert(double x, double y) {
    if (x.abs() > 8.0 && y.abs() > 8.0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("ALERT"),
            content: Text("Significant movement detected on two axes."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              )
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  List<charts.Series<SensorData, DateTime>> _createSensorSeries(
      List<SensorData> data, String id) {
    return [
      charts.Series<SensorData, DateTime>(
        id: id,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SensorData sensorData, _) => sensorData.timestamp,
        measureFn: (SensorData sensorData, _) => sensorData.x,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Tracking'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[50]
          ),
          child: Column(
            children: [
              Text("Gyro"),
              SizedBox(height: 20),
              Expanded(
                child: charts.TimeSeriesChart(
                  _createSensorSeries(_gyroscopeData, "Gyroscope"),
                  animate: true,
                ),
              ),
              Text("Accelerometer Sensor Data"),
              SizedBox(height: 20),

              Expanded(
                child: charts.TimeSeriesChart(
                  _createSensorSeries(_accelerometerData, "Accelerometer"),
                  animate: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
