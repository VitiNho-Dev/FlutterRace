import 'package:flutter/material.dart';
import 'package:meuapp/shared/models/product_model.dart';
import 'package:meuapp/shared/theme/app_theme.dart';

class CardProduct extends StatelessWidget {
  final ProductModel product;
  const CardProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        width: 230,
        decoration: BoxDecoration(
          color: AppTheme.colors.textEnabled,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.colors.background,
                child: product.currentPrice < product.lastPrice
                    ? Icon(
                        Icons.thumb_up,
                        color: AppTheme.colors.primary,
                      )
                    : Icon(
                        Icons.thumb_down,
                        color: AppTheme.colors.badColor,
                      ),
                radius: 28,
              ),
              title: Text(
                product.name,
                style: AppTheme.textStyles.titleListTile,
              ),
              subtitle: Text(
                'Estava R\$ ${product.lastPrice}',
                style: AppTheme.textStyles.subtitleListTile,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text.rich(
                TextSpan(
                  text: 'Agora\n',
                  style: AppTheme.textStyles.subtitleListTile,
                  children: [
                    TextSpan(
                      text: 'R\$ ${product.currentPrice}',
                      style: AppTheme.textStyles.title,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
