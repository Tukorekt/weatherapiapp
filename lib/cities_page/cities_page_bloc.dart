import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../generated/l10n.dart';

part 'cities_page_event.dart';

part 'cities_page_state.dart';

class CitiesPageBloc extends Bloc<CitiesPageEvent, CitiesPageState> {
  String boxName = S.current.lang;

  CitiesPageBloc() : super(CitiesPageInitial()) {
    on<CitiesPageEventInitial>((event, emit) async {
      if (await Hive.boxExists(boxName)) {
        await Hive.openBox(boxName);
        var box = Hive.box(boxName);
        List citiesList = box.values.toList();
        emit(CitiesPageData(cities: citiesList));
      } else {
        await Hive.openBox(boxName);
        var box = Hive.box(boxName);
        final List<String> cities = [
          S.current.yar,
          S.current.msk,
          S.current.kzn
        ];
        await box.addAll(cities);
        box.close();
        emit(CitiesPageData(cities: cities));
      }
    });
    on<CitiesPageEventUpdate>((event, emit) async {
      await Hive.openBox(boxName);
      var box = Hive.box(boxName);
      await box.add(event.cityName);
      box.close();
      emit(const CitiesPageUpdated());
    });
  }
}
