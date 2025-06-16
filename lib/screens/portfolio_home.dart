import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../widgets/navigation_bar.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/projects_section.dart';
import '../sections/contact_section.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveScaledBox(
        width: ResponsiveValue<double>(
          context,
          defaultValue: 1200,
          conditionalValues: [
            const Condition.smallerThan(name: TABLET, value: 450),
            const Condition.between(start: 450, end: 800, value: 800),
          ],
        ).value,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HeroSection(key: _heroKey),
                  AboutSection(key: _aboutKey),
                  ProjectsSection(key: _projectsKey),
                  ContactSection(key: _contactKey),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomNavigationBar(
                onNavigate: _scrollToSection,
                heroKey: _heroKey,
                aboutKey: _aboutKey,
                projectsKey: _projectsKey,
                contactKey: _contactKey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
