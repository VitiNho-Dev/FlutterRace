import 'package:flutter/material.dart';
import 'package:meuapp/shared/theme/app_theme.dart';

class ChartHorizontal extends StatelessWidget {
  final double percent;
  const ChartHorizontal({Key? key, required this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                AppTheme.colors.badColor,
                AppTheme.colors.primary,
              ],
              stops: [percent, 0.0],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (percent > 0 && percent <= 1)
                  Text(
                    '${(percent * 100).ceil()}%',
                    style: AppTheme.textStyles.chart,
                  ),
                if ((1 - percent) > 0)
                  Text(
                    '${((1 - percent) * 100).ceil()}%',
                    style: AppTheme.textStyles.chart,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          'Relação de compras caras e boas compras',
          style: AppTheme.textStyles.hint,
        ),
        const SizedBox(
          height: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.colors.badColor,
                  radius: 10,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'PAGOU CARO',
                  style: AppTheme.textStyles.hintBold,
                ),
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.colors.primary,
                  radius: 10,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'BOAS COMPRAS',
                  style: AppTheme.textStyles.hintBold,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
