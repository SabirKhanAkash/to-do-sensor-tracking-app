import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

class SensorTrackingScreen extends StatefulWidget {
  const SensorTrackingScreen({super.key});

  @override
  State<SensorTrackingScreen> createState() => _SensorTrackingScreenState();
}

class _SensorTrackingScreenState extends State<SensorTrackingScreen> {
  final List<FlSpot> _xData = [];
  final List<FlSpot> _yData = [];
  final List<FlSpot> _zData = [];

  final List<FlSpot> _accelXData = [];
  final List<FlSpot> _accelYData = [];
  final List<FlSpot> _accelZData = [];

  int _index = 0;
  final double threshold = 20.0;
  bool _isAlertPoppedUp = false;

  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  @override
  void initState() {
    super.initState();

    gyroscopeEventStream().listen((GyroscopeEvent event) {
      setState(() {
        _xData.add(FlSpot(_index.toDouble(), event.x));
        _yData.add(FlSpot(_index.toDouble(), event.y));
        _zData.add(FlSpot(_index.toDouble(), event.z));
        _index++;

        if (_xData.length > 100) _xData.removeAt(0);
        if (_yData.length > 100) _yData.removeAt(0);
        if (_zData.length > 100) _zData.removeAt(0);

        if ((event.x.abs() > threshold && event.y.abs() > threshold) ||
            (event.x.abs() > threshold && event.z.abs() > threshold) ||
            (event.y.abs() > threshold && event.z.abs() > threshold)) {
          if (!_isAlertPoppedUp) _showAlert("Gyro Sensor");
        }
      });
    });

    accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        _accelXData.add(FlSpot(_index.toDouble(), event.x));
        _accelYData.add(FlSpot(_index.toDouble(), event.y));
        _accelZData.add(FlSpot(_index.toDouble(), event.z));

        _index++;

        if (_accelXData.length > 100) _accelXData.removeAt(0);
        if (_accelYData.length > 100) _accelYData.removeAt(0);
        if (_accelZData.length > 100) _accelZData.removeAt(0);

        if ((event.x.abs() > threshold && event.y.abs() > threshold) ||
            (event.x.abs() > threshold && event.z.abs() > threshold) ||
            (event.y.abs() > threshold && event.z.abs() > threshold)) {
          if (!_isAlertPoppedUp) _showAlert("Accelerometer Sensor");
        }
      });
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void _showAlert(String sensorType) {
    _isAlertPoppedUp = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.lightWhite,
          surfaceTintColor: AppColors.lightWhite,
          title: const Text("ALERT"),
          content: Text("High movement detected on multiple axes of $sensorType!"),
          actions: [
            TextButton(
              onPressed: () {
                _isAlertPoppedUp = false;
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhite,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                        color: AppColors.lightWhite,
                        border: Border(
                          bottom: BorderSide(color: AppColors.grayLineColor, width: 1),
                          top: BorderSide(color: AppColors.grayLineColor, width: 1),
                          right: BorderSide(color: AppColors.grayLineColor, width: 1),
                          left: BorderSide(color: AppColors.grayLineColor, width: 1),
                        )),
                    margin: const EdgeInsets.only(top: 50),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Gyro",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                        color: AppColors.lightWhite,
                        border: Border(
                          bottom: BorderSide(color: AppColors.grayLineColor, width: 1),
                          top: BorderSide(color: AppColors.grayLineColor, width: 1),
                          right: BorderSide(color: AppColors.grayLineColor, width: 1),
                          left: BorderSide(color: AppColors.grayLineColor, width: 1),
                        )),
                    margin: const EdgeInsets.only(bottom: 20),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width - 20,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: _xData.isNotEmpty ? _xData : [const FlSpot(0, 0)],
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 2,
                            belowBarData: BarAreaData(show: false),
                          ),
                          LineChartBarData(
                            spots: _yData.isNotEmpty ? _yData : [const FlSpot(0, 0)],
                            isCurved: true,
                            color: Colors.green,
                            barWidth: 2,
                            belowBarData: BarAreaData(show: false),
                          ),
                          LineChartBarData(
                            spots: _zData.isNotEmpty ? _zData : [const FlSpot(0, 0)],
                            isCurved: true,
                            color: Colors.red,
                            barWidth: 2,
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                        titlesData: const FlTitlesData(show: true),
                        borderData: FlBorderData(show: true),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                        color: AppColors.lightWhite,
                        border: Border(
                          bottom: BorderSide(color: AppColors.grayLineColor, width: 1),
                          top: BorderSide(color: AppColors.grayLineColor, width: 1),
                          right: BorderSide(color: AppColors.grayLineColor, width: 1),
                          left: BorderSide(color: AppColors.grayLineColor, width: 1),
                        )),
                    margin: const EdgeInsets.only(top: 50),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Sensor Data",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                        color: AppColors.lightWhite,
                        border: Border(
                          bottom: BorderSide(color: AppColors.grayLineColor, width: 1),
                          top: BorderSide(color: AppColors.grayLineColor, width: 1),
                          right: BorderSide(color: AppColors.grayLineColor, width: 1),
                          left: BorderSide(color: AppColors.grayLineColor, width: 1),
                        )),
                    margin: const EdgeInsets.only(bottom: 20),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width - 20,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: _accelXData.isNotEmpty ? _accelXData : [const FlSpot(0, 0)],
                            isCurved: true,
                            color: Colors.red,
                            barWidth: 2,
                            belowBarData: BarAreaData(show: false),
                          ),
                          LineChartBarData(
                            spots: _accelYData.isNotEmpty ? _accelYData : [const FlSpot(0, 0)],
                            isCurved: true,
                            color: Colors.green,
                            barWidth: 2,
                            belowBarData: BarAreaData(show: false),
                          ),
                          LineChartBarData(
                            spots: _accelZData.isNotEmpty ? _accelZData : [const FlSpot(0, 0)],
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 2,
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                        titlesData: const FlTitlesData(show: true),
                        borderData: FlBorderData(show: true),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
