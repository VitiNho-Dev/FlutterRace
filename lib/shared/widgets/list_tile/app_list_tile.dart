import 'package:flutter/material.dart';
import 'package:meuapp/shared/theme/app_theme.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 9),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors.textEnabled,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: const CircleAvatar(
            child: Text('10/12'),
            radius: 28,
          ),
          title: const Text('Produto'),
          subtitle: const Text('Preço'),
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('Editar')),
              const PopupMenuItem(child: Text('Excluir')),
            ],
          ),
        ),
      ),
    );
  }
}
