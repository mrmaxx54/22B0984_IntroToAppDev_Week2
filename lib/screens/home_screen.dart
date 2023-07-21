import 'package:flutter/material.dart';
import '../widgets/category.dart';
import 'expense_screen.dart';
import 'add_category_popup.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Category> dummyCategories = [];
  double totalExpense = 0.0;

  void deleteCategory(Category category) {
    setState(() {
      dummyCategories.remove(category);
    });
    _updateTotalExpense(); // Update totalExpense for Home screen
  }

  void _showAddCategoryPopup() async {
    Category? newCategory = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddCategoryPopup();
      },
    );

    if (newCategory != null) {
      setState(() {
        dummyCategories.add(newCategory);
      });
      _updateTotalExpense(); // Update totalExpense for Home screen
    }
  }

  // Calculate the total expense for all categories in the Home screen
  void _updateTotalExpense() {
    double totalExpense = dummyCategories.fold(0.0, (sum, category) => sum + category.totalExpense);
    setState(() {
      this.totalExpense = totalExpense;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Budget Tracker"),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage('image/profile.png'),
              radius: 40.0,
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Text(
              '** Welcome Back **',
              style: TextStyle(
                color: Colors.grey[900],
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            height: 25.0,
            color: Colors.grey[500],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: dummyCategories.length,
                itemBuilder: (context, index) {
                  final category = dummyCategories[index];
                  return Card(
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                        child: Text(
                            category.name,
                            style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Text(
                          'Total Expense: ${category.totalExpense.toStringAsFixed(2)}',
                          style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 17.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExpenseScreen(category: category, updateTotalExpense: _updateTotalExpense),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteCategory(category); // Call the delete function
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
        backgroundColor: Colors.green,
        onPressed: _showAddCategoryPopup,
        child: Icon(Icons.add),
      ),
    );
  }
}
