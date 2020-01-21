import 'package:carros_custom/pages/carros/simple_bloc.dart';
import 'package:http/http.dart' as http;

class LoripsumBloc extends SimpleBloc<String> {
  static String lorim;

  fetch() async {
    try {
      String text = lorim ?? await LoripsumApi.getLoripsum();

      lorim = text;

      add(text);
    } catch (e) {
      addError(e);
    }
  }
}

class LoripsumApi {
  static Future<String> getLoripsum() async {
    var url = 'https://loripsum.net/api';

    var response = await http.get(url);

    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }
}
