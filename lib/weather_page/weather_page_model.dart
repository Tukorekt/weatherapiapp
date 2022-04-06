import 'package:equatable/equatable.dart';

class WeatherData extends Equatable {
  final num dt;
  final num temp;
  final List weather;

  const WeatherData(
      {required this.dt, required this.temp, required this.weather});

  WeatherData.fromJson(Map<String, dynamic> json)
      : dt = json['current']['dt'],
        temp = json['current']['temp'],
        weather = json['hourly'];

  @override
  List<Object?> get props => [];
}
