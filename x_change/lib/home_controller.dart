import 'package:x_change/Components/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:x_change/config.dart';
import 'package:x_change/dashboard.dart';

class HomeController extends GetxController {
  final _formKey = GlobalKey<FormState>();
  var isLogin = true.obs;
  var enteredEmail = ''.obs;
  var enteredPassword = ''.obs;
  var isNotValidate = false.obs;
  var isArther = false.obs;
  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void registerUser() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      var regBody = {"email": enteredEmail.value, "password": enteredPassword.value};
      var response = await http.post(Uri.parse(registeration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        isLogin.value = true;
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: primaryColor,
          colorText: Colors.white,
          duration: Duration(seconds: 1),
        );
      }
    } else {
      isNotValidate.value = true;
    }
  }

  void loginUser() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      var reqBody = {"email": enteredEmail.value, "password": enteredPassword.value};
      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        Get.off(() => DashBoardPage(token: myToken));
        _formKey.currentState!.reset();
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          backgroundColor: primaryColor,
          colorText: Colors.white,
          duration: Duration(seconds: 1),
        );
      }
    } else {
      isNotValidate.value = true;
    }
  }

  void toggleLogin() {
    isLogin.value = !isLogin.value;
    _formKey.currentState!.reset();
  }

  GlobalKey<FormState> get formKey => _formKey;
}
