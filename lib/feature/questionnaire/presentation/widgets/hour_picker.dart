import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimePickerWidget extends StatefulWidget {
  final Function(String) onTimeSelected;

  const TimePickerWidget({super.key, required this.onTimeSelected});

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  var hour = 9; // Default to 9 AM
  var minute = 0;
  var timeFormat = "AM";

  String get formattedTime =>
      "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $timeFormat";

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF7EB09B);
    const textPrimary = Color(0xFF2D3748);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            "Select Time: $formattedTime",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Hour picker
              NumberPicker(
                minValue: 1,
                maxValue: 12,
                value: hour,
                zeroPad: true,
                infiniteLoop: true,
                itemWidth: 60,
                itemHeight: 50,
                onChanged: (value) {
                  setState(() {
                    hour = value;
                  });
                },
                textStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                selectedTextStyle: const TextStyle(
                  color: textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                ":",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Minute picker
              NumberPicker(
                minValue: 0,
                maxValue: 59,
                value: minute,
                zeroPad: true,
                infiniteLoop: true,
                itemWidth: 60,
                itemHeight: 50,
                onChanged: (value) {
                  setState(() {
                    minute = value;
                  });
                },
                textStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                selectedTextStyle: const TextStyle(
                  color: textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // AM/PM selector
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        timeFormat = "AM";
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            timeFormat == "AM" ? primary : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              timeFormat == "AM"
                                  ? primary
                                  : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        "AM",
                        style: TextStyle(
                          color:
                              timeFormat == "AM" ? Colors.white : textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        timeFormat = "PM";
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            timeFormat == "PM" ? primary : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              timeFormat == "PM"
                                  ? primary
                                  : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        "PM",
                        style: TextStyle(
                          color:
                              timeFormat == "PM" ? Colors.white : textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onTimeSelected(formattedTime);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Add Time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
