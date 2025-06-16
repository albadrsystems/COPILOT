// Comprehensive Flutter widget tests for the Portfolio application.
//
// This file contains tests for the main app structure, theme configuration,
// and basic functionality. Additional component-specific tests are in separate files.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:copilot/main.dart';
import 'package:copilot/screens/portfolio_home.dart';

void main() {
  group('PortfolioApp', () {
    testWidgets('should create app with correct title and theme', (WidgetTester tester) async {
      await tester.pumpWidget(const PortfolioApp());

      // Verify that MaterialApp is created
      expect(find.byType(MaterialApp), findsOneWidget);
      
      // Get the MaterialApp widget
      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      
      // Verify app configuration
      expect(app.title, equals('Personal Portfolio'));
      expect(app.debugShowCheckedModeBanner, isFalse);
      expect(app.theme?.useMaterial3, isTrue);
      expect(app.theme?.colorScheme.primary, equals(const Color(0xFF6366F1)));
    });

    testWidgets('should use responsive framework', (WidgetTester tester) async {
      await tester.pumpWidget(const PortfolioApp());

      // Verify ResponsiveBreakpoints widget exists
      expect(find.byType(ResponsiveBreakpoints), findsOneWidget);
    });

    testWidgets('should render portfolio home as main screen', (WidgetTester tester) async {
      await tester.pumpWidget(const PortfolioApp());

      // Verify PortfolioHome is the home screen
      expect(find.byType(PortfolioHome), findsOneWidget);
    });
  });

  group('Basic App Content', () {
    testWidgets('portfolio app loads and displays main content', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();

      // Verify that key content elements are present
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Hello, I\'m'), findsOneWidget);
    });

    testWidgets('should display navigation elements', (WidgetTester tester) async {
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();

      // Check for navigation items (at least on desktop layout)
      // Note: In mobile layout, these might be in a drawer/menu
      expect(find.textContaining('Home'), findsWidgets);
    });

    testWidgets('should display main sections', (WidgetTester tester) async {
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();

      // Verify main sections are rendered
      expect(find.text('About Me'), findsOneWidget);
      expect(find.text('Let\'s Start a Conversation'), findsOneWidget);
    });
  });

  group('Responsive Behavior', () {
    testWidgets('should handle mobile layout', (WidgetTester tester) async {
      // Set mobile screen size
      await tester.binding.setSurfaceSize(const Size(400, 800));
      
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();

      // Verify mobile-specific elements
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('should handle desktop layout', (WidgetTester tester) async {
      // Set desktop screen size
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();

      // Verify desktop layout has navigation items visible
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
      expect(find.text('Skills'), findsOneWidget);
      expect(find.text('Projects'), findsOneWidget);
      expect(find.text('Contact'), findsOneWidget);
    });
  });
}
