import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesa_screening/data_layer/models.dart';
import 'package:nesa_screening/data_layer/product_repository.dart';
import 'package:nesa_screening/home/bloc/home_bloc.dart';
import 'package:nesa_screening/product_details/product_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(context.read<ProductRepository>())..add(HomeInitEvent()),
      child: const Scaffold(body: ScrollView()),
    );
  }
}

class ScrollView extends StatefulWidget {
  const ScrollView({
    super.key,
  });

  @override
  State<ScrollView> createState() => _ScrollViewState();
}

class _ScrollViewState extends State<ScrollView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 280,
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_outlined))
          ],
          flexibleSpace: const FlexibleSpaceBar(
            background: SafeArea(
                child: Padding(
                    padding: EdgeInsets.only(left: 18), child: WelcomeText())),
          ),
        ),
        const CategoryList(),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<HomeBloc>().add(HomeLoadCategoryEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final categories = state.categoryMap.keys.toList();
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index >= state.categoryMap.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final category = categories[index];
              final categoryItems = state.categoryMap[category]!;
              return CategoryCard(
                  category: category, categoryItems: categoryItems);
            },
            childCount: state.hasReachedMax
                ? state.categoryMap.length
                : state.categoryMap.length + 1,
          ),
        );
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.categoryItems,
  });

  final String category;
  final List<Product> categoryItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: SizedBox(
        height: 280,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultTextStyle.merge(
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 18),
                    child: Text(
                      textScaler: TextScaler.noScaling,
                      "${category[0].toUpperCase()}${category.substring(1).toLowerCase()}",
                    )),
                DefaultTextStyle.merge(
                    style: TextStyle(
                        color: Colors.indigo[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    child: InkWell(
                        onTap: () {},
                        child: const Text(
                          "Show All",
                        ))),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 16),
                child: LayoutBuilder(builder: (context, constraints) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryItems.length,
                    itemBuilder: (context, index) {
                      final product = categoryItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Align(
                          child: SizedBox(
                            width: (constraints.maxWidth / 2) * .95,
                            child: ProductCard(product: product),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 23 / 30,
      child: InkWell(
        onTap: () {
          final bloc = context.read<HomeBloc>();
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ProductDetailsPage(),
                      settings: RouteSettings(
                          arguments: product.id)))
              .then((val) {
            bloc.add(HomeRefreshEvent());
          });
        },
        child: Card(
          elevation: 2,
          child: DefaultTextStyle.merge(
            textAlign: TextAlign.center,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Positioned(
                        right: -12,
                        top: -12,
                        child: IconButton(
                            iconSize: 18,
                            onPressed: () {},
                            icon: const Icon(Icons
                                .favorite_border))),
                    Positioned.fill(
                      child: LayoutBuilder(builder:
                          (context, constraints) {
                        return Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceEvenly,
                          mainAxisSize:
                              MainAxisSize.min,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width:
                                    constraints.maxWidth *
                                        .5,
                                child:FadeInImage.assetNetwork(placeholder: "assets/images/image-placeholder.png", image: product.thumbnail),
                              ),
                            ),
                            DefaultTextStyle.merge(
                                style: const TextStyle(
                                    fontWeight:
                                        FontWeight.w500,
                                    fontSize: 13),
                                maxLines: 2,
                                child: Text(
                                  textScaler: TextScaler
                                      .noScaling,
                                  product.title,
                                )),
                            DefaultTextStyle.merge(
                                style: const TextStyle(
                                    fontSize: 9),
                                child: Text(
                                  product.description,
                                  overflow:
                                      TextOverflow.fade,
                                  maxLines: 3,
                                  softWrap: true,
                                  textScaler: TextScaler
                                      .noScaling,
                                )),
                            DefaultTextStyle.merge(
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight:
                                    FontWeight.w900,
                              ),
                              child: Text(
                                "\$ ${product.price.toString()}",
                                textScaler: TextScaler
                                    .noScaling,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                )),
          ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: DefaultTextStyle.merge(
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                    child: const Text(
                      "Discover our exclusive\nproducts",
                    )),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 20,
                    child: FittedBox(
                      child: DefaultTextStyle.merge(
                          style:
                              TextStyle(color: Theme.of(context).disabledColor),
                          child: const Text(
                            textAlign: TextAlign.left,
                            "In this marketplace, you will find various\ntechnics in the cheapest price",
                          )),
                    ),
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
