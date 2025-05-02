import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'about_page.dart'; // Import AboutPage
import 'privacy_policy_page.dart'; // Import PrivacyPolicyPage
import 'about_app_page.dart'; // Import AboutAppPage
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'core/theme/theme_provider.dart'; // Import Theme Provider
import 'package:flutter_animate/flutter_animate.dart'; // Import Animate
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import FontAwesome for icons

void main() {
  runApp(
    // Wrap the app with ProviderScope
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Change to ConsumerWidget to read providers
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the theme provider's STATE (AppTheme enum)
    final currentThemeEnum = ref.watch(themeProvider);

    // Determine the theme data based on the current state
    final ThemeData currentThemeData;
    switch (currentThemeEnum) {
      case AppTheme.light:
        currentThemeData = lightTheme;
        break;
      case AppTheme.dark:
        currentThemeData = darkTheme;
        break;
      case AppTheme.sepia:
      default:
        currentThemeData = sepiaTheme;
        break;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Use the correct theme data based on the watched state
      theme: currentThemeData,
      // We no longer need the themeNotifier here directly for the theme
      // final themeNotifier = ref.watch(themeProvider.notifier);

      // theme: themeNotifier.currentThemeData, // This was the incorrect way
      home: const HomePage(),
    );
  }
}

// Change to ConsumerStatefulWidget
class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<dynamic> data = [];
  int _currentIndex = 0;
  int _selectedIndex = 0; // 0: Home, 1: Search, 2: Settings
  double fontSize = 16.0;
  String currentFont = 'Noto'; // Default font
  bool _isLoading = true;
  bool _showFab = true; // State variable to control FAB visibility

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    if (mounted) {
      setState(() {
        data = json.decode(jsonString);
      });
    }
  }

  void increaseFontSize() {
    setState(() {
      if (fontSize < 30.0) fontSize += 2.0;
    });
  }

  void decreaseFontSize() {
    setState(() {
      if (fontSize > 10.0) fontSize -= 2.0;
    });
  }

  void changeFont(String font) {
    setState(() {
      currentFont = font;
    });
  }

  // This now specifically navigates the content view
  void navigateToContentPage(int index) {
    // Close modal bottom sheet if open before navigating
    if (Navigator.canPop(context)) {
      Navigator.pop(context); 
    }
    if (index >= 0 && index < data.length) {
      setState(() {
        _currentIndex = index;
        _selectedIndex = 0; // Switch back to home view when a chapter is selected
      });
    }
    // Removed pop logic as it's handled above
    // if (Navigator.canPop(context)) { ... }
  }

  // Navigate between BottomNavBar items
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // If using PageView:
    // _pageController.animateToPage(index, duration: 300.ms, curve: Curves.easeInOut);
  }

  // Previous/Next functions specific to the ContentView
  void nextContentPage() {
    if (_currentIndex < data.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void previousContentPage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      // Optional: Show an error message if the URL can't be launched
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $urlString')),
        );
      }
    }
  }

  // --- Bottom Sheet for Chapters is removed, logic moves to ChaptersPage ---
  // void _showChapterBottomSheet() { ... } // Removed

  // --- Function to show Chapters Bottom Sheet ---
  void _showChapterBottomSheet() {
    final theme = Theme.of(context);
    if (data.isEmpty) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow sheet to take more height
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        // Pass data and navigation callback to ChaptersPage
        return ChaptersPage(
          data: data,
          navigateToPage: navigateToContentPage, // Use the correct navigation function
          isModal: true, // Indicate it's being used as a modal
        );
      },
    );
  }

  // --- Callback for child widgets to update FAB visibility ---
  void _updateFabVisibility(bool visible) {
    if (_showFab != visible) {
      setState(() {
        _showFab = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // List of widgets for BottomNavigationBar - updated
    final List<Widget> _widgetOptions = <Widget>[
      // Home View
      ContentView(
        key: const ValueKey('contentView'), // Add key for state preservation if needed
        data: data,
        currentIndex: _currentIndex,
        fontSize: fontSize,
        currentFont: currentFont,
        onScroll: _updateFabVisibility, // Pass callback
      ),
      // Search View
      SearchPage(
        key: const ValueKey('searchPage'), // Add key
        data: data,
        navigateToContentPage: navigateToContentPage,
        onScroll: _updateFabVisibility, // Pass callback
      ),
      // Settings View - New
      SettingsPage(
        fontSize: fontSize,
        currentFont: currentFont,
        onIncreaseFontSize: increaseFontSize,
        onDecreaseFontSize: decreaseFontSize,
        onChangeFont: changeFont,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        // Remove leading drawer button
        // leading: Builder(...),
        title: const Text('Qatar Al Nada'),
        centerTitle: true,
        actions: [
          // --- Conditionally show Font Size Icons only on content page --- 
          if (_selectedIndex == 0) ...[
            IconButton(
              icon: const Icon(Icons.text_decrease),
              onPressed: decreaseFontSize,
              tooltip: 'Decrease Font Size',
            ),
            IconButton(
              icon: const Icon(Icons.text_increase),
              onPressed: increaseFontSize,
              tooltip: 'Increase Font Size',
            ),
          ],
          // --- Actions list ends here ---
        ],
      ),
      // Remove the drawer property
      // drawer: _buildDrawer(context, ref),
      body: data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : IndexedStack(
              index: _selectedIndex,
              children: _widgetOptions,
            ),
      // --- Add Floating Action Button for Chapters ---
      floatingActionButton: (_selectedIndex < 2)
          ? AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: _showFab
                  ? AnimatedOpacity(
                      key: const ValueKey('fab'),
                      duration: const Duration(milliseconds: 300),
                      opacity: (_selectedIndex == 0 && 
                        _widgetOptions[0] is ContentView && 
                        (_widgetOptions[0] as ContentView).key == const ValueKey('contentView') && 
                        context.findAncestorStateOfType<_ContentViewState>()?.atEnd == true) ? 0.3 : 1.0,
                      child: FloatingActionButton(
                        onPressed: _showChapterBottomSheet,
                        tooltip: 'Select Chapter',
                        child: const Icon(Icons.list_alt),
                      ),
                    )
                  : const SizedBox.shrink(key: ValueKey('fab_hidden')),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // --- Updated Bottom Navigation Bar ---
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          // Changed 'Chapters' to 'Settings'
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ).animate().fade(duration: 300.ms),
    );
  }
}

// --- Extracted Content View Widget (Now StatefulWidget) ---
class ContentView extends StatefulWidget {
  final List<dynamic> data;
  final int currentIndex;
  final double fontSize;
  final String currentFont;
  final ValueChanged<bool> onScroll; // Callback for scroll direction

  const ContentView({
    Key? key,
    required this.data,
    required this.currentIndex,
    required this.fontSize,
    required this.currentFont,
    required this.onScroll,
  }) : super(key: key);

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  final ScrollController _scrollController = ScrollController();
  double _lastScrollOffset = 0.0;
  bool _atEnd = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Check if we're at the end of the content
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50) {
      if (!_atEnd) {
        setState(() {
          _atEnd = true;
        });
      }
    } else if (_atEnd) {
      setState(() {
        _atEnd = false;
      });
    }

    // Handle scroll direction for FAB visibility
    if (_scrollController.position.pixels > _lastScrollOffset) {
      widget.onScroll(false); // Scrolling down, hide FAB
    } else if (_scrollController.position.pixels < _lastScrollOffset) {
      widget.onScroll(true); // Scrolling up, show FAB
    }
    _lastScrollOffset = _scrollController.position.pixels;
  }

  // Getter for the atEnd property to be used by parent widgets
  bool get atEnd => _atEnd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      // Add horizontal swipe detection
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null) {
          // Right to left swipe (negative velocity)
          if (details.primaryVelocity! < 0 && widget.currentIndex < widget.data.length - 1) {
            // Navigate to next chapter
            if (context.findAncestorStateOfType<_HomePageState>() != null) {
              context.findAncestorStateOfType<_HomePageState>()!.nextContentPage();
            }
          } 
          // Left to right swipe (positive velocity)
          else if (details.primaryVelocity! > 0 && widget.currentIndex > 0) {
            // Navigate to previous chapter
            if (context.findAncestorStateOfType<_HomePageState>() != null) {
              context.findAncestorStateOfType<_HomePageState>()!.previousContentPage();
            }
          }
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title text - remove gap by eliminating padding
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            color: theme.scaffoldBackgroundColor,
            child: Text(
              widget.data[widget.currentIndex]['title'] ?? 'ﻻ يوجد عنوان',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ),
          // Content text
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  widget.data[widget.currentIndex]['content'] ?? 'لا يوجد محتوى',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: widget.fontSize,
                    fontFamily: widget.currentFont,
                    height: 1.8,
                  ),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Search Page ---
