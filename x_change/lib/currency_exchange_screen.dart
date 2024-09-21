import 'package:x_change/Components/color.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'currency_controller.dart'; // Import your controller

class CurrencyExchangeScreen extends StatefulWidget {
  final String token; // Explicit type declaration for clarity
  const CurrencyExchangeScreen({super.key, required this.token});

  @override
  State<CurrencyExchangeScreen> createState() => _CurrencyExchangeScreenState();
}

class _CurrencyExchangeScreenState extends State<CurrencyExchangeScreen> {
  // Initialize the CurrencyController instance
  final CurrencyController controller = Get.put(CurrencyController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: controller.formKey, // Use the correct form key
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Center(
                      child: Image.asset('assets/five.png',
                          height: 320, width: 320, fit: BoxFit.fill),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: const SizedBox(
                      height: 50,
                    ),
                  ),
                  // Input field for amount
                  FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        controller.updateAmount(value);
                      },
                    ),
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: const SizedBox(height: 20)),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Obx(() => DropdownButton<String>(
                              hint: const Text("From"),
                              value: controller.selectedFromCurrency.isNotEmpty
                                  ? controller.selectedFromCurrency.value
                                  : null,
                              items: ['USD', 'INR', 'EUR', 'GBP']
                                  .map((String currency) {
                                return DropdownMenuItem<String>(
                                  value: currency,
                                  child: Text(currency),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.updateFromCurrency(newValue);
                                }
                              },
                            )),
                        const Icon(
                          Icons.swap_horiz,
                          size: 28,
                        ),
                        Obx(() => DropdownButton<String>(
                              hint: const Text("To"),
                              value: controller.selectedToCurrency.isNotEmpty
                                  ? controller.selectedToCurrency.value
                                  : null,
                              items: ['USD', 'GBP', 'EUR', 'INR']
                                  .map((String currency) {
                                return DropdownMenuItem<String>(
                                  value: currency,
                                  child: Text(currency),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.updateToCurrency(newValue);
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1250),
                      child: const SizedBox(height: 10)),
                  Obx(() => FadeInUp(
                        duration: const Duration(milliseconds: 1250),
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              " ${controller.convertedAmount.value.toStringAsFixed(2)} ${controller.selectedToCurrency.value}",
                              style: const TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ),
                        ),
                      )),
                  Obx(() => FadeInUp(
                        duration: const Duration(milliseconds: 1250),
                        child: Center(
                          child: Text(
                            "Exchange Rate: 1 ${controller.selectedFromCurrency.value} = ${controller.exchangeRate.value.toStringAsFixed(2)} ${controller.selectedToCurrency.value}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      )),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1250),
                    child: Center(
                      child: Text(
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          DateFormat.yMMMMEEEEd()
                              .format(DateTime.now())
                              .toString()),
                    ),
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1270),
                      child: const SizedBox(height: 20)),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1270),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 280,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          // Debugging output
                          print('ElevatedButton pressed');
                          final String token = widget.token; // Use the provided token
                          controller.addXChanged(token);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: primaryColor,
                        ),
                        child: const Text('Save',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
