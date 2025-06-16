import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:copilot/main.dart';

void main() {
  group('Portfolio App Integration Tests', () {
    testWidgets('complete user journey through portfolio', (WidgetTester tester) async {
      // Start the app
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      
      // Verify initial hero section is visible
      expect(find.text('Hello, I\'m'), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
      
      // Test navigation to About section
      await tester.tap(find.text('About'));
      await tester.pumpAndSettle();
      
      // Verify About section content is visible
      expect(find.text('About Me'), findsOneWidget);
      
      // Test navigation to Skills section
      await tester.tap(find.text('Skills'));
      await tester.pumpAndSettle();
      
      // Test navigation to Projects section
      await tester.tap(find.text('Projects'));
      await tester.pumpAndSettle();
      
      // Test navigation to Contact section
      await tester.tap(find.text('Contact'));
      await tester.pumpAndSettle();
      
      // Verify Contact section content is visible
      expect(find.text('Let\'s Start a Conversation'), findsOneWidget);
    });

    testWidgets('mobile navigation workflow', (WidgetTester tester) async {
      // Set mobile screen size
      await tester.binding.setSurfaceSize(const Size(400, 800));
      
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      
      // Verify mobile menu icon is present
      expect(find.byIcon(Icons.menu), findsOneWidget);
      
      // Open mobile menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      
      // Test navigation through mobile menu
      expect(find.text('About'), findsOneWidget);
      await tester.tap(find.text('About'));
      await tester.pumpAndSettle();
      
      // Open menu again and navigate to contact
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('Contact'));
      await tester.pumpAndSettle();
      
      expect(find.text('Let\'s Start a Conversation'), findsOneWidget);
    });

    testWidgets('contact form submission workflow', (WidgetTester tester) async {
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      
      // Navigate to contact section
      await tester.tap(find.text('Contact'));
      await tester.pumpAndSettle();
      
      // Fill out the contact form
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Your Name'),
        'Test User'
      );
      
      final emailField = find.ancestor(
        of: find.text('Email Address'),
        matching: find.byType(TextFormField),
      );
      await tester.enterText(emailField, 'test@example.com');
      
      final messageField = find.ancestor(
        of: find.text('Your Message'),
        matching: find.byType(TextFormField),
      );
      await tester.enterText(messageField, 'This is a test message with enough characters to be valid');
      
      // Submit the form
      await tester.tap(find.text('Send Message'));
      await tester.pump();
      
      // Verify loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // Wait for submission to complete
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      // Verify success message
      expect(find.text('Message sent successfully! I\'ll get back to you soon.'), findsOneWidget);
    });

    testWidgets('responsive layout changes', (WidgetTester tester) async {
      // Test desktop layout
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      
      // Verify desktop navigation is visible
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsNothing);
      
      // Switch to mobile layout
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      
      // Verify mobile navigation
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.text('Home'), findsNothing); // Should be hidden in mobile
      
      // Switch back to desktop
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      
      // Verify desktop navigation is back
      expect(find.text('Home'), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsNothing);
    });

    testWidgets('scroll behavior and navigation bar changes', (WidgetTester tester) async {
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      
      // Initial state - navigation bar should be transparent
      final ScrollController? controller = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView)
      ).controller;
      
      expect(controller?.position.pixels, equals(0.0));
      
      // Scroll down
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
      await tester.pumpAndSettle();
      
      // Verify scroll position changed
      expect(controller?.position.pixels, greaterThan(0.0));
      
      // Navigation bar appearance should change (this would be visible in the UI)
      // We can verify the scroll position changed, which triggers the navbar change
      expect(controller?.position.pixels, greaterThan(100.0));
    });

    testWidgets('form validation error handling', (WidgetTester tester) async {
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      
      // Navigate to contact section
      await tester.tap(find.text('Contact'));
      await tester.pumpAndSettle();
      
      // Try to submit empty form
      await tester.tap(find.text('Send Message'));
      await tester.pumpAndSettle();
      
      // Should show validation errors
      expect(find.text('Please enter your name'), findsOneWidget);
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your message'), findsOneWidget);
      
      // Fill name only
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Your Name'),
        'Test User'
      );
      await tester.tap(find.text('Send Message'));
      await tester.pumpAndSettle();
      
      // Should still show email and message errors
      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your message'), findsOneWidget);
      expect(find.text('Please enter your name'), findsNothing);
    });

    testWidgets('hero section interactive elements', (WidgetTester tester) async {
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      
      // Test hero section buttons
      expect(find.text('View My Work'), findsOneWidget);
      expect(find.text('Contact Me'), findsOneWidget);
      
      // Tap View My Work button
      await tester.tap(find.text('View My Work'));
      await tester.pumpAndSettle();
      
      // Tap Contact Me button
      await tester.tap(find.text('Contact Me'));
      await tester.pumpAndSettle();
      
      // Should navigate to contact section
      expect(find.text('Let\'s Start a Conversation'), findsOneWidget);
    });

    testWidgets('complete app accessibility', (WidgetTester tester) async {
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      
      // Check that major UI elements are present and accessible
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      
      // Test keyboard navigation (basic accessibility)
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();
      
      // Verify app doesn't crash with keyboard navigation
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}