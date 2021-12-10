import 'package:flutter/cupertino.dart';
import 'package:meuapp/modules/login/repositorys/login_repository.dart';
import 'package:meuapp/shared/models/user_model.dart';
import 'package:meuapp/shared/services/app_database.dart';
import 'package:meuapp/shared/utils/app_state.dart';

class LoginController extends ChangeNotifier {
  final LoginRepository repository;

  AppState state = AppState.empty();
  var _email = '';
  var _password = '';
  final formKey = GlobalKey<FormState>();

  LoginController({required this.repository});

  void onChanged({String? email, String? password}) {
    _email = email ?? _email;
    _password = password ?? _password;
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }

  Future<void> login() async {
    if (validate()) {
      try {
        update(AppState.loading());
        // CHAMADA DO BACKEND
        final response =
            await repository.login(email: _email, password: _password);
        update(AppState.success<UserModel>(response));
      } catch (e) {
        update(
          AppState.error(
            e.toString(),
          ),
        );
      }
    }
  }
}
