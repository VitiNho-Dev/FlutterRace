import 'package:flutter/material.dart';
import 'package:meuapp/shared/theme/app_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            Text(
              'Perfil',
              style: AppTheme.textStyles.titleListTile.copyWith(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 117,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.colors.textEnabled,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                title: Text(
                  'Sair do aplicativo',
                  style: AppTheme.textStyles.titleListTile,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
