part of 'cities_page_bloc.dart';

abstract class CitiesPageState extends Equatable {
  const CitiesPageState();
}

class CitiesPageInitial extends CitiesPageState {
  @override
  List<Object> get props => [];
}

class CitiesPageData extends CitiesPageState {
  final List cities;

  const CitiesPageData({required this.cities});

  @override
  List<Object> get props => [];
}

class CitiesPageUpdated extends CitiesPageState {
  const CitiesPageUpdated();

  @override
  List<Object> get props => [];
}
