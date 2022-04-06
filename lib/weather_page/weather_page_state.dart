part of 'weather_page_bloc.dart';

abstract class WeatherPageState extends Equatable {
  const WeatherPageState();
}

class WeatherPageInitial extends WeatherPageState {
  @override
  List<Object> get props => [];
}

class WeatherPageData extends WeatherPageState {
  final WeatherData weatherData;
  final WeatherDataWeek weatherDataWeek;

  const WeatherPageData(
      {required this.weatherData, required this.weatherDataWeek});

  @override
  List<Object> get props => [weatherData, weatherDataWeek];
}

class WeatherPageError extends WeatherPageState {
  @override
  List<Object?> get props => [];
}
