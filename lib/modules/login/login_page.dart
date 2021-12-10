import 'package:flutter/material.dart';
import 'package:meuapp/modules/login/login_controller.dart';
import 'package:meuapp/modules/login/repositorys/login_repository_impl.dart';
import 'package:meuapp/shared/services/app_database.dart';
import 'package:meuapp/shared/theme/app_theme.dart';
import 'package:meuapp/shared/widgets/button/button.dart';
import 'package:meuapp/shared/widgets/input_text/input_text.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller = LoginController(
      repository: LoginRepositoryImpl(database: AppDatabase.instance),
    );
    controller.addListener(() {
      controller.state.when(
          success: (value) =>
              Navigator.pushNamed(context, '/home', arguments: value),
          error: (message, _) => scaffoldKey.currentState!.setState(() {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Erro ao fazer login'),
                  ),
                );
              }),
          orElse: () {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.width * 0.15),
                Image.asset(
                  'assets/images/logo.png',
                  width: 223,
                ),
                InputText(
                  label: 'E-mail',
                  onChanged: (value) {
                    controller.onChanged(email: value);
                  },
                  validator: (value) =>
                      isEmail(value) ? null : "Digite um e-mail válido",
                  hint: 'Digite seu email',
                ),
                const SizedBox(height: 18),
                InputText(
                  label: 'Senha',
                  obscure: true,
                  onChanged: (value) {
                    controller.onChanged(password: value);
                  },
                  validator: (value) =>
                      value.length >= 6 ? null : "Digite uma senha",
                  hint: 'Digite sua senha',
                ),
                const SizedBox(height: 15),
                AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) => controller.state.when(
                    loading: () => const CircularProgressIndicator(),
                    orElse: () => Button(
                      onPressed: () => controller.login(),
                      label: 'Entrar',
                      type: ButtonType.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 58),
                Button(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login/create-account');
                  },
                  label: 'Criar Conta',
                  type: ButtonType.outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
