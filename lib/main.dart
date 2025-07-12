import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';
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
  double fontSize = 20.0;
  String currentFont = 'Noto';
  
  void updateFontSize(double size) {
    fontSize = size;
    notifyListeners();
  }
  
  void updateFont(String font) {
    currentFont = font;
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AirbnbTheme.lightTheme,
          home: const HomePage(),
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
  final double minFontSize = 10.0;
  final double maxFontSize = 30.0;
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
    await Future.delayed(const Duration(milliseconds: 500));
    String jsonString = await rootBundle.loadString('assets/data.json');
    setState(() {
      data = json.decode(jsonString);
      isLoading = false;
    });
    _pageController.forward();
  }
  
  void increaseFontSize() {
    final appState = Provider.of<AppState>(context, listen: false);
    if (appState.fontSize < maxFontSize) {
      appState.updateFontSize(appState.fontSize + 2.0);
    }
  }
  
  void decreaseFontSize() {
    final appState = Provider.of<AppState>(context, listen: false);
    if (appState.fontSize > minFontSize) {
      appState.updateFontSize(appState.fontSize - 2.0);
    }
  }
  
  void changeFont(String font) {
    Provider.of<AppState>(context, listen: false).updateFont(font);
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
    
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AirbnbTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Modern App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: AirbnbTheme.surfaceWhite,
                boxShadow: [
                  BoxShadow(
                    color: AirbnbTheme.shadowLight,
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
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'شرح قطرالندى',
                      style: AirbnbTheme.textTheme.headlineMedium?.copyWith(
                        fontFamily: 'Noto',
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ).animate()
                        .fadeIn(duration: 600.ms)
                        .slideX(begin: 0.1, end: 0),
                  ),
                  const SizedBox(width: 16),
                  AirbnbIconButton(
                    icon: Icons.library_books_rounded,
                    onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                    showBackground: false,
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
        onIncreaseFontSize: increaseFontSize,
        onDecreaseFontSize: decreaseFontSize,
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
        fontOptions: fontOptions,
      ),
      endDrawer: _buildChaptersDrawer(),
      floatingActionButton: _buildFloatingButtons(),
    );
  }
  
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AirbnbTheme.gray100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              size: 50,
              color: AirbnbTheme.gray400,
            ),
          ).animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 1500.ms, color: AirbnbTheme.gray200)
              .animate()
              .fadeIn(duration: 300.ms),
          const SizedBox(height: 24),
          Text(
            'Loading content...',
            style: AirbnbTheme.textTheme.bodyLarge?.copyWith(
              color: AirbnbTheme.gray500,
            ),
          ).animate()
              .fadeIn(delay: 200.ms, duration: 300.ms),
        ],
      ),
    );
  }
  
  Widget _buildContent(AppState appState) {
    return Column(
      children: [
        // Page Indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chapter ${currentIndex + 1} of ${data.length}',
                style: AirbnbTheme.textTheme.bodyMedium?.copyWith(
                  color: AirbnbTheme.gray600,
                ),
              ),
              SmoothPageIndicator(
                controller: _swipeController,
                count: data.length,
                effect: WormEffect(
                  dotWidth: 8,
                  dotHeight: 8,
                  spacing: 4,
                  activeDotColor: AirbnbTheme.primaryRed,
                  dotColor: AirbnbTheme.gray300,
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
                                color: AirbnbTheme.primaryRed.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  AirbnbTheme.radiusRound,
                                ),
                              ),
                              child: Text(
                                data[index]['title'] ?? 'ﻻ يوجد شي',
                                style: AirbnbTheme.arabicTextTheme.displayMedium?.copyWith(
                                  color: AirbnbTheme.primaryRed,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
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
                                      color: AirbnbTheme.gray700,
                                      height: 2,
                                      fontFamily: appState.currentFont,
                                    ),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
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
                                    color: AirbnbTheme.gray400,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Swipe to navigate',
                                    style: AirbnbTheme.textTheme.bodySmall?.copyWith(
                                      color: AirbnbTheme.gray400,
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
    return Drawer(
      backgroundColor: AirbnbTheme.surfaceWhite,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AirbnbTheme.gray100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AirbnbTheme.radiusXLarge),
                  bottomRight: Radius.circular(AirbnbTheme.radiusXLarge),
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.library_books_rounded,
                    size: 48,
                    color: AirbnbTheme.primaryRed,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Chapters',
                    style: AirbnbTheme.textTheme.headlineLarge,
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
                                ? AirbnbTheme.primaryRed.withOpacity(0.1)
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
                                    ? AirbnbTheme.primaryRed
                                    : AirbnbTheme.gray200,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: isSelected
                                        ? AirbnbTheme.primaryWhite
                                        : AirbnbTheme.gray600,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              data[index]['title'] ?? '',
                              style: AirbnbTheme.textTheme.bodyLarge?.copyWith(
                                fontFamily: 'Noto',
                                color: isSelected
                                    ? AirbnbTheme.primaryRed
                                    : AirbnbTheme.primaryDark,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                            ),
                            trailing: isSelected
                                ? const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                    color: AirbnbTheme.primaryRed,
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
  
  Widget _buildFloatingButtons() {
    return AirbnbFloatingMenu(
      mainIcon: Icons.text_fields_rounded,
      items: [
        AirbnbFloatingMenuItem(
          icon: Icons.remove_rounded,
          label: 'Smaller',
          onTap: decreaseFontSize,
        ),
        AirbnbFloatingMenuItem(
          icon: Icons.add_rounded,
          label: 'Larger',
          onTap: increaseFontSize,
        ),
      ],
    );
  }
}
