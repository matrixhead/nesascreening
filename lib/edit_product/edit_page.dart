import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesa_screening/data_layer/models.dart';
import 'package:nesa_screening/data_layer/product_repository.dart';
import 'package:nesa_screening/edit_product/cubit/edit_product_cubit.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return BlocProvider(
      create: (context) =>
          EditProductCubit(context.read<ProductRepository>(), product),
      child: const Placeholder(),
    );
  }
}
