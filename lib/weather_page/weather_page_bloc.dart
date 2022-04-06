import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapiapp/weather_page/weather_data_week_model.dart';
import 'package:weatherapiapp/weather_page/weather_page_model.dart';
import '../generated/l10n.dart';

part 'weather_page_event.dart';

part 'weather_page_state.dart';

class WeatherPageBloc extends Bloc<WeatherPageEvent, WeatherPageState> {
  WeatherPageBloc() : super(WeatherPageInitial()) {
    on<WeatherPageGetData>((event, emit) async {
      try {
        var cityLink =
            'http://api.openweathermap.org/data/2.5/weather?q=${event.city}&appid=5346e3aaf430e1ccb84c6e0af4867c27&lang=${S.current.lang}&units=metric';
        var response = await http.get(Uri.parse(cityLink));
        var respMap = jsonDecode(response.body);

        var link =
            'https://api.openweathermap.org/data/2.5/onecall?lat=${(respMap['coord']['lat'] as double)}&lon=${(respMap['coord']['lon'] as double)}&exclude=minutely,daily&appid=5346e3aaf430e1ccb84c6e0af4867c27&lang=${S.current.lang}&units=metric';
        var response2 = await http.get(Uri.parse(link));
        var respMap2 = jsonDecode(response2.body);

        var link2 =
            'https://api.openweathermap.org/data/2.5/onecall?lat=${(respMap['coord']['lat'] as double)}&lon=${(respMap['coord']['lon'] as double)}&exclude=minutely,hourly&appid=5346e3aaf430e1ccb84c6e0af4867c27&lang=${S.current.lang}&units=metric';
        var response3 = await http.get(Uri.parse(link2));
        var respMap3 = jsonDecode(response3.body);
        emit(WeatherPageData(
            weatherData: WeatherData.fromJson(respMap2),
            weatherDataWeek: WeatherDataWeek.fromJson(respMap3)));
      } catch (e) {
        emit(WeatherPageError());
      }
    });
  }
}
