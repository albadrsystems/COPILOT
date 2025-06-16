import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6366F1),
            Color(0xFF8B5CF6),
            Color(0xFFEC4899),
          ],
        ),
      ),
      child: Center(
        child: ResponsiveRowColumn(
          layout: isDesktop 
              ? ResponsiveRowColumnType.ROW 
              : ResponsiveRowColumnType.COLUMN,
          rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
          columnMainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: _buildProfileSection(isDesktop),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: _buildTextSection(isDesktop),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 40 : 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: isDesktop ? 300 : 200,
            height: isDesktop ? 300 : 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipOval(
              child: Container(
                color: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: isDesktop ? 150 : 100,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          if (!isDesktop) const SizedBox(height: 30),
          if (!isDesktop) _buildSocialLinks(),
        ],
      ),
    );
  }

  Widget _buildTextSection(bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 40 : 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: isDesktop 
            ? CrossAxisAlignment.start 
            : CrossAxisAlignment.center,
        children: [
          Text(
            'Hello, I\'m',
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 24 : 18,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'John Doe',
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 56 : 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: isDesktop ? 80 : 60,
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  'Flutter Developer',
                  textStyle: GoogleFonts.poppins(
                    fontSize: isDesktop ? 32 : 24,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
                TypewriterAnimatedText(
                  'Mobile App Developer',
                  textStyle: GoogleFonts.poppins(
                    fontSize: isDesktop ? 32 : 24,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
                TypewriterAnimatedText(
                  'UI/UX Designer',
                  textStyle: GoogleFonts.poppins(
                    fontSize: isDesktop ? 32 : 24,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Passionate about creating beautiful and functional mobile applications with Flutter. I love turning ideas into reality through clean, efficient code.',
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 18 : 16,
              color: Colors.white.withOpacity(0.8),
              height: 1.6,
            ),
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
            maxLines: 3,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: isDesktop 
                ? MainAxisAlignment.start 
                : MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Scroll to projects section
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF6366F1),
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 32 : 24,
                    vertical: isDesktop ? 16 : 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'View My Work',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {
                  // Download CV
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 2),
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 32 : 24,
                    vertical: isDesktop ? 16 : 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Download CV',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (isDesktop) ...[
            const SizedBox(height: 40),
            _buildSocialLinks(),
          ],
        ],
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(FontAwesomeIcons.github, 'https://github.com'),
        const SizedBox(width: 20),
        _buildSocialIcon(FontAwesomeIcons.linkedin, 'https://linkedin.com'),
        const SizedBox(width: 20),
        _buildSocialIcon(FontAwesomeIcons.twitter, 'https://twitter.com'),
        const SizedBox(width: 20),
        _buildSocialIcon(FontAwesomeIcons.envelope, 'mailto:john@example.com'),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
