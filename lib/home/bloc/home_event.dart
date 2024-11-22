part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitEvent extends HomeEvent {}
class HomeLoadCategoryEvent extends HomeEvent {}
class HomeRefreshEvent extends HomeEvent {}