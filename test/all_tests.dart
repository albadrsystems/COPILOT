import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'widget_test.dart' as widget_tests;
import 'widgets/navigation_bar_test.dart' as navigation_tests;
import 'sections/hero_section_test.dart' as hero_tests;
import 'sections/about_section_test.dart' as about_tests;
import 'sections/skills_section_test.dart' as skills_tests;
import 'sections/projects_section_test.dart' as projects_tests;
import 'sections/contact_section_test.dart' as contact_tests;
import 'screens/portfolio_home_test.dart' as portfolio_tests;
import 'integration/app_integration_test.dart' as integration_tests;

/// Comprehensive test suite for the Portfolio application.
/// 
/// This file runs all test groups to provide complete coverage
/// of the application functionality.
void main() {
  group('Portfolio App - Complete Test Suite', () {
    group('Main App Tests', widget_tests.main);
    
    group('Widget Tests', () {
      group('Navigation Bar', navigation_tests.main);
    });
    
    group('Section Tests', () {
      group('Hero Section', hero_tests.main);
      group('About Section', about_tests.main);
      group('Skills Section', skills_tests.main);
      group('Projects Section', projects_tests.main);
      group('Contact Section', contact_tests.main);
    });
    
    group('Screen Tests', () {
      group('Portfolio Home', portfolio_tests.main);
    });
    
    group('Integration Tests', integration_tests.main);
  });
}