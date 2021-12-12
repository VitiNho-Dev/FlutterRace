import 'package:flutter/material.dart';
import 'package:meuapp/modules/feed_page/feed_controller.dart';
import 'package:meuapp/modules/feed_page/repository/feed_repository_impl.dart';
import 'package:meuapp/shared/models/order_model.dart';
import 'package:meuapp/shared/services/app_database.dart';
import 'package:meuapp/shared/theme/app_text.dart';
import 'package:meuapp/shared/widgets/card_chart/card_chart.dart';
import 'package:meuapp/shared/widgets/card_product/card_product.dart';
import 'package:meuapp/shared/widgets/list_tile/app_list_tile.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late final FeedController controller;

  @override
  void initState() {
    controller = FeedController(
      repository: FeedRepositoryImpl(database: AppDatabase.instance),
    );
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      bottom: false,
      child: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) => controller.state.when(
            success: (data) {
              final orders = data as List<OrderModel>;
              final products = controller.products;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        CardChart(
                          value: controller.sumTotal,
                          percent: controller.calcChart(products),
                        ),
                        const SizedBox(
                          height: 27,
                        ),
                        const Text('Preço dos produtos').label,
                        const SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 126,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) => CardProduct(
                        product: products[index],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 27,
                        ),
                        const Text('Suas últimas compras').label,
                        const SizedBox(
                          height: 18,
                        ),
                        for (var order in orders)
                          AppListTile(
                            order: order,
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
            orElse: () => Container(),
          ),
        ),
      ),
    );
  }
}
