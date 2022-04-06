import 'package:equatable/equatable.dart';

class WeatherDataWeek extends Equatable {
  final num dt;
  final num temp;
  final List weather;

  const WeatherDataWeek(
      {required this.dt, required this.temp, required this.weather});

  WeatherDataWeek.fromJson(Map<String, dynamic> json)
      : dt = json['current']['dt'],
        temp = json['current']['temp'],
        weather = json['daily'];

  @override
  List<Object?> get props => [];
}
