import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapiapp/weather_page/weather_page_bloc.dart';

import '../generated/l10n.dart';
import '../main.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key, required this.cityName}) : super(key: key);

  final String cityName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                S.load(Locale.fromSubtags(
                    languageCode: S.current.lang == 'ru' ? 'en' : 'ru'));
                Navigator.popAndPushNamed(context, '/cityWeatherDaily');
              },
              child: Text(
                S.current.lang,
                style: Theme.of(context).textTheme.labelMedium,
              ))
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title:
            Text(cityName, style: Theme.of(context).appBarTheme.titleTextStyle),
      ),
      body: BlocBuilder<WeatherPageBloc, WeatherPageState>(
        builder: (context, state) {
          if (state is WeatherPageData) {
            return Center(
              child: Stack(
                children: [
                  Positioned(
                      bottom: size.height * .07,
                      child: Container(
                        height: size.height * .75,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 24,
                              itemBuilder: (_, number) {
                                var date = DateTime.fromMillisecondsSinceEpoch(
                                    state.weatherData.weather[number]['dt'] *
                                        1000);
                                var hour = date.hour;
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text('$hour:00',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge),
                                          Text(
                                              '${S.current.temp}.: ${state.weatherData.weather[number]['temp']}C',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          Text(
                                              '${S.current.desc}: ${state.weatherData.weather[number]['weather'][0]['description']}',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium)
                                        ],
                                      ),
                                    ));
                              }),
                        ),
                      )),
                  Positioned(
                      top: 0,
                      child: SizedBox(
                        width: size.width,
                        height: size.height * .1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * .66,
                              child: TextField(
                                decoration: InputDecoration.collapsed(
                                    hintText: S.current.searchOther,
                                    hintStyle:
                                        Theme.of(context).textTheme.bodyMedium),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                                onTap: () {
                                  Navigator.pushNamed(context, '/');
                                },
                                onSubmitted: (data) {
                                  mainCityName = data;
                                  Navigator.pushNamed(
                                      context, '/cityWeatherDaily');
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                      left: size.width * .25,
                      bottom: size.height * .01,
                      child: GestureDetector(
                        onTap: () {
                          showBottomSheet(
                              context: context,
                              enableDrag: true,
                              builder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.arrow_downward,
                                          size: 25,
                                        )),
                                    Container(
                                      height: size.height * .8,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: 7,
                                          itemBuilder: (_, number) {
                                            var date = DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    state.weatherDataWeek
                                                                .weather[number]
                                                            ['dt'] *
                                                        1000);
                                            var hour = date.day;
                                            var month = date.month;
                                            return Container(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text('$hour.$month',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge),
                                                  Text(
                                                      '${S.current.temp}.: ${state.weatherDataWeek.weather[number]['temp']['day']}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  Text(
                                                      '${S.current.desc}: ${state.weatherDataWeek.weather[number]['weather'][0]['description']}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium)
                                                ],
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                );
                              });
                        },
                        child: Container(
                          width: size.width * .5,
                          height: size.height * .05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    offset: const Offset(0, 2))
                              ]),
                          child: Center(
                            child: Text(
                              S.current.more,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            );
          }
          if (state is WeatherPageError) {
            return Center(
              child: SizedBox(
                width: size.width * .66,
                height: size.height * .33,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(S.current.error,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium),
                    ElevatedButton(
                        onPressed: () =>
                            Navigator.popAndPushNamed(context, '/'),
                        child: Text(
                          S.current.back,
                          style: Theme.of(context).textTheme.labelMedium,
                        ))
                  ],
                ),
              ),
            );
          } else {
            context
                .read<WeatherPageBloc>()
                .add(WeatherPageGetData(city: cityName));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ));
  }
}
