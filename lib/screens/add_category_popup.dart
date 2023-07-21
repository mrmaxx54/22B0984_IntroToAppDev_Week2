import 'package:flutter/material.dart';
import '../widgets/category.dart';

class AddCategoryPopup extends StatefulWidget {
  @override
  _AddCategoryPopupState createState() => _AddCategoryPopupState();
}

class _AddCategoryPopupState extends State<AddCategoryPopup> {
  TextEditingController _categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Category'),
      content: TextField(
        controller: _categoryNameController,
        decoration: InputDecoration(
          labelText: 'Category Name',
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            String categoryName = _categoryNameController.text.trim();
            if (categoryName.isNotEmpty) {
              Category newCategory = Category(name: categoryName);
              Navigator.of(context).pop(newCategory);
            }
          },
          child: Text('Add'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
