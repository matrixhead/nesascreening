import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesa_screening/data_layer/product_repository.dart';
import 'package:nesa_screening/edit_product/cubit/edit_product_cubit.dart';
import 'package:nesa_screening/widgets/widgets.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as int;
    return BlocProvider(
      create: (context) =>
          EditProductCubit(context.read<ProductRepository>(), productId)..fetchProduct(id: productId),
      child: BlocBuilder<EditProductCubit, EditProductState>(
        builder: (context, state) {
          if (state is EditProductStateLoaded) {
            return BlocListener<EditProductCubit, EditProductState>(
              listener: (context, state) {
                state as EditProductStateLoaded;
                if (state.submissionStatus == SubmissionStatus.success) {
                  Navigator.pop(context, true);
                }
              },
              child: PopScope(
                canPop: false,
                onPopInvokedWithResult: (didpop, result) {
                  if (didpop) {
                    return;
                  }
                  if (result == null) {
                    Navigator.pop(context, false);
                  }
                },
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text("Edit product"),
                  ),
                  body: SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            EditText(
                              initialText: state.product.title,
                              onChanged:
                                  context.read<EditProductCubit>().setTitle,
                              labelText: "Title",
                              errorText: state.titleError.isEmpty
                                  ? null
                                  : state.titleError,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            EditText(
                              initialText: state.product.description,
                              onChanged:
                                  context.read<EditProductCubit>().setDesc,
                              labelText: "Description",
                              errorText: state.descError.isEmpty
                                  ? null
                                  : state.descError,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            EditText(
                              initialText: state.product.price.toString(),
                              onChanged:
                                  context.read<EditProductCubit>().setPrice,
                              labelText: "Price",
                              errorText: state.priceError.isEmpty
                                  ? null
                                  : state.priceError,
                              digitsOnly: true,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Expanded(
                              child: Center(
                                child: RoundedButton(
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 32.0),
                                    child: Text("Submit"),
                                  ),
                                  ontap: () {
                                    context.read<EditProductCubit>().submit();
                                  },
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class EditText extends StatefulWidget {
  const EditText(
      {super.key,
      required this.initialText,
      required this.onChanged,
      required this.labelText,
      this.digitsOnly = false,
      this.errorText});
  final Function(String) onChanged;
  final String initialText;
  final String labelText;
  final bool digitsOnly;
  final String? errorText;
  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.initialText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      controller: _controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(),
        labelText: widget.labelText,
        errorText: widget.errorText,
      ),
      inputFormatters: widget.digitsOnly
          ? [FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*$"))]
          : null,
      keyboardType: widget.digitsOnly
          ? const TextInputType.numberWithOptions(decimal: true)
          : null,
    );
  }
}
