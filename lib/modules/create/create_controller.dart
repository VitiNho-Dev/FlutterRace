import 'package:flutter/cupertino.dart';
import 'package:meuapp/modules/create/create_repository.dart';
import 'package:meuapp/shared/utils/app_state.dart';

class CreateController extends ChangeNotifier {
  final ICreateRepository repository;

  CreateController({required this.repository});

  AppState state = AppState.empty();
  var _name = '';
  var _price = '';
  var _date = '';
  final formKey = GlobalKey<FormState>();

  void onChanged({String? name, String? price, String? date}) {
    _name = name ?? _name;
    _price = price ?? _price;
    _date = date ?? _date;
  }

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> create() async {
    if (validate()) {
      try {
        update(AppState.loading());
        final response =
            await repository.create(name: _name, date: _date, price: _price);
        if (response) {
          update(AppState.success<bool>(response));
        } else {
          throw Exception('Não foi possível cadastrar');
        }
      } catch (e) {
        update(AppState.error(e.toString()));
      }
    }
  }
}
