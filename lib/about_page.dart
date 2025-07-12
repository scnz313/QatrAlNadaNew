import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'theme/airbnb_theme.dart';
import 'widgets/airbnb_widgets.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
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
                    icon: Icons.arrow_back_rounded,
                    onPressed: () => Navigator.pop(context),
                    showBackground: false,
                    color: theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'About Me',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
            ).animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: -0.1, end: 0),
            
            // Content
            Expanded(
              child: PageView(
                controller: PageController(viewportFraction: 0.95),
                children: [
                  // Main Developer
                  Column(
                    children: [
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: AirbnbCard(
                          padding: const EdgeInsets.all(32),
                          borderRadius: 20,
                          showShadow: false,
                          borderWidth: 0.5,
                          child: Column(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      theme.colorScheme.primary,
                                      theme.colorScheme.primary.withOpacity(0.7),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: AirbnbTheme.mediumShadow,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.person_rounded,
                                    size: 60,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ).animate()
                                  .scale(delay: 300.ms, duration: 600.ms, curve: Curves.elasticOut)
                                  .fadeIn(),
                              const SizedBox(height: 24),
                              Text(
                                "اسلام عليكم!",
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 28,
                                  fontFamily: 'Noto',
                                ),
                                textDirection: TextDirection.rtl,
                              ).animate()
                                  .fadeIn(delay: 400.ms)
                                  .slideY(begin: 0.1, end: 0.0),
                              const SizedBox(height: 8),
                              Text(
                                "Mohammad Usman Bhat",
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ).animate()
                                  .fadeIn(delay: 500.ms)
                                  .slideY(begin: 0.1, end: 0.0),
                              const SizedBox(height: 16),
                              Text(
                                "Full-Stack Developer • Android Specialist",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                "A passionate full-stack developer and Android app developer from Kashmir. I love creating intuitive web and mobile applications.",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.center,
                              ).animate()
                                  .fadeIn(delay: 700.ms),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: AirbnbCard(
                          padding: const EdgeInsets.all(24),
                          borderRadius: 20,
                          showShadow: false,
                          borderWidth: 0.3,
                          child: Column(
                            children: [
                              Text(
                                'Connect with me',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _SocialButton(
                                    icon: FontAwesomeIcons.linkedin,
                                    color: const Color(0xFF0077B5),
                                    iconColor: Colors.white,
                                    onTap: () => _launchURL('https://www.linkedin.com/in/usman-bhat/'),
                                  ).animate().scale(delay: 800.ms, duration: 400.ms),
                                  _SocialButton(
                                    icon: FontAwesomeIcons.github,
                                    color: AirbnbTheme.primaryDark,
                                    onTap: () => _launchURL('https://github.com/Usman-bhat'),
                                  ).animate().scale(delay: 900.ms, duration: 400.ms),
                                  _SocialButton(
                                    icon: FontAwesomeIcons.twitter,
                                    color: const Color(0xFF1DA1F2),
                                    onTap: () => _launchURL('https://twitter.com/m_usmanbhat'),
                                  ).animate().scale(delay: 1000.ms, duration: 400.ms),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      AirbnbButton(
                        text: 'View My Portfolio',
                        icon: Icons.work_rounded,
                        onPressed: () => _launchURL('https://usman-bhat.github.io/home/'),
                      ),
                    ],
                  ),
                  // Contributor: HASHIM HAMEEM
                  Column(
                    children: [
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: AirbnbCard(
                          padding: const EdgeInsets.all(32),
                          borderRadius: 20,
                          showShadow: false,
                          borderWidth: 0.5,
                          child: Column(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.teal,
                                      Colors.teal.withOpacity(0.7),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: AirbnbTheme.mediumShadow,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.person_rounded,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                              ).animate()
                                  .scale(delay: 300.ms, duration: 600.ms, curve: Curves.elasticOut)
                                  .fadeIn(),
                              const SizedBox(height: 24),
                              Text(
                                "HASHIM HAMEEM",
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ).animate()
                                  .fadeIn(delay: 400.ms)
                                  .slideY(begin: 0.1, end: 0.0),
                              const SizedBox(height: 16),
                              Text(
                                "Full-Stack Developer • Android • iOS Specialist",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: AirbnbCard(
                          padding: const EdgeInsets.all(24),
                          borderRadius: 20,
                          showShadow: false,
                          borderWidth: 0.3,
                          child: Column(
                            children: [
                              Text(
                                'Connect with me',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _SocialButton(
                                    icon: FontAwesomeIcons.github,
                                    color: Colors.teal,
                                    onTap: () => _launchURL('https://github.com/HASHIM-HAMEEM'),
                                  ).animate().scale(delay: 800.ms, duration: 400.ms),
                                  _SocialButton(
                                    icon: FontAwesomeIcons.twitter,
                                    color: const Color(0xFF1DA1F2),
                                    onTap: () => _launchURL('https://x.com/HashimScnz'),
                                  ).animate().scale(delay: 900.ms, duration: 400.ms),
                                ],
                              ),
                            ],
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
    );
  }
  
  void _launchURL(String url) async {
    final Uri urlnew = Uri.parse(url);
    if (await canLaunchUrl(urlnew)) {
      await launchUrl(urlnew);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final Color? iconColor;
  
  const _SocialButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.iconColor,
  });
  
  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
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
        transform: Matrix4.identity()..scale(_isPressed ? 0.9 : 1.0),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: widget.color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.color.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: _isPressed ? null : AirbnbTheme.lightShadow,
        ),
        child: Center(
          child: FaIcon(
            widget.icon,
            size: 24,
            color: widget.iconColor ?? widget.color,
          ),
        ),
      ),
    );
  }
}
