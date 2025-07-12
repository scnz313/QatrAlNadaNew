import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/airbnb_theme.dart';

class AirbnbDrawer extends StatelessWidget {
  final Function(String) onFontChanged;
  final String currentFont;
  final VoidCallback onIncreaseFontSize;
  final VoidCallback onDecreaseFontSize;
  final VoidCallback onAboutPressed;
  final VoidCallback onPrivacyPressed;
  final List<String> fontOptions;
  
  const AirbnbDrawer({
    Key? key,
    required this.onFontChanged,
    required this.currentFont,
    required this.onIncreaseFontSize,
    required this.onDecreaseFontSize,
    required this.onAboutPressed,
    required this.onPrivacyPressed,
    required this.fontOptions,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AirbnbTheme.surfaceWhite,
      child: SafeArea(
        child: Column(
          children: [
            // Header
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
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AirbnbTheme.primaryRed,
                      shape: BoxShape.circle,
                      boxShadow: AirbnbTheme.mediumShadow,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.menu_book_rounded,
                        size: 40,
                        color: AirbnbTheme.primaryWhite,
                      ),
                    ),
                  ).animate()
                      .scale(delay: 200.ms, duration: 400.ms)
                      .fadeIn(),
                  const SizedBox(height: 16),
                  Text(
                    'شرح قطرالندى',
                    style: AirbnbTheme.textTheme.headlineLarge?.copyWith(
                      fontFamily: 'Noto',
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
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Divider(color: AirbnbTheme.gray200),
                  ),
                  
                  // Font Selector
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Font Style',
                          style: AirbnbTheme.textTheme.labelLarge?.copyWith(
                            color: AirbnbTheme.gray600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: AirbnbTheme.gray300),
                            borderRadius: BorderRadius.circular(AirbnbTheme.radiusSmall),
                          ),
                          child: DropdownButton<String>(
                            value: currentFont,
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: AirbnbTheme.primaryDark,
                            ),
                            style: AirbnbTheme.textTheme.bodyLarge,
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
                                    color: AirbnbTheme.primaryDark,
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
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Divider(color: AirbnbTheme.gray200),
                  ),
                  
                  // Font Size Controls
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Text Size',
                          style: AirbnbTheme.textTheme.labelLarge?.copyWith(
                            color: AirbnbTheme.gray600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _FontSizeButton(
                                icon: Icons.remove_rounded,
                                label: 'Decrease',
                                onTap: onDecreaseFontSize,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _FontSizeButton(
                                icon: Icons.add_rounded,
                                label: 'Increase',
                                onTap: onIncreaseFontSize,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate()
                      .fadeIn(delay: 800.ms)
                      .slideX(begin: -0.1, end: 0),
                ],
              ),
            ),
            
            // Footer
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AirbnbTheme.gray200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    size: 16,
                    color: AirbnbTheme.primaryRed,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Made with love',
                    style: AirbnbTheme.textTheme.bodySmall?.copyWith(
                      color: AirbnbTheme.gray600,
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
                color: AirbnbTheme.gray100,
                borderRadius: BorderRadius.circular(AirbnbTheme.radiusSmall),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 20,
                  color: AirbnbTheme.primaryDark,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: AirbnbTheme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FontSizeButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  
  const _FontSizeButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  
  @override
  State<_FontSizeButton> createState() => _FontSizeButtonState();
}

class _FontSizeButtonState extends State<_FontSizeButton> {
  bool _isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: _isPressed ? AirbnbTheme.gray100 : AirbnbTheme.surfaceWhite,
          border: Border.all(color: AirbnbTheme.gray300),
          borderRadius: BorderRadius.circular(AirbnbTheme.radiusSmall),
          boxShadow: _isPressed ? null : AirbnbTheme.lightShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: 20,
              color: AirbnbTheme.primaryDark,
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: AirbnbTheme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}