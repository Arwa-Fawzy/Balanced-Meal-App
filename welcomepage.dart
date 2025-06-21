import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/orange.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Progress indicator (hidden by default at 0%?)
              const SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  value: 0.0,
                  backgroundColor: Colors.transparent,
                  color: Color(0xFFFE8C00),
                  minHeight: 10,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Title Text
              const Text(
                'Balanced Meal',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Subtitle Text
              const Text(
                'Ready to start an order?',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Order Button
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, 'addmyinfo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE8C00),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Order Food',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}