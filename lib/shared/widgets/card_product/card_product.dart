import 'package:flutter/material.dart';
import 'package:meuapp/shared/theme/app_theme.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 9),
      child: Container(
        width: 230,
        decoration: BoxDecoration(
          color: AppTheme.colors.textEnabled,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: const [
            ListTile(
              leading: CircleAvatar(
                child: Text('10/12'),
                radius: 28,
              ),
              title: Text('Produto'),
              subtitle: Text('Preço'),
            ),
            Text.rich(
              TextSpan(
                text: 'Agora\n',
                children: [
                  TextSpan(text: 'R\$ 25,90'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
