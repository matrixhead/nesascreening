import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesa_screening/data_layer/product_repository.dart';
import 'package:nesa_screening/home/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(context.read<ProductRepository>())
        ..add(ProductListFetchedEvent()),
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return const SafeArea(child: WelcomeText());
          },
        ),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: DefaultTextStyle.merge(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    child: const Text(
                      "Discover our exclusive\nproducts",
                    )),
              ),
              
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
              
                  Flexible(
                    flex: 20,
                    child: DefaultTextStyle.merge(
                        style: const TextStyle(
                          fontSize: 10
                          
                        ),
                        // softWrap: true,
                        
                                  
                        child: const Text(
                          textAlign: TextAlign.left,
                          "In this marketplace, you will find various technics in the cheapest price",
                        )),
                        
                  ),
                  Expanded(flex: 2, child: Container())

                ],
              ),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container())
      ],
    );
  }
}