class SearchPage extends StatefulWidget {
  final List<dynamic> data;
  final Function(int) navigateToContentPage;
  final ValueChanged<bool> onScroll; // Callback for scroll direction

  const SearchPage({
    Key? key,
    required this.data,
    required this.navigateToContentPage,
    required this.onScroll,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  final ScrollController _scrollController = ScrollController();
  double _lastScrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    // Initialize with all data or empty list depending on preference
    // _searchResults = widget.data;
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      setState(() {
        _searchResults = []; 
      });
      return;
    }

    final results = widget.data.where((item) {
      final title = (item['title']?.toString() ?? '').toLowerCase();
      final content = (item['content']?.toString() ?? '').toLowerCase();
      return title.contains(query) || content.contains(query);
    }).toList();

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Add SafeArea/Padding to account for FAB
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          final offset = notification.metrics.pixels;
          if (offset > _lastScrollOffset) {
            widget.onScroll(false);
          } else if (offset < _lastScrollOffset) {
            widget.onScroll(true);
          }
          _lastScrollOffset = offset;
        }
        return true;
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 80.0), // Keep bottom padding
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by title or content...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          // _performSearch(); 
                        },
                      )
                    : null,
                  ),
                  textDirection: TextDirection.rtl, 
                ).animate().fade(duration: 300.ms),
              ),
              Expanded(
                child: _searchResults.isEmpty && _searchController.text.isNotEmpty
                    ? Center(child: Text('No results found for "${_searchController.text}"'))
                    : _searchResults.isEmpty && _searchController.text.isEmpty
                    ? const Center(child: Text('Enter a search term above.'))
                    : ListView.builder(
                        controller: _scrollController, // Attach controller
                        // Add some padding to the list itself
                        padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final item = _searchResults[index];
                          final originalIndex = widget.data.indexOf(item);
                          final title = item['title']?.toString() ?? 'Untitled';
                          // Optional: Highlight search term in results (more complex)

                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            // Add subtle animation on the card itself
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: theme.colorScheme.secondaryContainer,
                                child: Text('${originalIndex + 1}', style: TextStyle(color: theme.colorScheme.onSecondaryContainer)),
                              ),
                              title: Text(
                                title,
                                textDirection: TextDirection.rtl,
                                style: theme.textTheme.titleMedium,
                              ),
                              // subtitle: Text( 
                              //   (item['content']?.toString() ?? '').substring(0, 50) + '...', 
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              // ),
                              onTap: () {
                                widget.navigateToContentPage(originalIndex);
                                // Optionally clear search or keep results visible
                                // _searchController.clear(); 
                              },
                            ).animate().fade(delay: (index * 50).ms, duration: 300.ms).slideX(begin: 0.1),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Chapters Page (Adapted for Modal Bottom Sheet) ---
