import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapiapp/cities_page/cities_page_bloc.dart';
import 'package:weatherapiapp/main.dart';

import '../generated/l10n.dart';

class CitiesPage extends StatefulWidget {
  const CitiesPage({Key? key}) : super(key: key);

  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  String query = '';
  final CitiesPageBloc _citiesPageBloc = CitiesPageBloc();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    S.load(Locale.fromSubtags(
                        languageCode: S.current.lang == 'ru' ? 'en' : 'ru'));
                    Navigator.popAndPushNamed(context, '/');
                  },
                  child: Text(
                    S.current.lang,
                    style: Theme.of(context).textTheme.labelMedium,
                  ))
            ],
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            title: Text(
              S.current.chooseCity,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * .66,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration.collapsed(
                            hintText: S.current.search,
                            hintStyle: Theme.of(context).textTheme.bodyMedium),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                        onChanged: (data) => setState(() {
                          query = data;
                        }),
                      ),
                    ),
                    if (query != '')
                      IconButton(
                          onPressed: () {
                            mainCityName = query;
                            Navigator.popAndPushNamed(
                                context, '/cityWeatherDaily',
                                arguments: query);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: Theme.of(context).backgroundColor,
                            child: const Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            ),
                          ))
                  ],
                ),
                BlocBuilder<CitiesPageBloc, CitiesPageState>(
                    bloc: _citiesPageBloc,
                    builder: (_, state) {
                      if (state is CitiesPageData) {
                        return SizedBox(
                          width: size.width * .66,
                          height: size.height * .66,
                          child: ListView.builder(
                              itemCount: state.cities.length,
                              itemBuilder: (context, element) {
                                if (state.cities[element]
                                    .toLowerCase()
                                    .contains(query.toLowerCase())) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        mainCityName = state.cities[element];
                                        Navigator.popAndPushNamed(
                                            context, '/cityWeatherDaily',
                                            arguments: state.cities[element]);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(.1),
                                                  offset: const Offset(1, 3))
                                            ]),
                                        child: Center(
                                          child: Text(
                                            state.cities[element],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        );
                      } else {
                        _citiesPageBloc.add(const CitiesPageEventInitial());
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return Dialog(
                            child: Container(
                              width: size.width * .7,
                              height: size.height * .1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Material(
                                  child: TextField(
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration.collapsed(
                                        hintText: S.current.enterName,
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    onSubmitted: (data) {
                                      Navigator.pop(context);
                                      _citiesPageBloc.add(CitiesPageEventUpdate(
                                          cityName: data));
                                    },
                                  ),
                                ),
                              ),
                            ),
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
                        S.current.addCity,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
