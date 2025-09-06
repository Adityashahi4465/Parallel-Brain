import 'package:fintech/core/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../app_colors.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController liquidityController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  bool isDeadStock = false;

  void saveItem() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> data = {
        "name": nameController.text.trim(),
        "price": double.tryParse(priceController.text) ?? 0,
        "category": categoryController.text.trim(),
        "Qty": int.tryParse(qtyController.text) ?? 0,
        "isDeadStock": isDeadStock,
        "added_on": Timestamp.now(),
        "recommendation": {
          if (liquidityController.text.isNotEmpty)
            "Liquidity": liquidityController.text.trim(),
          if (discountController.text.isNotEmpty)
            "Discount": double.tryParse(discountController.text) ?? 0,
        },
      };

      await FirebaseFirestore.instance.collection('items').add(data);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Item added successfully')));

      // Clear fields
      nameController.clear();
      priceController.clear();
      categoryController.clear();
      qtyController.clear();
      liquidityController.clear();
      discountController.clear();
      setState(() => isDeadStock = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Inventory Item'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: "Item Name",
                height: 60,
                isPassword: false,
                controller: nameController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter item name' : null,
                prefixIcon: Icons.shopping_bag,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: "Price",
                height: 60,
                isPassword: false,
                controller: priceController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter price' : null,
                prefixIcon: Icons.attach_money,
                onChanged: (v) {},
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: "Category",
                height: 60,
                isPassword: false,
                controller: categoryController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter category' : null,
                prefixIcon: Icons.category,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: "Quantity",
                height: 60,
                isPassword: false,
                controller: qtyController,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter quantity' : null,
                prefixIcon: Icons.format_list_numbered,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text("Is Dead Stock?", style: TextStyle(fontSize: 16)),
                  Switch(
                    value: isDeadStock,
                    onChanged: (val) => setState(() => isDeadStock = val),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: "Recommendation - Liquidity Email",
                height: 60,
                isPassword: false,
                controller: liquidityController,
                validator: (_) => null,
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                label: "Recommendation - Discount %",
                height: 60,
                isPassword: false,
                controller: discountController,
                validator: (_) => null,
                prefixIcon: Icons.percent,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: saveItem,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Add Item", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
