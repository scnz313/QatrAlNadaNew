import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'theme/airbnb_theme.dart';
import 'widgets/airbnb_widgets.dart';
import 'widgets/airbnb_drawer.dart';
import 'about_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MyApp(),
    ),
  );
}

class AppState extends ChangeNotifier {
  String currentFont = 'Noto';
  String currentTheme = 'Light';
  double fontSize = 18.0; // Default font size
  
  // Font size constraints
  static const double minFontSize = 12.0;
  static const double maxFontSize = 32.0;
  static const double fontSizeStep = 2.0;
  
  void updateFont(String font) {
    currentFont = font;
    notifyListeners();
  }
  
  void updateTheme(String theme) {
    currentTheme = theme;
    notifyListeners();
  }
  
  void increaseFontSize() {
    if (fontSize < maxFontSize) {
      fontSize += fontSizeStep;
      notifyListeners();
    }
  }
  
  void decreaseFontSize() {
    if (fontSize > minFontSize) {
      fontSize -= fontSizeStep;
      notifyListeners();
    }
  }
  
  void resetFontSize() {
    fontSize = 18.0;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer<AppState>(
          builder: (context, appState, child) {
            ThemeData theme;
            switch (appState.currentTheme) {
              case 'Dark':
                theme = AirbnbTheme.darkTheme;
                break;
              case 'Sepia':
                theme = AirbnbTheme.sepiaTheme;
                break;
              case 'Auto':
                // For auto, we'll use light theme for now
                // You can implement system theme detection here
                theme = AirbnbTheme.lightTheme;
                break;
              default:
                theme = AirbnbTheme.lightTheme;
            }
            
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              home: const HomePage(),
            );
          },
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<dynamic> data = [];
  List<dynamic> filteredData = [];
  int currentIndex = 0;
  final List<String> fontOptions = ['Noto', 'Noor', 'Amiri'];
  
  late AnimationController _pageController;
  late AnimationController _fabController;
  final PageController _swipeController = PageController(viewportFraction: 0.9);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  
  bool isLoading = true;
  String searchQuery = '';
  
  @override
  void initState() {
    super.initState();
    _pageController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    loadJsonData();
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    _fabController.dispose();
    _swipeController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  
  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    setState(() {
      data = json.decode(jsonString);
      filteredData = data; // Initialize filtered data
      isLoading = false;
    });
    _pageController.forward();
  }
  
  void _filterChapters(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredData = data;
      } else {
        filteredData = data.where((chapter) {
          final title = chapter['title']?.toString().toLowerCase() ?? '';
          final content = chapter['content']?.toString().toLowerCase() ?? '';
          final searchLower = query.toLowerCase();
          return title.contains(searchLower) || content.contains(searchLower);
        }).toList();
      }
    });
  }
  

  
  void changeFont(String font) {
    Provider.of<AppState>(context, listen: false).updateFont(font);
  }
  
  void changeTheme(String theme) {
    Provider.of<AppState>(context, listen: false).updateTheme(theme);
  }
  
  void navigateToPage(int index) {
    setState(() {
      currentIndex = index;
    });
    _swipeController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final theme = Theme.of(context);
    
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Modern App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.onSurface.withOpacity(0.1),
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Row(
                children: [
                  AirbnbIconButton(
                    icon: Icons.menu_rounded,
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    showBackground: false,
                    color: theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'شرح قطرالندى',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                    ).animate()
                        .fadeIn(duration: 600.ms)
                        .slideX(begin: 0.1, end: 0),
                  ),
                  const SizedBox(width: 16),
                  AirbnbIconButton(
                    icon: Icons.library_books_rounded,
                    onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                    showBackground: false,
                    color: theme.colorScheme.onSurface,
                  ),
                ],
              ),
            ).animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: -0.1, end: 0),
            
            // Main Content
            Expanded(
              child: isLoading
                  ? _buildLoadingState()
                  : _buildContent(appState),
            ),
          ],
        ),
      ),
      drawer: AirbnbDrawer(
        onFontChanged: changeFont,
        currentFont: appState.currentFont,
        onAboutPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const AboutPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: animation.drive(
                    Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
                      CurveTween(curve: Curves.easeInOutCubic),
                    ),
                  ),
                  child: child,
                );
              },
            ),
          );
        },
        onPrivacyPressed: () async {
          final Uri url = Uri.parse(
              'https://quranichub.blogspot.com/p/qatar-al-nada-apps-policy.html');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        },
        onThemeChanged: (theme) {
          Provider.of<AppState>(context, listen: false).updateTheme(theme);
        },
        currentTheme: appState.currentTheme,
        fontOptions: fontOptions,
      ),
      endDrawer: _buildChaptersDrawer(),
      floatingActionButton: _buildFontFloatingMenu(),
    );
  }
  
  Widget _buildLoadingState() {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.menu_book_rounded,
              size: 50,
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ).animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 1500.ms, color: theme.colorScheme.onSurface.withOpacity(0.2))
              .animate()
              .fadeIn(duration: 300.ms),
          const SizedBox(height: 24),
          Text(
            'Loading content...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ).animate()
              .fadeIn(delay: 200.ms, duration: 300.ms),
        ],
      ),
    );
  }
  
  Widget _buildContent(AppState appState) {
    final theme = Theme.of(context);
    return Column(
      children: [
        // Page Indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Chapter ${currentIndex + 1} of ${data.length}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: SmoothPageIndicator(
                    controller: _swipeController,
                    count: data.length,
                    effect: WormEffect(
                      dotWidth: 5,
                      dotHeight: 5,
                      spacing: 2,
                      activeDotColor: theme.colorScheme.primary,
                      dotColor: theme.colorScheme.onSurface.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Content Cards
        Expanded(
          child: PageView.builder(
            controller: _swipeController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: data.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AirbnbCard(
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            // Title
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: theme.brightness == Brightness.dark
                                    ? theme.colorScheme.primary.withOpacity(0.2)
                                    : theme.colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  AirbnbTheme.radiusRound,
                                ),
                              ),
                              child: Text(
                                data[index]['title'] ?? 'ﻻ يوجد شي',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: theme.brightness == Brightness.dark
                                      ? theme.colorScheme.onPrimary
                                      : theme.colorScheme.primary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Noto',
                                ),
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ).animate()
                                .fadeIn(delay: 300.ms, duration: 400.ms)
                                .slideY(begin: 0.1, end: 0),
                            
                            const SizedBox(height: 24),
                            
                            // Content
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    data[index]['content'] ?? 'لا يوجد شئ',
                                    style: TextStyle(
                                      fontSize: appState.fontSize,
                                      color: theme.colorScheme.onSurface,
                                      height: 2,
                                      fontFamily: appState.currentFont,
                                    ),
                                    textAlign: TextAlign.justify,
                                    textDirection: TextDirection.rtl,
                                    softWrap: true,
                                  ).animate()
                                      .fadeIn(delay: 400.ms, duration: 500.ms),
                                ),
                              ),
                            ),
                            
                            // Navigation Hint
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.swipe_rounded,
                                    size: 20,
                                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Swipe to navigate',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ).animate()
                                  .fadeIn(delay: 600.ms, duration: 400.ms),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildChaptersDrawer() {
    final theme = Theme.of(context);
    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AirbnbTheme.radiusXLarge),
                  bottomRight: Radius.circular(AirbnbTheme.radiusXLarge),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.library_books_rounded,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Chapters',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(AirbnbTheme.radiusSmall),
                      border: Border.all(
                        color: theme.colorScheme.onSurface.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterChapters,
                      textDirection: TextDirection.rtl,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search chapters...',
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                          size: 20,
                        ),
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear_rounded,
                                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                                  size: 20,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  _filterChapters('');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ).animate()
                      .fadeIn(delay: 400.ms, duration: 300.ms)
                      .slideY(begin: -0.1, end: 0),
                ],
              ),
            ),
            Expanded(
              child: filteredData.isEmpty && searchQuery.isNotEmpty
                  ? _buildNoResultsState(theme)
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        final chapter = filteredData[index];
                        final originalIndex = data.indexOf(chapter);
                        final isSelected = originalIndex == currentIndex;
                        
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? theme.colorScheme.primary.withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    AirbnbTheme.radiusSmall,
                                  ),
                                ),
                                child: ListTile(
                                  onTap: () => navigateToPage(originalIndex),
                                  leading: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurface.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${originalIndex + 1}',
                                        style: TextStyle(
                                          color: isSelected
                                              ? theme.colorScheme.onPrimary
                                              : theme.colorScheme.onSurface.withOpacity(0.7),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: _buildHighlightedText(
                                    chapter['title'] ?? '',
                                    searchQuery,
                                    theme,
                                    isSelected,
                                  ),
                                  subtitle: searchQuery.isNotEmpty && 
                                           chapter['content']?.toString().toLowerCase().contains(searchQuery.toLowerCase()) == true
                                      ? _buildContentPreview(chapter['content'] ?? '', searchQuery, theme)
                                      : null,
                                  trailing: isSelected
                                      ? Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                          color: theme.colorScheme.primary,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFontFloatingMenu() {
    final appState = Provider.of<AppState>(context);
    final theme = Theme.of(context);
    
    return AirbnbFloatingMenu(
      mainIcon: Icons.format_size_rounded,
      items: [
        AirbnbFloatingMenuItem(
          icon: Icons.add_rounded,
          label: 'Increase Size',
          onTap: () => appState.increaseFontSize(),
        ),
        // AirbnbFloatingMenuItem(
        //   icon: Icons.refresh_rounded,
        //   label: 'Reset Size',
        //   onTap: () => appState.resetFontSize(),
        // ),
        AirbnbFloatingMenuItem(
          icon: Icons.remove_rounded,
          label: 'Decrease Size',
          onTap: () => appState.decreaseFontSize(),
        ),
      ],
    ).animate()
        .fadeIn(delay: 800.ms, duration: 600.ms)
        .slideY(begin: 0.3, end: 0, curve: Curves.easeOutBack);
  }
  
  Widget _buildNoResultsState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No chapters found',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ).animate()
          .fadeIn(duration: 400.ms)
          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),
    );
  }
  
  Widget _buildHighlightedText(String text, String query, ThemeData theme, bool isSelected) {
    if (query.isEmpty) {
      return Text(
        text,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontFamily: 'Noto',
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
          fontWeight: isSelected
              ? FontWeight.w600
              : FontWeight.w400,
        ),
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
      );
    }
    
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];
    
    int start = 0;
    int index = lowerText.indexOf(lowerQuery);
    
    while (index != -1) {
      // Add text before match
      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontFamily: 'Noto',
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
            fontWeight: isSelected
                ? FontWeight.w600
                : FontWeight.w400,
          ),
        ));
      }
      
      // Add highlighted match
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: theme.textTheme.bodyLarge?.copyWith(
          fontFamily: 'Noto',
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
        ),
      ));
      
      start = index + query.length;
      index = lowerText.indexOf(lowerQuery, start);
    }
    
    // Add remaining text
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: theme.textTheme.bodyLarge?.copyWith(
          fontFamily: 'Noto',
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
          fontWeight: isSelected
              ? FontWeight.w600
              : FontWeight.w400,
        ),
      ));
    }
    
    return RichText(
      text: TextSpan(children: spans),
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
    );
  }
  
  Widget _buildContentPreview(String content, String query, ThemeData theme) {
    final lowerContent = content.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final index = lowerContent.indexOf(lowerQuery);
    
    if (index == -1) return const SizedBox.shrink();
    
    // Get context around the match (50 characters before and after)
    final start = (index - 50).clamp(0, content.length);
    final end = (index + query.length + 50).clamp(0, content.length);
    final preview = content.substring(start, end);
    final adjustedQuery = query;
    
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Text(
        '...$preview...',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.6),
          fontFamily: 'Noto',
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
      ),
    );
  }

}
