part of 'edit_product_cubit.dart';
abstract class EditProductState extends Equatable{

}
class EditProductStateInitial extends EditProductState{
  @override
  List<Object?> get props => [];
}
class EditProductStateLoaded extends EditProductState {
   EditProductStateLoaded({
    required this.title,
    required this.description,
    required this.price,
    required this.titleError,
    required this.descError,
    required this.priceError,
    required this.submissionStatus,
    required this.product,
  });

  final String title;
  final String description;
  final String price;
  final String titleError;
  final String descError;
  final String priceError;
  final Product product;
  final SubmissionStatus submissionStatus;

  EditProductStateLoaded copyWith({
    String? title,
    String? description,
    String? price,
    String? titleError,
    String? descError,
    String? priceError,
    SubmissionStatus? submissionStatus,
    Product? product
  }) {
    return EditProductStateLoaded(
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      titleError: titleError?? this.titleError,
      descError: descError?? this.descError,
      priceError: priceError?? this.priceError,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      product: product ?? this.product
    );
  }

  @override
  List<Object> get props => [title, description, price,titleError,descError,priceError,submissionStatus,product];
}

enum SubmissionStatus {pure,loading,success,error}
