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
    return Scaffold(
      backgroundColor: AirbnbTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
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
                    icon: Icons.arrow_back_rounded,
                    onPressed: () => Navigator.pop(context),
                    showBackground: false,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'About Me',
                      style: AirbnbTheme.textTheme.headlineMedium,
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Profile Card
                    AirbnbCard(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          // Avatar
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AirbnbTheme.primaryRed,
                                  AirbnbTheme.primaryRed.withOpacity(0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: AirbnbTheme.mediumShadow,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person_rounded,
                                size: 60,
                                color: AirbnbTheme.primaryWhite,
                              ),
                            ),
                          ).animate()
                              .scale(
                                delay: 300.ms,
                                duration: 600.ms,
                                curve: Curves.elasticOut,
                              )
                              .fadeIn(),
                          
                          const SizedBox(height: 24),
                          
                          // Name
                          Text(
                            "اسلام عليكم!",
                            style: AirbnbTheme.arabicTextTheme.displayMedium?.copyWith(
                              color: AirbnbTheme.primaryDark,
                              fontSize: 28,
                            ),
                            textDirection: TextDirection.rtl,
                          ).animate()
                              .fadeIn(delay: 400.ms)
                              .slideY(begin: 0.1, end: 0),
                          
                          const SizedBox(height: 8),
                          
                          Text(
                            "Mohammad Usman Bhat",
                            style: AirbnbTheme.textTheme.headlineLarge?.copyWith(
                              color: AirbnbTheme.primaryDark,
                            ),
                          ).animate()
                              .fadeIn(delay: 500.ms)
                              .slideY(begin: 0.1, end: 0),
                          
                          const SizedBox(height: 16),
                          
                          // Bio
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AirbnbTheme.gray100,
                              borderRadius: BorderRadius.circular(
                                AirbnbTheme.radiusRound,
                              ),
                            ),
                            child: Text(
                              "Full-Stack Developer • Android Specialist",
                              style: AirbnbTheme.textTheme.bodyMedium?.copyWith(
                                color: AirbnbTheme.gray600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ).animate()
                              .fadeIn(delay: 600.ms)
                              .scale(begin: 0.9, end: 1.0),
                          
                          const SizedBox(height: 24),
                          
                          Text(
                            "A passionate full-stack developer and Android app developer from Kashmir. "
                            "I love creating intuitive web and mobile applications.",
                            style: AirbnbTheme.textTheme.bodyLarge?.copyWith(
                              color: AirbnbTheme.gray600,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ).animate()
                              .fadeIn(delay: 700.ms),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Social Links
                    AirbnbCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(
                            'Connect with me',
                            style: AirbnbTheme.textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _SocialButton(
                                icon: FontAwesomeIcons.linkedin,
                                color: const Color(0xFF0077B5),
                                onTap: () => _launchURL(
                                  'https://www.linkedin.com/in/usman-bhat/',
                                ),
                              ).animate()
                                  .scale(delay: 800.ms, duration: 400.ms),
                              _SocialButton(
                                icon: FontAwesomeIcons.github,
                                color: AirbnbTheme.primaryDark,
                                onTap: () => _launchURL(
                                  'https://github.com/Usman-bhat',
                                ),
                              ).animate()
                                  .scale(delay: 900.ms, duration: 400.ms),
                              _SocialButton(
                                icon: FontAwesomeIcons.twitter,
                                color: const Color(0xFF1DA1F2),
                                onTap: () => _launchURL(
                                  'https://twitter.com/m_usmanbhat',
                                ),
                              ).animate()
                                  .scale(delay: 1000.ms, duration: 400.ms),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Action Buttons
                    AirbnbButton(
                      text: 'View My Portfolio',
                      icon: Icons.work_rounded,
                      onPressed: () => _launchURL(
                        'https://usman-bhat.github.io/home/',
                      ),
                    ).animate()
                        .fadeIn(delay: 1100.ms)
                        .slideY(begin: 0.2, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    AirbnbButton(
                      text: 'Visit Play Store Profile',
                      icon: FontAwesomeIcons.googlePlay,
                      isOutlined: true,
                      onPressed: () => _launchURL(
                        'https://play.google.com/apps/publish/?account=7820612022916724487',
                      ),
                    ).animate()
                        .fadeIn(delay: 1200.ms)
                        .slideY(begin: 0.2, end: 0),
                    
                    const SizedBox(height: 40),
                    
                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.code_rounded,
                          size: 16,
                          color: AirbnbTheme.gray400,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Built with Flutter',
                          style: AirbnbTheme.textTheme.bodySmall?.copyWith(
                            color: AirbnbTheme.gray400,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.favorite_rounded,
                          size: 16,
                          color: AirbnbTheme.primaryRed,
                        ),
                      ],
                    ).animate()
                        .fadeIn(delay: 1300.ms),
                  ],
                ),
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
  
  const _SocialButton({
    required this.icon,
    required this.color,
    required this.onTap,
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
          color: widget.color.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.color.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: _isPressed ? null : AirbnbTheme.lightShadow,
        ),
        child: Center(
          child: FaIcon(
            widget.icon,
            size: 24,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
