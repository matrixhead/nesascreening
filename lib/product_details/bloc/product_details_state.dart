part of 'product_details_bloc.dart';

class ProductDetailsState extends Equatable {
  final Product product;
  const ProductDetailsState(this.product);
  
  @override
  List<Object> get props => [product];
}


