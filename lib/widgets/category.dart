import 'expense.dart';

class Category {
  final String name;
  List<Expense> expenses; // Store individual expenses for the category

  Category({required this.name, List<Expense>? expenses})
      : this.expenses = expenses ?? [];

  // Calculate the total expense for the category
  double get totalExpense {
    return expenses.fold(0.0, (double sum, Expense expense) => sum + expense.amount);
  }

  // Add an expense to the category
  void addExpense(Expense expense) {
    expenses.add(expense);
  }

  // Remove an expense from the category
  void removeExpense(Expense expense) {
    expenses.remove(expense);
  }
}

