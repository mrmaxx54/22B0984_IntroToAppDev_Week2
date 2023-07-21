import 'package:flutter/material.dart';
import '../widgets/expense.dart'; // Import the Expense class

class AddExpensePopup extends StatefulWidget {
  @override
  _AddExpensePopupState createState() => _AddExpensePopupState();
}

class _AddExpensePopupState extends State<AddExpensePopup> {
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('New Entry')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            String description = _descriptionController.text;
            double amount = double.tryParse(_amountController.text) ?? 0.0;

            if (description.isNotEmpty && amount > 0) {
              // Pass the new entry back to the ExpenseScreen
              Navigator.of(context).pop(Expense(description: description, amount: amount));
            } else {
              // Show an error message if any of the fields are empty or invalid
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Invalid Input'),
                  content: Text('Please enter a valid description and amount.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
