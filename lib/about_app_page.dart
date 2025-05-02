import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('About the App'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'شرح قطر الندى وبل الصدى',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            Center(
              child: Text(
                'By ابن هشام الأنصاري',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'About the Author',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ibn Hisham (d. 761 AH / 1360 CE) was one of the foremost grammarians of the Arabic language. A native of Egypt, he was deeply grounded in both grammar and Islamic sciences. His works are widely studied in traditional Islamic institutions for their clarity, depth, and logical structure.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'About the Book',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '"Qatr al-Nada" is one of his most accessible yet profound texts in nahw, written for students beginning their journey in Arabic grammar. This app contains both the original text and Ibn Hisham\'s own commentary (sharh), making it a valuable tool for learners and scholars alike.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Features:',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildFeatureItem(theme, '• Clean and easy-to-read interface'),
                  _buildFeatureItem(theme, '• Arabic text fully vowelled (with tashkeel)'),
                  _buildFeatureItem(theme, '• Bookmark and search functionality'),
                  _buildFeatureItem(theme, '• Offline access'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'This app presents the timeless classic "شرح قطر الندى وبلّ الصدى" (Sharh Qatr al-Nada wa-Ball al-Sada), a renowned work on Arabic grammar (nahw) authored by the eminent scholar Ibn Hisham al-Ansari (ابن هشام الأنصاري).',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Ideal for students of Arabic language, classical studies, or anyone interested in the treasures of Arabic grammar.',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Version 2.0.0',
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
