import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Registration Card',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EventRegistrationScreen(),
    );
  }
}

class EventRegistrationScreen extends StatefulWidget {
  const EventRegistrationScreen({super.key});

  @override
  State<EventRegistrationScreen> createState() =>
      _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  // Global Key for Form Validation
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Dropdown Values
  String? _selectedDepartment;
  String? _selectedYear;

  // Toggle State (Form UI vs Confirmation UI)
  bool _isSubmitted = false;

  // Dropdown Data Lists
  final List<String> _departments = const [
    'Biology',
    'Botany',
    'Chemistry',
    'Computer Science',
    'English',
    'Islamiat',
    'Information Technology',
    'Physics',
    'Political Science',
    'Zoology',
  ];

  final List<String> _years = const [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Reset function to restore empty form state
  void _resetForm() {
    setState(() {
      _isSubmitted = false;
      _selectedDepartment = null;
      _selectedYear = null;
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.purple, Colors.indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: _isSubmitted ? _buildSuccessCard() : _buildFormUI(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // UI 1: Registration Form
  Widget _buildFormUI() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Event Registration Card',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // --- Name Field ---
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              hintText: 'Enter your name',
              prefixIcon: const Icon(Icons.person, color: Colors.deepPurple),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.deepPurple.shade50,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              // Validates standard alphabet characters and spaces only
              final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
              if (!nameRegex.hasMatch(value.trim())) {
                return 'Name cannot contain numbers or special characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // --- Email Field ---
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              hintText: 'Enter your email',
              prefixIcon: const Icon(Icons.email, color: Colors.deepPurple),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.deepPurple.shade50,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@') || !value.contains('.')) {
                return 'Email must contain "@" and "."';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // --- Phone Field ---
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone',
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              hintText: 'Enter 11 digit phone number',
              prefixIcon: const Icon(Icons.phone, color: Colors.deepPurple),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.deepPurple.shade50,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter phone number';
              }
              final phoneRegex = RegExp(r'^\d{11}$');
              if (!phoneRegex.hasMatch(value.trim())) {
                return 'Phone number must be exactly 11 digits';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // --- Department Dropdown ---
          DropdownButtonFormField<String>(
            initialValue: _selectedDepartment,
            hint: const Text('Select department'),
            decoration: InputDecoration(
              labelText: 'Department',
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              prefixIcon: const Icon(Icons.school, color: Colors.deepPurple),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.deepPurple.shade50,
            ),
            items: _departments.map((String dept) {
              return DropdownMenuItem<String>(value: dept, child: Text(dept));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedDepartment = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your department';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // --- Year Dropdown ---
          DropdownButtonFormField<String>(
            initialValue: _selectedYear,
            hint: const Text('Select year'),
            decoration: InputDecoration(
              labelText: 'Year',
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              prefixIcon: const Icon(
                Icons.calendar_today,
                color: Colors.deepPurple,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.deepPurple.shade50,
            ),
            items: _years.map((String yr) {
              return DropdownMenuItem<String>(value: yr, child: Text(yr));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedYear = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select year';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // --- Submit Button ---
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 60,
                ),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isSubmitted = true;
                  });
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Semi-bold text
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // UI 2: Confirmation Screen + RESET Button
  Widget _buildSuccessCard() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.check_circle_rounded, color: Colors.green, size: 64),
        const SizedBox(height: 90.0),
        const Text(
          'Registration Successful!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 12),

        // Output Summary
        _buildDataRow('Name:', _nameController.text),
        _buildDataRow('Email:', _emailController.text),
        _buildDataRow('Phone:', _phoneController.text),
        _buildDataRow('Department:', _selectedDepartment ?? ''),
        _buildDataRow('Year:', _selectedYear ?? ''),

        const SizedBox(height: 24),

        // --- RESET Button ---
        Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _resetForm,
            icon: const Icon(Icons.refresh),
            label: const Text(
              'RESET',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
