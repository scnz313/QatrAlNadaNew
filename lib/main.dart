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
  
  void updateFont(String font) {
    currentFont = font;
    notifyListeners();
  }
  
  void updateTheme(String theme) {
    currentTheme = theme;
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
  int currentIndex = 0;
  final List<String> fontOptions = ['Noto', 'Noor', 'Amiri'];
  
  late AnimationController _pageController;
  late AnimationController _fabController;
  final PageController _swipeController = PageController(viewportFraction: 0.9);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  bool isLoading = true;
  
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
    super.dispose();
  }
  
  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    setState(() {
      data = json.decode(jsonString);
      isLoading = false;
    });
    _pageController.forward();
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
                                      fontSize: 18,
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
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final isSelected = index == currentIndex;
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
                            onTap: () => navigateToPage(index),
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
                                  '${index + 1}',
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
                            title: Text(
                              data[index]['title'] ?? '',
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
                            ),
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
  

}
