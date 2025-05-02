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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "!اسلام عليكم \r Mohammad Usman Bhat",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "A passionate full-stack developer and Android app developer from Kashmir. "
              "I love creating intuitive web and mobile applications.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _launchURL('https://portfolio-mohammad.web.app/'),
              child: const Text('View My Portfolio'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.linkedin),
                  onPressed: () =>
                      _launchURL('https://www.linkedin.com/in/usman-bhat/'),
                  tooltip: 'LinkedIn',
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.github),
                  onPressed: () => _launchURL('https://github.com/Usman-bhat'),
                  tooltip: 'GitHub',
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.twitter),
                  onPressed: () =>
                      _launchURL('https://twitter.com/m_usmanbhat'),
                  tooltip: 'Twitter/X',
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _launchURL(
                  'https://play.google.com/store/apps/developer?id=Ehsan_apps'),
              child: const Text('Visit My Play Store Profile'),
            ),
            
            const Divider(height: 40),
            
            // Hashim Hameem section
            const Text(
              "Contributions by Hashim Hameem",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "Developer and contributor to this application with a focus on user experience and functionality improvements.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.linkedin),
                  onPressed: () =>
                      _launchURL('https://www.linkedin.com/in/hashim-hameem-318029239?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app'),
                  tooltip: 'LinkedIn',
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.github),
                  onPressed: () => _launchURL('https://github.com/HASHIM-HAMEEM'),
                  tooltip: 'GitHub',
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.twitter),
                  onPressed: () =>
                      _launchURL('https://x.com/HashimScnz'),
                  tooltip: 'Twitter/X',
                ),
              ],
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
