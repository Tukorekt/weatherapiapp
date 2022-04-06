part of 'cities_page_bloc.dart';

abstract class CitiesPageEvent extends Equatable {
  const CitiesPageEvent();
}

class CitiesPageEventInitial extends CitiesPageEvent {
  const CitiesPageEventInitial();

  @override
  List<Object?> get props => [];
}

class CitiesPageEventUpdate extends CitiesPageEvent {
  final String cityName;

  const CitiesPageEventUpdate({required this.cityName});

  @override
  List<Object?> get props => [cityName];
}
