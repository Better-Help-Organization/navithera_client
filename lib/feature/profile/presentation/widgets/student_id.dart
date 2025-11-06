import 'package:flutter/material.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class StudentIdPage extends StatelessWidget {
  const StudentIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.studentId,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Graduation Cap Icon
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.green.shade50, // Light green background
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.school, // Using school icon for graduation cap
                size: 60,
                color: Colors.green.shade700, // Darker green icon color
              ),
            ),
            const SizedBox(height: 32.0),

            // Description Text
            Text(
              AppLocalizations.of(context)!.verifyStudentProfile,
              //textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.5, // Line height for better readability
              ),
            ),
            const SizedBox(height: 24.0),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.youllEnjoyBenefits,

                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 16.0),

            // List of Benefits
            _buildBenefitRow(AppLocalizations.of(context)!.discountOffer),
            const SizedBox(height: 12.0),
            //_buildBenefitRow('Access to Student Only Perks & Merch'),
            // const SizedBox(height: 12.0),
            _buildBenefitRow(
              AppLocalizations.of(context)!.representationOpportunity,
            ),
            const SizedBox(height: 48.0), // Increased spacing before button
            // Apply Now Button
            SizedBox(
              width: double.infinity, // Make button full width
              child: ElevatedButton(
                onPressed: () {
                  // Handle Apply Now action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ), // Rounded corners
                  ),
                  elevation: 0, // No shadow
                ),
                child: Text(
                  AppLocalizations.of(context)!.applyNow,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            // Learn More Text Button
            TextButton(
              onPressed: () {
                // Handle Learn More action
              },
              child: Text(
                AppLocalizations.of(context)!.learnMore,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a benefit row with checkmark icon
  Widget _buildBenefitRow(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle, // Checkmark icon
          color: Colors.green.shade700, // Green color for checkmark
          size: 20,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
