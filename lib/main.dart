import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapiapp/cities_page/cities_page.dart';
import 'package:weatherapiapp/cities_page/cities_page_bloc.dart';
import 'package:weatherapiapp/weather_page/weather_page_bloc.dart';
import 'package:weatherapiapp/weather_page/weather_page_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'generated/l10n.dart';

String mainCityName = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  runApp(MaterialApp(
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    theme: ThemeData(
        cardColor: Colors.white,
        primaryColor: Colors.black,
        backgroundColor: Colors.white.withOpacity(.98),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            titleTextStyle:
                GoogleFonts.montserrat(fontSize: 25, color: Colors.white)),
        textTheme: TextTheme(
            bodyMedium:
                GoogleFonts.montserrat(fontSize: 20, color: Colors.black),
            bodyLarge: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
            titleMedium:
                GoogleFonts.montserrat(fontSize: 25, color: Colors.white),
            labelMedium:
                GoogleFonts.montserrat(fontSize: 20, color: Colors.white))),
    onGenerateRoute: (settings) {
      if (settings.name == '/cityWeatherDaily') {
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
                  create: (context) => WeatherPageBloc(),
                  child: WeatherPage(
                    cityName: settings.arguments as String,
                  ),
                ));
      } else {
        return null;
      }
    },
    debugShowCheckedModeBanner: false,
    title: 'WeatherApp',
    initialRoute: '/',
    routes: {
      '/': (_) => BlocProvider(
            create: (context) => CitiesPageBloc(),
            child: const CitiesPage(),
          ),
      '/cityWeatherDaily': (_) => BlocProvider(
            create: (context) => WeatherPageBloc(),
            child: WeatherPage(cityName: mainCityName),
          )
    },
  ));
}
