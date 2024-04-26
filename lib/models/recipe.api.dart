import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe/models/recipe.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    List temp = [];

    try {
      var uri = Uri.https(
        'yummly2.p.rapidapi.com',
        '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"},
      );

      final response = await http.get(uri, headers: {
        "x-rapidapi-key": '',
        "x-rapidapi-host": "yummly2.p.rapidapi.com",
        "useQueryString": "true",
      });

      Map data = jsonDecode(response.body);
      for (var i in data['feed']) {
        temp.add(i['content']['details']);
      }
    } catch (e) {
      print(e);
    }
    return Recipe.recipesFromSnapshot(temp);
  }
}
