import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'about_page.dart'; // Import AboutPage
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
        primaryColor: const Color(0xFF00A699), // Airbnb primary green
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7), // Light gray background
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF222222), // Dark gray for better readability
            fontFamily: 'Noto',
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: TextStyle(
            fontSize: 24.0,
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
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00A699),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFFE1E1E1),
          thickness: 1,
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
  double fontSize = 18.0; // Adjusted default size
  double minFontSize = 12.0; // Minimum size
  double maxFontSize = 28.0; // Maximum size
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
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFF00A699),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/img/head_drawer.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      'Settings',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A699).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.home, color: Color(0xFF00A699)),
                    ),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A699).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.info, color: Color(0xFF00A699)),
                    ),
                    title: const Text('About Us'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutPage()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A699).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.security, color: Color(0xFF00A699)),
                    ),
                    title: const Text('Privacy Policy'),
                    onTap: () async {
                      final Uri url = Uri.parse(
                          'https://quranichub.blogspot.com/p/qatar-al-nada-apps-policy.html');
                      try {
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Could not open privacy policy'),
                                backgroundColor: Color(0xFF00A699),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error opening privacy policy'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Font Settings",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: const Color(0xFF222222),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE1E1E1)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            value: currentFont,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00A699)),
                            iconSize: 24,
                            style: const TextStyle(color: Color(0xFF222222)),
                            underline: Container(),
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
                        const SizedBox(height: 16),
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
                            const SizedBox(width: 8),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFF00A699),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Center(
                child: Text(
                  'Chapters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Noto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var item = data[index];
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: currentIndex == index 
                            ? const Color(0xFF00A699) 
                            : const Color(0xFF00A699).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: currentIndex == index ? Colors.white : const Color(0xFF00A699),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Noto',
                        fontWeight: currentIndex == index ? FontWeight.w600 : FontWeight.w400,
                        color: currentIndex == index ? const Color(0xFF00A699) : const Color(0xFF222222),
                      ),
                    ),
                    onTap: () => navigateToPage(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: data.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00A699)),
              ),
            )
          : Container(
              margin: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00A699).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          data[currentIndex]['title'] ?? 'ﻻ يوجد شي',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: const Color(0xFF00A699),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(12),
                            ),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: currentIndex > 0 ? previousPage : null,
              icon: const Icon(Icons.arrow_back_ios, size: 18),
              label: const Text("Previous"),
              style: ElevatedButton.styleFrom(
                backgroundColor: currentIndex > 0 ? const Color(0xFF00A699) : Colors.grey[300],
                foregroundColor: currentIndex > 0 ? Colors.white : Colors.grey[600],
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF00A699).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${currentIndex + 1} / ${data.length}',
                style: const TextStyle(
                  color: Color(0xFF00A699),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: currentIndex < data.length - 1 ? nextPage : null,
              icon: const Icon(Icons.arrow_forward_ios, size: 18),
              label: const Text("Next"),
              style: ElevatedButton.styleFrom(
                backgroundColor: currentIndex < data.length - 1 ? const Color(0xFF00A699) : Colors.grey[300],
                foregroundColor: currentIndex < data.length - 1 ? Colors.white : Colors.grey[600],
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
