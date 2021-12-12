import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:meuapp/modules/create/create_controller.dart';
import 'package:meuapp/modules/create/repository/create_repository_imp.dart';
import 'package:meuapp/shared/services/app_database.dart';
import 'package:meuapp/shared/widgets/button/button.dart';
import 'package:meuapp/shared/widgets/input_text/input_text.dart';

class CreateBottomSheet extends StatefulWidget {
  const CreateBottomSheet({Key? key}) : super(key: key);

  @override
  State<CreateBottomSheet> createState() => _CreateBottomSheetState();
}

class _CreateBottomSheetState extends State<CreateBottomSheet> {
  late final CreateController controller;

  @override
  void initState() {
    controller = CreateController(
        repository: CreateRepositoryImpl(database: AppDatabase.instance));
    controller.addListener(() {
      controller.state.when(
          success: (_) {
            Navigator.pop(context);
          },
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 16),
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              InputText(
                label: 'Produto',
                hint: 'Digite um nome',
                validator: (value) =>
                    value.isNotEmpty ? null : "Digite um nome",
                onChanged: (value) => controller.onChanged(name: value),
              ),
              const SizedBox(
                height: 8,
              ),
              InputText(
                label: 'Preço',
                hint: 'Digite um valor',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  MoneyInputFormatter(leadingSymbol: "R\$"),
                ],
                validator: (value) =>
                    value.isNotEmpty ? null : "Digite um preço",
                onChanged: (value) => controller.onChanged(price: value),
              ),
              const SizedBox(
                height: 8,
              ),
              InputText(
                label: 'Data de Compra',
                hint: 'Digite dd/mm/aa',
                inputFormatters: [MaskedInputFormatter('00/00/0000')],
                keyboardType: TextInputType.datetime,
                validator: (value) =>
                    value.isNotEmpty ? null : "Digite uma data",
                onChanged: (value) => controller.onChanged(date: value),
              ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (_, __) => controller.state.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (message, _) => Text(message),
                  orElse: () => Button(
                      onTap: () => controller.create(), label: 'Adcionar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
