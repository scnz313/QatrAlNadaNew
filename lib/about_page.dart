import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F7F7), Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A699).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Color(0xFF00A699),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "!اسلام عليكم \r Mohammad Usman Bhat",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: const Color(0xFF222222),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "A passionate full-stack developer and Android app developer from Kashmir. "
                      "I love creating intuitive web and mobile applications.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF666666),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _launchURL('https://usman-bhat.github.io/home/'),
                icon: const Icon(Icons.language),
                label: const Text('View My Portfolio'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A699),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Connect with me",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF222222),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSocialButton(
                          icon: FontAwesomeIcons.linkedin,
                          url: 'https://www.linkedin.com/in/usman-bhat/',
                          tooltip: 'LinkedIn',
                        ),
                        _buildSocialButton(
                          icon: FontAwesomeIcons.github,
                          url: 'https://github.com/Usman-bhat',
                          tooltip: 'GitHub',
                        ),
                        _buildSocialButton(
                          icon: FontAwesomeIcons.twitter,
                          url: 'https://twitter.com/m_usmanbhat',
                          tooltip: 'Twitter/X',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _launchURL(
                    'https://play.google.com/apps/publish/?account=7820612022916724487'),
                icon: const Icon(Icons.store),
                label: const Text('Visit My Play Store Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00A699),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String url,
    required String tooltip,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF00A699).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: FaIcon(icon, color: const Color(0xFF00A699)),
        onPressed: () => _launchURL(url),
        tooltip: tooltip,
        iconSize: 24,
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri urlnew = Uri.parse(url);
    try {
      if (await canLaunchUrl(urlnew)) {
        await launchUrl(urlnew);
      } else {
        // Handle gracefully without throwing
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      // Handle gracefully without throwing
      debugPrint('Error launching $url: $e');
    }
  }
}
