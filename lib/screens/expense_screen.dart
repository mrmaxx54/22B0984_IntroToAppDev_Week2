import 'package:flutter/material.dart';
import '../widgets/category.dart';
import '../widgets/expense.dart';
import 'add_expense_popup.dart';

class ExpenseScreen extends StatefulWidget {
  final Category category;
  final Function updateTotalExpense;

  ExpenseScreen({required this.category, required this.updateTotalExpense});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {

  void addExpense(Expense expense) {
    setState(() {
      widget.category.expenses.add(expense);
    });
    widget.updateTotalExpense(); // Update totalExpense for Home screen
  }

  void deleteExpense(Expense expense) {
    setState(() {
      widget.category.expenses.remove(expense);
    });
    widget.updateTotalExpense(); // Update totalExpense for Home screen
  }

  void _showAddExpensePopup() async {
    Expense? newExpense = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddExpensePopup();
      },
    );

    if (newExpense != null) {
      addExpense(newExpense);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the total expense for the category based on the expenses list
    double totalExpense = widget.category.expenses.fold(0.0, (sum, expense) => sum + expense.amount);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: widget.category.expenses.length,
                itemBuilder: (context, index) {
                  final expense = widget.category.expenses[index];
                  return Card(
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                        child: Text(
                          expense.description,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        'Rs: ${expense.amount.toString()}',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 17.0,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteExpense(expense); // Call the delete function
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpensePopup,
        child: Icon(Icons.add),
      ),
    );
  }
}
