import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/cartModel.dart';
import 'package:shop/models/userModel.dart';
import '../Tools/globals.dart' as globals;

class ApiService {
  final String baseUrl = "http://10.0.2.2:8000/api/v1/";

  Future<Map> getData(String method, int pageId) async {
    String myUrl = baseUrl + '$method?page=$pageId';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      // print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  // get all cats by store  id
  Future<Map> getCategoriesById(int id, String method, int pageId) async {
    String myUrl = baseUrl + '$method/$id?page=$pageId';
    http.Response response = await http.get(myUrl);
    // print(json.decode(response.body));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  // get all products by cat and store id
  Future<Map> getProductsById(int storeid, int catid, int pageId) async {
    String myUrl = baseUrl + 'getbyCatStore/$storeid/$catid?page=$pageId';
    http.Response response = await http.get(myUrl);
    // print(json.decode(response.body));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  // get all Cart items  by user id
  Future<Map> getCartItem(int userId, int page) async {
    String myUrl = baseUrl + 'cartByUserId/$userId?page=$page';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
  // get  Cart item  by storeProductId

  Future<bool> getCartItemByStoreProductId(int storeProductId) async {
    String myUrl = baseUrl + 'cartByStoreProductId/$storeProductId';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      // print(response.body);
      if (int.parse(response.body) == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // get product

  // add to cart

  Future<bool> addCartItem(Cart body) async {
    final response = await http.post(
      baseUrl + "cart",
      headers: {"content-type": "application/json"},
      body: cartToJson(body),
    );
    // print(response.request.url);
    print(cartToJson(body));
    // print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // edit cart
  Future<bool> editCartItem(Cart body) async {
    final response = await http.put(
      baseUrl + "cart/${body.id}",
      headers: {"content-type": "application/json"},
      body: cartToJson(body),
    );
    // print(response.request.url);
    print(body.id);
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map> getLoggedinUser(String fireBaseId) async {
    String myUrl = baseUrl + "users/$fireBaseId";
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setInt('userid', json.decode(response.body)['id']);
      globals.userApiId = json.decode(response.body)['id'];
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  // user sign up

  Future<bool> userSignUp(UserModel body) async {
    final response = await http.post(
      baseUrl + "users",
      headers: {"content-type": "application/json"},
      body: userModelToJson(body),
    );
    // print(response.request.url);
    print(userModelToJson(body));
    // print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
