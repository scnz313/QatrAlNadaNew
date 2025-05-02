import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Last updated: April 30, 2025',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 24),
            Text(
              'Introduction',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Welcome to Qatr Al Nada. We respect your privacy and are committed to protecting your personal data. This privacy policy will inform you about how we look after your personal data when you use our application and tell you about your privacy rights.',
            ),
            SizedBox(height: 16),
            Text(
              'Information We Collect',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Our app does not collect any personal information. We do not require you to create an account, and we do not track your usage or behavior within the app.',
            ),
            SizedBox(height: 16),
            Text(
              'Data Storage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'All data used by the application is stored locally on your device. We do not upload or store any of your information on remote servers.',
            ),
            SizedBox(height: 16),
            Text(
              'Third-Party Services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Our app does not integrate with any third-party services that would collect your data.',
            ),
            SizedBox(height: 16),
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions about this Privacy Policy, please contact us:',
            ),
            SizedBox(height: 8),
            Text(
              'USMAN BHAT',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Email: apps.usmanbhatt@gmail.com'),
          ],
        ),
      ),
    );
  }
}
