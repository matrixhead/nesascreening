import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nesa_screening/data_layer/models.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit(read, Product product) : super(EditProductState(product));
}
