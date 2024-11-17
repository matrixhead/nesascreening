part of 'home_bloc.dart';

enum HomePageStatus { initial, loading, success }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomePageStatus.initial,
    this.productList = const <Product>[],
  });

  final HomePageStatus status;
  final List<Product> productList;

  HomeState copyWith({HomePageStatus? status, List<Product>? productList}) {
    return HomeState(
        status: status ?? this.status,
        productList: productList ?? this.productList);
  }

  @override
  List<Object?> get props => [status, productList];
}
