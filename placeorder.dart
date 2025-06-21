// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';
//import 'package:firebase/firebase.dart' as firebase;

class PlaceOrderWidget extends StatefulWidget {
  const PlaceOrderWidget({
    super.key,
    this.width,
    this.height,
    required this.dailyCalories,
  });

  final double? width;
  final double? height;
  final double dailyCalories;

  @override
  State<PlaceOrderWidget> createState() => _PlaceOrderWidgetState();
}

class _PlaceOrderWidgetState extends State<PlaceOrderWidget> {
  List<Map<String, dynamic>> selectedItems = [];
  double currentCalories = 0;
  List<Map<String, dynamic>> meats = [];
  List<Map<String, dynamic>> vegetables = [];
  List<Map<String, dynamic>> carbs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchIngredients();
  }

  Future<void> _fetchIngredients() async {
    try {
      final firestore = firebase.firestore();

      final meatSnapshot = await firestore.collection('meats').get();
      final vegSnapshot = await firestore.collection('vegetables').get();
      final carbSnapshot = await firestore.collection('carbs').get();

      setState(() {
        meats = meatSnapshot.docs.map((doc) => doc.data()).toList();
        vegetables = vegSnapshot.docs.map((doc) => doc.data()).toList();
        carbs = carbSnapshot.docs.map((doc) => doc.data()).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching ingredients: $e');
      setState(() => isLoading = false);
    }
  }

  void _addItem(Map<String, dynamic> item) {
    setState(() {
      selectedItems.add(item);
      currentCalories += item['calories'] ?? 0;
    });
  }

  void _removeItem(Map<String, dynamic> item) {
    setState(() {
      selectedItems.remove(item);
      currentCalories -= item['calories'] ?? 0;
    });
  }

  double get _caloriePercentage =>
      (currentCalories / widget.dailyCalories) * 100;
  bool get _canPlaceOrder =>
      _caloriePercentage >= 90 && _caloriePercentage <= 110;

  Future<void> _placeOrder() async {
    if (!_canPlaceOrder) return;

    final orderData = {
      'items': selectedItems
          .map((item) => {
                'name': item['food_name'],
                'total_price': item['price'] ?? 0,
                'quantity': item['quantity'] ?? 1,
              })
          .toList(),
    };

    try {
      final response = await FFAppState().placeOrder(orderData);
      if (response == true) {
        context.pushNamed('HomePage');
      }
    } catch (e) {
      print('Order failed: $e');
    }
  }

  Widget _buildIngredientCard(Map<String, dynamic> item) {
    return Card(
      child: ListTile(
        leading: Image.network(
          item['image_url'],
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Icon(Icons.fastfood),
        ),
        title: Text(item['food_name']),
        subtitle: Text('${item['calories']} cal per 100g'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => _removeItem(item),
            ),
            Text(
                '${selectedItems.where((i) => i['food_name'] == item['food_name']).length}'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _addItem(item),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.all(16),
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Calorie Goal Section
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('Daily Calorie Goal'),
                        Text(
                            'Target: ${widget.dailyCalories.toStringAsFixed(0)} cal'),
                        Text(
                            'Current: ${currentCalories.toStringAsFixed(0)} cal'),
                        LinearProgressIndicator(
                          value: _caloriePercentage / 100,
                          backgroundColor: Colors.grey[200],
                          color: _canPlaceOrder ? Colors.green : Colors.orange,
                        ),
                        Text(
                            '${_caloriePercentage.toStringAsFixed(1)}% of goal'),
                        if (_canPlaceOrder)
                          Text('Within 10% of goal - Ready to order!'),
                      ],
                    ),
                  ),
                ),

                // Ingredient Selection
                Expanded(
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          tabs: [
                            Tab(text: 'Meats'),
                            Tab(text: 'Vegetables'),
                            Tab(text: 'Carbs'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              ListView.builder(
                                itemCount: meats.length,
                                itemBuilder: (_, i) =>
                                    _buildIngredientCard(meats[i]),
                              ),
                              ListView.builder(
                                itemCount: vegetables.length,
                                itemBuilder: (_, i) =>
                                    _buildIngredientCard(vegetables[i]),
                              ),
                              ListView.builder(
                                itemCount: carbs.length,
                                itemBuilder: (_, i) =>
                                    _buildIngredientCard(carbs[i]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Place Order Button
                FFButtonWidget(
                  onPressed: _canPlaceOrder ? _placeOrder : null,
                  text: 'Place Order',
                  options: FFButtonOptions(
                    width: double.infinity,
                    color: _canPlaceOrder ? Color(0xFFFE8C00) : Colors.grey,
                  ),
                ),
              ],
            ),
    );
  }
}
