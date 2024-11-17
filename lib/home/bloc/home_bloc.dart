import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesa_screening/data_layer/models.dart';
import 'package:nesa_screening/data_layer/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.productRespository) : super(const HomeState()) {
    on<ProductListFetchedEvent>(_onProductListFetched);
  }
  final ProductRepository productRespository;
  void _onProductListFetched(
      ProductListFetchedEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(status: HomePageStatus.loading));
    productRespository.fetchProductList().then((_) {
      emit(
          state.copyWith(productList: List.of(productRespository.productList)));
    });
  }
}
