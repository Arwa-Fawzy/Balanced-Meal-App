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

// FlutterFlow Imports
import '/flutter_flow/flutter_flow_widgets.dart';

class UserInfoForm {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String gender = 'Male';

  void dispose() {
    weightController.dispose();
    heightController.dispose();
    ageController.dispose();
  }

  bool isValid() {
    return weightController.text.isNotEmpty &&
        heightController.text.isNotEmpty &&
        ageController.text.isNotEmpty;
  }

  double get weight => double.tryParse(weightController.text) ?? 0;
  double get height => double.tryParse(heightController.text) ?? 0;
  int get age => int.tryParse(ageController.text) ?? 0;
}

class AddMyInfoWidget extends StatefulWidget {
  const AddMyInfoWidget({
    super.key,
    this.width,
    this.height,
    this.backgroundColor,
  });

  final double? width;
  final double? height;
  final Color? backgroundColor;

  @override
  State<AddMyInfoWidget> createState() => _AddMyInfoWidgetState();
}

class _AddMyInfoWidgetState extends State<AddMyInfoWidget> {
  final UserInfoForm _userInfo = UserInfoForm();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userInfo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add My Info'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.white,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🟠 Image directly under AppBar
                Center(
                  child: Image.asset(
                    'assets/orange_annotated-6ad01c6d9b4d4e4cbb1cdd687f78877a.jpg',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  value: _userInfo.gender,
                  decoration: _inputDecoration('Gender'),
                  items: ['Male', 'Female'].map((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _userInfo.gender = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Weight
                _buildTextField(
                  controller: _userInfo.weightController,
                  label: 'Weight (kg)',
                  validatorMsg: 'Please enter your weight',
                ),
                const SizedBox(height: 20),

                // Height
                _buildTextField(
                  controller: _userInfo.heightController,
                  label: 'Height (cm)',
                  validatorMsg: 'Please enter your height',
                ),
                const SizedBox(height: 20),

                // Age
                _buildTextField(
                  controller: _userInfo.ageController,
                  label: 'Age',
                  validatorMsg: 'Please enter your age',
                ),
                const SizedBox(height: 40),

                // ✅ Calculate Button
                FFButtonWidget(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final calories = calculateCalories(
                        _userInfo.gender,
                        _userInfo.weight.toInt(),
                        _userInfo.height.toInt(),
                        _userInfo.age,
                      );

                      FFAppState().update(() {
                        FFAppState().dailyCalories = calories;
                        FFAppState().userGender = _userInfo.gender;
                      });

                      context.pushNamed('PlaceOrderPage');
                    }
                  },
                  text: 'Calculate Calories',
                  options: FFButtonOptions(
                    width: 200,
                    height: 50,
                    color: const Color(0xFFFE8C00),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String validatorMsg,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: _inputDecoration(label),
      validator: (value) =>
          value == null || value.isEmpty ? validatorMsg : null,
    );
  }
}