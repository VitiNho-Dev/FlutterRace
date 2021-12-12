import 'package:flutter/material.dart';
import 'package:meuapp/modules/login/pages/create_account/create_account_controller.dart';
import 'package:meuapp/modules/login/repositorys/login_repository_impl.dart';
import 'package:meuapp/shared/services/app_database.dart';
import 'package:meuapp/shared/theme/app_theme.dart';
import 'package:meuapp/shared/widgets/button/button.dart';
import 'package:meuapp/shared/widgets/input_text/input_text.dart';
import 'package:validators/validators.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  late final CreateAccountController controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller = CreateAccountController(
        repository: LoginRepositoryImpl(database: AppDatabase.instance));
    controller.addListener(() {
      controller.state.when(
          success: (value) => Navigator.pop(context),
          error: (message, _) => scaffoldKey.currentState!.showBottomSheet(
                (context) => BottomSheet(
                  onClosing: () {},
                  builder: (context) => Container(
                    child: Text(message),
                  ),
                ),
              ),
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
      backgroundColor: AppTheme.colors.background,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
        leading: BackButton(
          color: AppTheme.colors.backButton,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.width * 0.1),
                Text('Criando uma conta', style: AppTheme.textStyles.title),
                const SizedBox(height: 10),
                Text('Mantenha seus gastos em dia',
                    style: AppTheme.textStyles.subtitle),
                const SizedBox(height: 38),
                InputText(
                  label: 'Nome',
                  onChanged: (value) => controller.onChanged(name: value),
                  validator: (value) =>
                      value.isNotEmpty ? null : "Digite seu nome completo",
                  hint: 'Digite seu nome',
                ),
                const SizedBox(height: 18),
                InputText(
                  label: 'E-mail',
                  onChanged: (value) => controller.onChanged(email: value),
                  validator: (value) =>
                      isEmail(value) ? null : "Digite um e-mail válido",
                  hint: 'Digite seu email',
                ),
                const SizedBox(height: 18),
                InputText(
                  label: 'Senha',
                  obscure: true,
                  onChanged: (value) => controller.onChanged(password: value),
                  validator: (value) =>
                      value.length >= 6 ? null : "Digite uma senha mais forte",
                  hint: 'Digite sua senha',
                ),
                const SizedBox(height: 15),
                AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) => controller.state.when(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    orElse: () => Button(
                      onTap: () => controller.create(),
                      label: 'Criar Conta',
                      type: ButtonType.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 58),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
