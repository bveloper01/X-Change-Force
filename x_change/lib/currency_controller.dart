import 'package:x_change/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CurrencyController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var selectedFromCurrency = ''.obs; // Initially blank
  var selectedToCurrency = ''.obs; // Initially blank
  var amount = 0.0.obs;
  var convertedAmount = 0.0.obs;
  var exchangeRate = 0.0.obs;
  var userId = ''.obs; // Store the user ID here

  // Initialize the user ID from the JWT token
  void initializeUser(String token) {
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
    userId.value = jwtDecodedToken['_id'];
  }

  // Fetch exchange rate only when both currencies are selected
  Future<void> fetchExchangeRate() async {
    if (selectedFromCurrency.isNotEmpty && selectedToCurrency.isNotEmpty) {
      try {
        final baseUrl = dotenv.env['API_URL']; // Fetch API URL from .env file
        final url = '$baseUrl/${selectedFromCurrency.value}';
        print(url);
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          exchangeRate.value = (data['rates'][selectedToCurrency.value] as num)
              .toDouble(); // Convert to double safely
          calculateConvertedAmount();
        }
      } catch (e) {
        print('Error fetching exchange rate: $e');
      }
    }
  }

  // Calculate converted amount based on the exchange rate
  void calculateConvertedAmount() {
    if (exchangeRate.value > 0) {
      convertedAmount.value = amount.value * exchangeRate.value;
    }
  }

  // Update amount and recalculate immediately as the user types
  void updateAmount(String value) {
    amount.value = double.tryParse(value) ?? 0.0;
    calculateConvertedAmount();
  }

  // Update the selected currencies and fetch new exchange rate
  void updateFromCurrency(String currency) {
    selectedFromCurrency.value = currency;
    fetchExchangeRate();
  }

  void updateToCurrency(String currency) {
    selectedToCurrency.value = currency;
    fetchExchangeRate();
  }

  // Save the data to MongoDB
  void addXChanged(String token) async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      formKey.currentState?.save();
      initializeUser(token);

      var regBody = {
        "userID": userId.value,
        "amount1": amount.value.toString(),
        "from": selectedFromCurrency.value,
        "amount2":
            "${convertedAmount.value.toStringAsFixed(2)} ${selectedToCurrency.value}",
        "to": selectedToCurrency.value,
        "date": DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
      };

      try {
        print("NewAge $userId");
        print("Sending request to $storeXchanged with data: $regBody");
        var response = await http.post(
          Uri.parse(storeXchanged),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        print("Response status code: ${response.statusCode}");
        var jsonResponse = jsonDecode(response.body);
        print("Response body: $jsonResponse");

        if (jsonResponse['status'] == true) {
          Get.snackbar(
            'Success',
            'Data saved successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        } else {
          Get.snackbar(
            'Error',
            jsonResponse['message'] ?? 'Something went wrong',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        }
      } catch (e) {
        print("Error posting data: $e");
        Get.snackbar(
          'Error',
          'Failed to post data: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }
}
