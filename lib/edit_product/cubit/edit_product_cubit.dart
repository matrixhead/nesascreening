import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesa_screening/data_layer/models.dart';
import 'package:nesa_screening/data_layer/product_repository.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit(this.productRepo, this.productId)
      : super(EditProductStateInitial());
  final int productId;
  final ProductRepository productRepo;

  fetchProduct({required int id}) async {
    final product = await productRepo.fetchProduct(id: id);
    emit(EditProductStateLoaded(
        title: product.title,
        description: product.description,
        price: product.price.toString(),
        titleError: "",
        descError: "",
        priceError: "",
        submissionStatus: SubmissionStatus.pure,
        product: product));
  }

  setTitle(String title) {
    final loadedState = state as EditProductStateLoaded;
    emit(loadedState.copyWith(title: title, titleError: ""));
  }

  setDesc(String description) {
    final loadedState = state as EditProductStateLoaded;
    emit(loadedState.copyWith(description: description, descError: ""));
  }

  setPrice(String price) {
    final loadedState = state as EditProductStateLoaded;
    emit(loadedState.copyWith(price: price, priceError: ""));
  }

  submit() async {
    final loadedState = state as EditProductStateLoaded;
    EditProductStateLoaded newstate = loadedState;
    if (loadedState.title.isEmpty) {
      newstate = newstate.copyWith(titleError: "Title cannot empty");
      emit(newstate);
      return;
    }
    if (loadedState.description.isEmpty) {
      newstate = newstate.copyWith(descError: "Description cannot empty");
      emit(newstate);
      return;
    }
    if (loadedState.price.isEmpty) {
      newstate = newstate.copyWith(
        priceError: "Price cannot empty",
      );
      emit(newstate);
      return;
    }
    final newProduct = loadedState.product.copyWith(
      title: loadedState.title,
      description: loadedState.description,
      price: double.tryParse(loadedState.price) ?? 0,
    );
    emit(newstate.copyWith(submissionStatus: SubmissionStatus.loading));
    try {
      await productRepo.updateProduct(newProduct);
      emit(newstate.copyWith(submissionStatus: SubmissionStatus.success));
    } on Exception {
      emit(newstate.copyWith(submissionStatus: SubmissionStatus.error));
    }
  }
}