class ChaptersPage extends StatelessWidget {
  final List<dynamic> data;
  final Function(int) navigateToPage;
  final bool isModal; // New flag

  const ChaptersPage({
    Key? key,
    required this.data,
    required this.navigateToPage,
    this.isModal = false, // Default to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chapters = data;

    Widget content = chapters.isEmpty
      ? const Center(child: Text('No chapters loaded.'))
      : ListView.builder(
          // If modal, use the passed scroll controller
          controller: isModal ? ScrollController() : null,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            final chapter = chapters[index];
            final title = chapter['title']?.toString() ?? 'Chapter ${index + 1}';

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.secondaryContainer,
                  child: Text('${index + 1}', style: TextStyle(color: theme.colorScheme.onSecondaryContainer)),
                ),
                title: Text(
                  title,
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.titleMedium,
                ),
                onTap: () {
                  // No need to pop if not modal, but navigateToPage handles pop now
                  navigateToPage(index);
                },
              ).animate().fade(delay: (index * 50).ms, duration: 300.ms).slideX(begin: 0.2),
            );
          },
        );

    if (isModal) {
      // Wrap with structure suitable for showModalBottomSheet
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6, // Start at 60% height
        maxChildSize: 0.9,   // Allow scrolling up to 90%
        minChildSize: 0.3,   // Minimum height
        builder: (context, scrollController) {
          // Need to rebuild the ListView with the scrollController from builder
          Widget modalListView = chapters.isEmpty
            ? const Center(child: Text('No chapters loaded.'))
            : ListView.builder(
                controller: scrollController, // Use the provided controller
                padding: const EdgeInsets.only(bottom: 20), // Padding at the bottom inside modal
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  final chapter = chapters[index];
                  final title = chapter['title']?.toString() ?? 'Chapter ${index + 1}';
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    child: ListTile(
                       leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.secondaryContainer,
                        child: Text('${index + 1}', style: TextStyle(color: theme.colorScheme.onSecondaryContainer)),
                       ),
                       title: Text(
                        title,
                        textDirection: TextDirection.rtl,
                        style: theme.textTheme.titleMedium,
                       ),
                       onTap: () => navigateToPage(index), // navigateToPage now handles pop
                     ).animate().fade(delay: (index * 50).ms, duration: 300.ms).slideX(begin: 0.2),
                   );
                 },
              );

          return Column(
            children: [
              // Handle for dragging
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Select Chapter',
                  style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary)
                ),
              ),
              Expanded(child: modalListView),
            ],
          );
        },
      );
    } else {
      // Return content directly if not used as modal (e.g., if it were a main tab)
      return content;
    }
  }
}

