part of 'weather_page_bloc.dart';

abstract class WeatherPageEvent extends Equatable {
  const WeatherPageEvent();
}

class WeatherPageGetData extends WeatherPageEvent {
  final String city;

  const WeatherPageGetData({required this.city});

  @override
  List<Object?> get props => [];
}
