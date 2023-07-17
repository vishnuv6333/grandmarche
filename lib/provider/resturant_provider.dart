import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/base_url.dart';
import '../model/model.dart';

class ResurantProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _load = false;
  bool get isLoading => _isLoading;
  bool get load => _load;
  Resturant resturant = Resturant(restaurants: []);
  String? res;

  String? Image;
  String? name;
  String? address;
  String? cuisine_type;
  List? review;
  String? latittude;
  String? logittude;
  Map<String,dynamic>? operating_hours;

  getResturantList() async {
    try {
      _isLoading = true;

      Response response = await http.get(Uri.parse(BaseUrl().baseUrl));
      if (response.statusCode == 200) {
        resturant = resturantFromJson(response.body);
        _isLoading = false;
        notifyListeners();
      } else {
      }

      notifyListeners();
    } catch (e) {}
  }

  getDetails() async {
    _load = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var res = prefs.getString("resturant");
      var re=jsonDecode(res.toString());
      Image=re['photograph'];
      name=re['name'];
      cuisine_type=re["cuisine_type"];
      address=re['address'];
      review=re['reviews'];
      operating_hours=re["operating_hours"];
   
      print(re['latlng']['lat']);
      latittude=re['latlng']['lat'].toString();
      logittude=re['latlng']['lng'].toString();
      
     

      _load = false;
      notifyListeners();
    } catch (e) {}
  }
}
