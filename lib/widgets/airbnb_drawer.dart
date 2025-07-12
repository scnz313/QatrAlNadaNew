import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/airbnb_theme.dart';

class AirbnbDrawer extends StatelessWidget {
  final Function(String) onFontChanged;
  final String currentFont;
  final VoidCallback onAboutPressed;
  final VoidCallback onPrivacyPressed;
  final Function(String)? onThemeChanged;
  final String? currentTheme;
  final List<String> fontOptions;
  final List<String> themeOptions;
  
  const AirbnbDrawer({
    Key? key,
    required this.onFontChanged,
    required this.currentFont,
    required this.onAboutPressed,
    required this.onPrivacyPressed,
    this.onThemeChanged,
    this.currentTheme,
    required this.fontOptions,
    this.themeOptions = const ['Light', 'Dark', 'Sepia', 'Auto'],
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            // Header
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
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                      boxShadow: AirbnbTheme.mediumShadow,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.menu_book_rounded,
                        size: 40,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ).animate()
                      .scale(delay: 200.ms, duration: 400.ms)
                      .fadeIn(),
                  const SizedBox(height: 16),
                  Text(
                    'شرح قطرالندى',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontFamily: 'Noto',
                      color: theme.colorScheme.onSurface,
                    ),
                    textDirection: TextDirection.rtl,
                  ).animate()
                      .fadeIn(delay: 300.ms)
                      .slideY(begin: 0.1, end: 0),
                ],
              ),
            ),
            
            // Menu Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  _DrawerItem(
                    icon: Icons.home_rounded,
                    title: 'Home',
                    onTap: () => Navigator.pop(context),
                  ).animate()
                      .fadeIn(delay: 400.ms)
                      .slideX(begin: -0.1, end: 0),
                  
                  _DrawerItem(
                    icon: Icons.info_rounded,
                    title: 'About Us',
                    onTap: () {
                      Navigator.pop(context);
                      onAboutPressed();
                    },
                  ).animate()
                      .fadeIn(delay: 500.ms)
                      .slideX(begin: -0.1, end: 0),
                  
                  _DrawerItem(
                    icon: Icons.security_rounded,
                    title: 'Privacy Policy',
                    onTap: () {
                      Navigator.pop(context);
                      onPrivacyPressed();
                    },
                  ).animate()
                      .fadeIn(delay: 600.ms)
                      .slideX(begin: -0.1, end: 0),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Divider(color: theme.colorScheme.onSurface.withOpacity(0.2)),
                  ),
                  
                  // Font Selector
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Font Style',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(AirbnbTheme.radiusSmall),
                          ),
                          child: DropdownButton<String>(
                            value: currentFont,
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: Icon(
                              Icons.arrow_drop_down_rounded,
                              color: theme.colorScheme.onSurface,
                            ),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                            onChanged: (String? newFont) {
                              if (newFont != null) {
                                onFontChanged(newFont);
                              }
                            },
                            items: fontOptions.map<DropdownMenuItem<String>>((String font) {
                              return DropdownMenuItem<String>(
                                value: font,
                                child: Text(
                                  font,
                                  style: TextStyle(
                                    fontFamily: font,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ).animate()
                      .fadeIn(delay: 700.ms)
                      .slideX(begin: -0.1, end: 0),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Divider(color: theme.colorScheme.onSurface.withOpacity(0.2)),
                  ),
                  
                  // Theme Selector
                  if (onThemeChanged != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Theme',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(AirbnbTheme.radiusSmall),
                            ),
                            child: DropdownButton<String>(
                              value: currentTheme ?? 'Light',
                              isExpanded: true,
                              underline: const SizedBox(),
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                color: theme.colorScheme.onSurface,
                              ),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                              onChanged: (String? newTheme) {
                                if (newTheme != null) {
                                  onThemeChanged!(newTheme);
                                }
                              },
                              items: themeOptions.map<DropdownMenuItem<String>>((String themeOption) {
                                return DropdownMenuItem<String>(
                                  value: themeOption,
                                  child: Row(
                                    children: [
                                      Icon(
                                        themeOption == 'Light' ? Icons.light_mode_rounded :
                                        themeOption == 'Dark' ? Icons.dark_mode_rounded :
                                        themeOption == 'Sepia' ? Icons.filter_vintage_rounded :
                                        Icons.brightness_auto_rounded,
                                        size: 18,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(themeOption),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ).animate()
                        .fadeIn(delay: 750.ms)
                        .slideX(begin: -0.1, end: 0),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Divider(color: theme.colorScheme.onSurface.withOpacity(0.2)),
                  ),
                ],
              ),
            ),
            
            // Footer
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: theme.colorScheme.onSurface.withOpacity(0.2)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_rounded,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Made with love in Kashmir',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ).animate()
                .fadeIn(delay: 900.ms),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  
  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AirbnbTheme.radiusSmall),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(AirbnbTheme.radiusSmall),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 20,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

