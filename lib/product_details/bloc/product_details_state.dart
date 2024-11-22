part of 'product_details_bloc.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();
  

}

class ProductDetailsStateInitial extends ProductDetailsState{
  @override
  List<Object?> get props => [];
}
class ProductDetailsStateLoaded extends ProductDetailsState{
  final Product product;
  const ProductDetailsStateLoaded(this.product);
  
  @override
  List<Object> get props => [product];

}


