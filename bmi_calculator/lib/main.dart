import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator', // Updated title
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade700), // Deeper purple for a richer feel
        useMaterial3: true,
        fontFamily: 'Montserrat', // A modern, clean font
      ),
      home: const MyHomePage(title: 'BMI Calculator'), // Updated title
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();

  String result = "Enter your details to calculate BMI"; // Initial helpful message
  Color resultColor = Colors.white; // Default color for result text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary, // Using theme primary color
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // White and bold title
        ),
        centerTitle: true, // Center the title in the AppBar
        elevation: 4, // Add a subtle shadow
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.shade800,
              Colors.deepPurple.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0), // More generous padding
            child: SingleChildScrollView( // Allows scrolling if keyboard covers fields
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'BMI Calculator', // Clear heading for the app
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      color: Colors.white, // White text for contrast
                      letterSpacing: 1.5, // Spaced out letters for a modern look
                    ),
                  ),
                  const SizedBox(height: 30), // More vertical space

                  // Weight Input
                  _buildTextField(
                    controller: wtController,
                    labelText: 'Weight (Kgs)',
                    icon: Icons.monitor_weight_outlined, // More specific icon
                  ),
                  const SizedBox(height: 20),

                  // Height - Feet Input
                  _buildTextField(
                    controller: ftController,
                    labelText: 'Height (Feet)',
                    icon: Icons.height_outlined,
                  ),
                  const SizedBox(height: 20),

                  // Height - Inches Input
                  _buildTextField(
                    controller: inController,
                    labelText: 'Height (Inches)',
                    icon: Icons.height,
                  ),
                  const SizedBox(height: 30),

                  // Calculate Button
                  SizedBox(
                    width: double.infinity, // Make button full width
                    height: 55, // Taller button for better tap target
                    child: ElevatedButton(
                      onPressed: () {
                        var wt = wtController.text.toString();
                        var ft = ftController.text.toString();
                        var inch = inController.text.toString();

                        if (wt != '' && ft != '' && inch != '') {
                          // BMI calculation
                          var iwt = double.parse(wt); // Parse as double for more precision
                          var ift = double.parse(ft);
                          var iinch = double.parse(inch);

                          var totalInches = (ift * 12) + iinch;
                          var totalCentimeters = totalInches * 2.54;
                          var totalMeters = totalCentimeters / 100;
                          var bmi = iwt / (totalMeters * totalMeters);

                          // Determine BMI category and color
                          String bmiCategory;
                          if (bmi < 18.5) {
                            bmiCategory = "Underweight";
                            resultColor = Colors.orangeAccent;
                          } else if (bmi >= 18.5 && bmi <= 24.9) {
                            bmiCategory = "Normal Weight";
                            resultColor = Colors.greenAccent;
                          } else if (bmi >= 25.0 && bmi <= 29.9) {
                            bmiCategory = "Overweight";
                            resultColor = Colors.orange;
                          } else {
                            bmiCategory = "Obese";
                            resultColor = Colors.redAccent;
                          }

                          setState(() {
                            result =
                            "Your BMI is: ${bmi.toStringAsFixed(2)}\n($bmiCategory)"; // More detailed result
                          });
                        } else {
                          setState(() {
                            result = "Please fill all the required fields!";
                            resultColor = Colors.redAccent; // Error message in red
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.limeAccent, // A vibrant button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Rounded corners
                        ),
                        elevation: 5, // Add shadow to the button
                      ),
                      child: const Text(
                        'CALCULATE BMI',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple, // Text color that contrasts well
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Result Display
                  Text(
                    result,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: resultColor, // Dynamic color based on result
                      height: 1.5, // Line height for better readability
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create stylish TextFields
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white70), // Lighter label text
        prefixIcon: Icon(icon, color: Colors.limeAccent), // Icon matching button color
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white54, width: 1.5), // Subtle border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.limeAccent, width: 2), // Highlight on focus
        ),
        fillColor: Colors.white.withOpacity(0.1), // Slightly transparent background
        filled: true,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white, fontSize: 18), // Input text color
      cursorColor: Colors.limeAccent, // Cursor color
    );
  }
}