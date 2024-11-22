import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesa_screening/data_layer/models.dart';
import 'package:nesa_screening/data_layer/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.productRespository) : super(const HomeState()) {
    on<HomeInitEvent>(_onInit);
    on<HomeRefreshEvent>(_onProductListRefresh);
    on<HomeLoadCategoryEvent>(_onLoadCategory);
  }
  final ProductRepository productRespository;
  void _onInit(HomeInitEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomePageStatus.loading));
    await productRespository.loadMoreCategory();
    await productRespository.loadMoreCategory();
    emit(state.copyWith(
      categoryMap: productRespository.getCategoryMap,
      hasReachedMax: productRespository.hasReachedMax,
      status: HomePageStatus.success,
    ));
  }

  void _onProductListRefresh(
      HomeRefreshEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(categoryMap: productRespository.getCategoryMap,hasReachedMax: productRespository.hasReachedMax));
  }

  void _onLoadCategory(
      HomeLoadCategoryEvent event, Emitter<HomeState> emit) async {
    if (state.status != HomePageStatus.loading && !state.hasReachedMax) {
      emit(state.copyWith(status: HomePageStatus.loading));
      await productRespository.loadMoreCategory();
      await productRespository.loadMoreCategory();
      emit(
        state.copyWith(
            categoryMap: productRespository.getCategoryMap,
            status: HomePageStatus.success,hasReachedMax: productRespository.hasReachedMax),
      );
    }
  }
}