// --- New Settings Page ---
class SettingsPage extends ConsumerWidget { // Use ConsumerWidget to access Riverpod
  final double fontSize;
  final String currentFont;
  final VoidCallback onIncreaseFontSize;
  final VoidCallback onDecreaseFontSize;
  final Function(String) onChangeFont;

  const SettingsPage({
    Key? key,
    required this.fontSize,
    required this.currentFont,
    required this.onIncreaseFontSize,
    required this.onDecreaseFontSize,
    required this.onChangeFont,
  }) : super(key: key);

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
       // Handle error, maybe show a snackbar
       print('Could not launch $urlString'); // Placeholder
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentThemeEnum = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final List<String> fontOptions = ['Noto', 'Noor', 'Amiri']; // Define font options here

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Theme Settings
        Text(
          'Theme Settings',
          style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary)
        ),
        const SizedBox(height: 8),
        RadioListTile<AppTheme>(
          title: const Text('Light Theme'),
          value: AppTheme.light,
          groupValue: currentThemeEnum,
          secondary: const Icon(Icons.wb_sunny_outlined),
          onChanged: (AppTheme? value) {
            if (value != null) themeNotifier.setTheme(value);
          },
        ),
        RadioListTile<AppTheme>(
          title: const Text('Dark Theme'),
          value: AppTheme.dark,
          groupValue: currentThemeEnum,
          secondary: const Icon(Icons.nightlight_outlined),
          onChanged: (AppTheme? value) {
            if (value != null) themeNotifier.setTheme(value);
          },
        ),
        RadioListTile<AppTheme>(
          title: const Text('Sepia Theme'),
          value: AppTheme.sepia,
          groupValue: currentThemeEnum,
          secondary: const Icon(Icons.book_outlined),
          onChanged: (AppTheme? value) {
            if (value != null) themeNotifier.setTheme(value);
          },
        ),
        const Divider(height: 32),

        // Font Settings
        Text(
          'Font Settings',
          style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary)
        ),
        const SizedBox(height: 8),
        // Font Type Selection
        ...fontOptions.map((font) => RadioListTile<String>(
              title: Text(font, style: TextStyle(fontFamily: font)),
              value: font,
              groupValue: currentFont,
              onChanged: (String? value) {
                if (value != null) onChangeFont(value);
              },
            )).toList(),
        // Font Size (Maybe add a slider here later? For now, handled by AppBar)
        // const SizedBox(height: 16),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text('Font Size: ${fontSize.toStringAsFixed(0)}'),
        //     Row(children: [IconButton(onPressed: onDecreaseFontSize, icon: Icon(Icons.remove)), IconButton(onPressed: onIncreaseFontSize, icon: Icon(Icons.add))]),
        //   ],
        // ),
        const Divider(height: 32),

        // About & Policy
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About Us'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.book_outlined),
          title: const Text('About the App'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutAppPage()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: const Text('Privacy Policy'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicyPage())),
        ),
        const Divider(height: 32),

        // Version Info
        Center(
          child: Text(
            'Version 2.0.0', // Example version
            style: theme.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

// Helper extension for capitalizing strings (if not already present)
extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) {
      return "";
    }
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
