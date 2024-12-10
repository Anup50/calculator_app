import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  String displayText = ""; // Holds the current input/output value
  String previousText = ""; // Stores the previous input for operations
  String operation = ""; // Stores the current operation (e.g., +, -, *, /)
  bool isResultDisplayed =
      false; // Flag to track if the displayed value is a result

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anup Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Display the previous number and operation
            if (previousText.isNotEmpty && operation.isNotEmpty)
              Text(
                "$previousText $operation",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey, // Fainter text color
                ),
              ),
            const SizedBox(height: 4),
            // Main input/output display
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              readOnly: true, // Make the field read-only
              textAlign: TextAlign.right, // Align text to the right
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 187, 218, 172),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        String value = lstSymbols[index];

                        if (value == "C") {
                          // Clear the input
                          displayText = "";
                          previousText = "";
                          operation = "";
                          isResultDisplayed = false;
                        } else if (value == "<-") {
                          // Backspace: Remove the last character
                          if (displayText.isNotEmpty) {
                            displayText = displayText.substring(
                                0, displayText.length - 1);
                          }
                          isResultDisplayed = false;
                        } else if (value == "=") {
                          // Evaluate the expression
                          if (previousText.isNotEmpty &&
                              displayText.isNotEmpty &&
                              operation.isNotEmpty) {
                            double num1 = double.tryParse(previousText) ?? 0.0;
                            double num2 = double.tryParse(displayText) ?? 0.0;
                            double result = 0.0;

                            if (operation == "+") {
                              result = num1 + num2;
                            } else if (operation == "-") {
                              result = num1 - num2;
                            } else if (operation == "*") {
                              result = num1 * num2;
                            } else if (operation == "/") {
                              result = num2 != 0
                                  ? num1 / num2
                                  : 0.0; // Avoid division by zero
                            } else if (operation == "%") {
                              result = num1 % num2;
                            }

                            displayText = result.toString();
                            previousText = "";
                            operation = "";
                            isResultDisplayed =
                                true; // Mark the result as displayed
                          }
                        } else if (value == "+" ||
                            value == "-" ||
                            value == "*" ||
                            value == "/" ||
                            value == "%") {
                          // Save the current value and set the operation
                          if (displayText.isNotEmpty) {
                            previousText = displayText;
                            displayText = "";
                            operation = value;
                            isResultDisplayed = false;
                          }
                        } else {
                          // Check if result is displayed, clear it if a number is entered
                          if (isResultDisplayed) {
                            displayText = "";
                            isResultDisplayed = false;
                          }
                          // Append the number or decimal to the display
                          displayText += value;
                        }

                        _textController.text =
                            displayText; // Update the text field
                      });
                    },
                    child: Text(
                      lstSymbols[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
