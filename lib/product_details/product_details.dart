import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesa_screening/data_layer/models.dart';
import 'package:nesa_screening/data_layer/product_repository.dart';
import 'package:nesa_screening/product_details/bloc/product_details_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return BlocProvider(
      create: (context) => ProductDetailsBloc(
        context.read<ProductRepository>(),
        product,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Image.asset(
                  "assets/images/bg.png",
                  color: Colors.black.withOpacity(.04),
                )),
                Expanded(
                    child: Container(
                  color: Colors.indigo[300],
                ))
              ],
            ),
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox.square(
                                  dimension: 32,
                                  child: RoundedButton(
                                      child: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 20,
                                    // color: Colors.black,
                                  ))),
                              SizedBox.square(
                                  dimension: 32,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite_outline,
                                        size: 20,
                                      ))),
                            ],
                          ),
                          Expanded(child: ProductImageViewer(product: product)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 16,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 10,
                            left: 16,
                            child: DefaultTextStyle.merge(
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                                child: Text("\$ ${product.price}"))),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: ClipPath(
                                clipper: Clipper(),
                                child: const ProductInfo(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    child: RoundedButton(
                      color: Colors.purple[900],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_cart_outlined,color: Colors.white,),
                            const SizedBox(width: 8,),
                            DefaultTextStyle.merge(
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                        child: const Text("ADD TO CART")),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          constraints: const BoxConstraints.expand(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BestSellerBadge(),
                    SizedBox(
                      width: 16,
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: 300,
                  child: DefaultTextStyle.merge(
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        overflow: TextOverflow.clip,
                      ),
                      child: Text(
                        state.product.title,
                        maxLines: 1,
                      )),
                ),
                const SizedBox(
                  height: 8,
                ),
                DefaultTextStyle.merge(
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        overflow: TextOverflow.clip,
                        color: Colors.grey),
                    child: const Text(
                      "About the item",
                      maxLines: 1,
                    )),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    RoundedButton(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: DefaultTextStyle.merge(
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            child: const Text(
                              "Full Specification",
                            )),
                      ),
                    ),
                    // this should be a button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: DefaultTextStyle.merge(
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          child: const Text(
                            "Reviews",
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 60,
                  child: SingleChildScrollView(
                    child: DefaultTextStyle.merge(
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        child: Text(
                          state.product.description,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SizedBox.square(
                      dimension: 48,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[850]),
                        // This section displays the seller's location data.
                        // In the reference example, they are using a MapView.
                        // Here, I am using an icon instead, as implementing a full Map API
                        // just to display this icon for the example would be excessive.
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultTextStyle.merge(
                            style: const TextStyle(fontWeight: FontWeight.w400),
                            child: const Text(
                              "Aghmashenebeli Ave 75",
                            )),
                        const SizedBox(
                          height: 4,
                        ),
                        DefaultTextStyle.merge(
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              // fontWeight: FontWeight.w200
                            ),
                            child: const Text(
                              "1 Item is in the way",
                            )),
                      ],
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8,
                ),
                Divider(
                  color: Colors.grey[200],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class BestSellerBadge extends StatelessWidget {
  const BestSellerBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 22,
      decoration: BoxDecoration(
        color: Colors.pink[200],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(3),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        ),
      ),
      child: const Center(
        child: Text(
          'Best Seller',
          style: TextStyle(color: Colors.white, fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ProductImageViewer extends StatefulWidget {
  const ProductImageViewer({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductImageViewer> createState() => _ProductImageViewerState();
}

class _ProductImageViewerState extends State<ProductImageViewer> {
  final colors = [Colors.teal[200], Colors.deepPurple[200], Colors.pink[200]];
  int currentSelected = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        Expanded(
          flex: 2,
          child: Stack(
            children: [
              Halo(
                color: colors[currentSelected]!,
              ),
              Positioned.fill(child: Image.network(widget.product.thumbnail))
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: List<Widget>.generate(3, (i) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        currentSelected = i;
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: i == currentSelected ? Border.all() : null,
                            color: colors[i]),
                        child: Image.network(widget.product.thumbnail)),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
    // return Container();
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key, required this.child, this.elevation, this.color});

  final Widget child;
  final double? elevation;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Square with rounded corners
        ),
        padding: EdgeInsets.zero, // Remove default padding
      ),
      child: child,
    );
  }
}

class Halo extends StatelessWidget {
  const Halo({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: const Alignment(-1, .6),
          end: const Alignment(.8, -1),
          colors: <Color>[
            color,
            color,
            Colors.white.withOpacity(0),
          ],
        ).createShader(bounds);
      },
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.8),
                offset: const Offset(-2, 1),
                blurRadius: 2.0,
              )
            ]),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 75);
    path.cubicTo(150, 0, size.width - 110, 60, size.width, 60);
    path.lineTo(size.width, size.height - 32);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 32, size.height);
    path.lineTo(30, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
