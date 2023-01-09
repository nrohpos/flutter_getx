import 'dart:convert';
import 'dart:developer';

import 'package:demogetx/model/User.dart';
import 'package:demogetx/util/Constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  User? user;
  var isDataLoading = false.obs;
  var page = 1;

  @override
  Future<void> onInit() async {
    super.onInit();
    getApi();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  getApi() async {
    try {
      isDataLoading(true);
      http.Response response = await http.get(
          Uri.tryParse('http://dummyapi.io/data/v1/user?page=$page')!,
          headers: {'app-id': kAPP_ID});
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        var data = User.fromJson(result);
        if (user == null) {
          /// ??=
          user = data;
        } else {
          user!.data!.addAll(data.data ?? []);
        }
      } else {
        ///error
        print("erroroororooror");
      }
    } catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
