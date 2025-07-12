import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'about_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF00A699),
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF222222),
            fontFamily: 'Noto',
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF222222),
            fontFamily: 'Noto',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
          headlineLarge: TextStyle(
            fontSize: 28.0,
            color: Color(0xFF222222),
            fontFamily: 'Noto',
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
            fontSize: 24.0,
            color: Color(0xFF222222),
            fontFamily: 'Noto',
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            fontSize: 20.0,
            color: Color(0xFF222222),
            fontFamily: 'Noto',
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontSize: 18.0,
            color: Color(0xFF222222),
            fontFamily: 'Noto',
            fontWeight: FontWeight.w500,
          ),
          labelLarge: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontFamily: 'Noto',
            fontWeight: FontWeight.w600,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00A699),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Noto',
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          margin: EdgeInsets.zero,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00A699),
            foregroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Noto',
            ),
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFFE1E1E1),
          thickness: 1,
          space: 1,
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF00A699),
          size: 24,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF7F7F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF00A699), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<dynamic> data = [];
  int currentIndex = 0;
  double fontSize = 18.0;
  double minFontSize = 14.0;
  double maxFontSize = 28.0;
  String currentFont = 'Noto';

  final List<String> fontOptions = ['Noto', 'Noor', 'Amiri'];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    setState(() {
      data = json.decode(jsonString);
    });
  }

  void increaseFontSize() {
    setState(() {
      if (fontSize < maxFontSize) fontSize += 2.0;
    });
  }

  void decreaseFontSize() {
    setState(() {
      if (fontSize > minFontSize) fontSize -= 2.0;
    });
  }

  void changeFont(String font) {
    setState(() {
      currentFont = font;
    });
  }

  void nextPage() {
    if (currentIndex < data.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void navigateToPage(int index) {
    setState(() {
      currentIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("شرح قطرالندى"),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.format_list_bulleted),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: _buildSettingsDrawer(),
      endDrawer: _buildChaptersDrawer(),
      body: _buildMainContent(),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildSettingsDrawer() {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader('Settings', Icons.settings),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildDrawerItem(
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  icon: Icons.info,
                  title: 'About Us',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutPage()),
                    );
                  },
                ),
                const Divider(height: 32),
                _buildDrawerItem(
                  icon: Icons.security,
                  title: 'Privacy Policy',
                  onTap: () => _launchPrivacyPolicy(),
                ),
                const Divider(height: 32),
                _buildFontSettings(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChaptersDrawer() {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader('Chapters', Icons.book),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: data.length,
              itemBuilder: (context, index) {
                var item = data[index];
                return _buildChapterItem(item, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(String title, IconData icon) {
    return Container(
      height: 140,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF00A699), Color(0xFF00B4A6)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.asset(
                'assets/img/head_drawer.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF00A699).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF00A699), size: 20),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: const Color(0xFF222222),
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }

  Widget _buildChapterItem(dynamic item, int index) {
    final isSelected = currentIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF00A699).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: const Color(0xFF00A699), width: 2)
            : null,
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF00A699)
                : const Color(0xFF00A699).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF00A699),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        title: Text(
          item['title'],
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isSelected ? const Color(0xFF00A699) : const Color(0xFF222222),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        onTap: () => navigateToPage(index),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildFontSettings() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Font Settings",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: const Color(0xFF222222),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE1E1E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentFont,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00A699)),
                iconSize: 24,
                style: const TextStyle(color: Color(0xFF222222)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onChanged: (String? newFont) {
                  if (newFont != null) {
                    changeFont(newFont);
                    Navigator.pop(context);
                  }
                },
                items: fontOptions.map<DropdownMenuItem<String>>((String font) {
                  return DropdownMenuItem<String>(
                    value: font,
                    child: Text(
                      font,
                      style: TextStyle(fontFamily: font),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: decreaseFontSize,
                  icon: const Icon(Icons.text_decrease, size: 18),
                  label: const Text("Smaller"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A699),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: increaseFontSize,
                  icon: const Icon(Icons.text_increase, size: 18),
                  label: const Text("Larger"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A699),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF00A699).withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00A699)),
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading content...',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF666666),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildChapterTitle(),
              const SizedBox(height: 24),
              Expanded(
                child: _buildChapterContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChapterTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00A699), Color(0xFF00B4A6)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00A699).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        data[currentIndex]['title'] ?? 'ﻻ يوجد شي',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Widget _buildChapterContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E1E1)),
      ),
      child: SingleChildScrollView(
        child: Text(
          data[currentIndex]['content'] ?? 'لا يوجد شئ',
          style: TextStyle(
            fontSize: fontSize,
            color: const Color(0xFF222222),
            height: 1.8,
            fontFamily: currentFont,
          ),
          textAlign: TextAlign.justify,
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavigationButton(
            onPressed: currentIndex > 0 ? previousPage : null,
            icon: Icons.arrow_back_ios,
            label: "Previous",
            isEnabled: currentIndex > 0,
          ),
          _buildPageIndicator(),
          _buildNavigationButton(
            onPressed: currentIndex < data.length - 1 ? nextPage : null,
            icon: Icons.arrow_forward_ios,
            label: "Next",
            isEnabled: currentIndex < data.length - 1,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
    required bool isEnabled,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? const Color(0xFF00A699) : const Color(0xFFE1E1E1),
        foregroundColor: isEnabled ? Colors.white : const Color(0xFF999999),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: isEnabled ? 0 : 0,
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF00A699).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF00A699).withOpacity(0.3)),
      ),
      child: Text(
        '${currentIndex + 1} / ${data.length}',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: const Color(0xFF00A699),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _launchPrivacyPolicy() async {
    final Uri url = Uri.parse(
        'https://quranichub.blogspot.com/p/qatar-al-nada-apps-policy.html');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Could not open privacy policy'),
              backgroundColor: const Color(0xFF00A699),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error opening privacy policy'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }
}
