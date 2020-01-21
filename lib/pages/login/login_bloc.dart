import 'package:carros_custom/pages/api_response.dart';
import 'package:carros_custom/pages/carros/simple_bloc.dart';
import 'package:carros_custom/pages/login/login_api.dart';
import 'package:carros_custom/pages/login/usuario.dart';

class LoginBloc extends BooleanBloc {
  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    add(true);

    ApiResponse response = await LoginApi.login(login, senha);

    add(false);

    return response;
  }
}
