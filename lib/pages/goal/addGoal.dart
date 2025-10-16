import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:journapp/common/bottomNavigationBar.dart';

class AddGoalPage extends StatefulWidget {
  const AddGoalPage({super.key});

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedFrequency;
  String? selectedColor;
  DateTime? selectedDate;
  double _progress = 0.0;

  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> frequencies = [
    "Every day",
    "3 times a week",
    "Once a week",
    "Twice a month",
    "Once a month",
  ];

  final List<String> colors = ["Red", "Green", "Blue", "Cream"];
  int _currentIndex = 0;

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  Widget _shadowContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  // Color _getColor(String? name) {
  //   switch (name) {
  //     case "Red":
  //       return Colors.red;
  //     case "Green":
  //       return Colors.green;
  //     case "Blue":
  //       return Colors.blue;
  //     case "Cream":
  //       return const Color(0xFFFFFDD0);
  //     case "Purple":
  //       return Colors.purple;
  //     case "Teal":
  //       return Colors.teal;
  //     case "Orange":
  //       return Colors.orange;
  //     case "Pink":
  //       return Colors.pinkAccent;
  //     case "Yellow":
  //       return Colors.yellow;
  //     case "Grey":
  //       return Colors.grey;
  //     default:
  //       return Colors.grey;
  //   }
  // }

  final Map<String, Color> colorOptions = {
    "Red": Colors.red,
    "Green": Colors.green,
    "Blue": Colors.blue,
    "Cream": const Color(0xFFFFFDD0),
    "Purple": Colors.purple,
    "Teal": Colors.teal,
    "Orange": Colors.orange,
    "Pink": Colors.pinkAccent,
    "Yellow": Colors.yellow,
    "Grey": Colors.grey,
  };

  void _saveGoal() {
    if (_formKey.currentState!.validate()) {
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Goal saved successfully!"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _confirmDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Goal"),
        content: const Text("Are you sure you want to delete this goal?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Goal deleted."),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Goals",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: _confirmDelete,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/g.png",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Current Goal
              const Text("Current Goal"),
              const SizedBox(height: 6),
              _shadowContainer(
                child: TextFormField(
                  controller: _goalController,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your goal title" : null,
                  decoration: _inputDecoration("Enter your goal title"),
                ),
              ),
              const SizedBox(height: 16),

              // Describe Goal
              const Text("Describe Goal"),
              const SizedBox(height: 6),
              _shadowContainer(
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: _inputDecoration("Add Description"),
                ),
              ),
              const SizedBox(height: 16),

              // Frequency
              const Text("Frequency and Reminder"),
              const SizedBox(height: 6),
              _shadowContainer(
                child: DropdownButtonFormField<String>(
                  value: selectedFrequency,
                  decoration: _inputDecoration(
                    "Select frequency",
                  ).copyWith(prefixIcon: const Icon(Icons.repeat)),
                  items: frequencies
                      .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFrequency = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Please select a frequency" : null,
                ),
              ),
              const SizedBox(height: 16),

              // Tile color
              const Text("Tile color"),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: _shadowContainer(
                      child: DropdownButtonFormField<String>(
                        value: selectedColor,
                        items: colorOptions.entries
                            .map(
                              (entry) => DropdownMenuItem(
                                value: entry.key,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        color: entry.value,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                      ),
                                    ),
                                    Text(entry.key),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedColor = value;
                          });
                        },
                        decoration: _inputDecoration("Select color"),
                      ),
                    ),
                  ),
                  if (selectedColor != null) ...[
                    const SizedBox(width: 12),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: colorOptions[selectedColor],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 16),

              // Target date
              const Text("Target Date"),
              const SizedBox(height: 6),
              _shadowContainer(
                child: ListTile(
                  title: Text(
                    selectedDate == null
                        ? "Select target date"
                        : DateFormat.yMMMd().format(selectedDate!),
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => selectedDate = picked);
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Progress
              const Text("Progress"),
              const SizedBox(height: 6),
              _shadowContainer(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Slider(
                        value: _progress,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: "${_progress.toInt()}%",
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            _progress = value;
                          });
                        },
                      ),
                      Text("${_progress.toInt()}%"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Save button (now at the bottom)
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: _saveGoal,
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom nav bar
      bottomNavigationBar: SafeArea(
        top: false,
        child: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
