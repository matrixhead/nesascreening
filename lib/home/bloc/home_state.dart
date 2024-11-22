part of 'home_bloc.dart';

enum HomePageStatus { initial, loading, success }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomePageStatus.initial,
    this.categoryMap  = const {},
    this.hasReachedMax =  false,
  });

  final HomePageStatus status;
  final Map<String,List<Product>> categoryMap;
  final bool hasReachedMax;

  HomeState copyWith({HomePageStatus? status, Map<String,List<Product>>? categoryMap, bool? hasReachedMax }) {
    return HomeState(
        status: status ?? this.status,
        categoryMap: categoryMap ?? this.categoryMap,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax 
        );
  }

  @override
  List<Object?> get props => [status, categoryMap,hasReachedMax];
}
