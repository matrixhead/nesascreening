part of 'home_bloc.dart';

enum HomePageStatus { initial, loading, success }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomePageStatus.initial,
    this.categoryMap  = const {},
  });

  final HomePageStatus status;
  final Map<String,List<Product>> categoryMap;

  HomeState copyWith({HomePageStatus? status, Map<String,List<Product>>? categoryMap}) {
    return HomeState(
        status: status ?? this.status,
        categoryMap: categoryMap ?? this.categoryMap);
  }

  @override
  List<Object?> get props => [status, categoryMap];
}
