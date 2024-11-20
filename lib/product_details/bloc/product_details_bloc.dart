import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesa_screening/data_layer/models.dart';
import 'package:nesa_screening/data_layer/product_repository.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  
  ProductDetailsBloc(this.productRepository, product) : super(ProductDetailsState(product)) {
    on<ProductDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  final ProductRepository productRepository;

}
