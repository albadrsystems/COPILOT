import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:copilot/sections/contact_section.dart';

void main() {
  group('ContactSection', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: ResponsiveBreakpoints.builder(
            child: const ContactSection(),
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            ],
          ),
        ),
      );
    }

    group('Widget Rendering', () {
      testWidgets('should display contact section title', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        expect(find.text('Let\'s Start a Conversation'), findsOneWidget);
      });

      testWidgets('should display contact information', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        expect(find.text('john.doe@example.com'), findsOneWidget);
        expect(find.text('+1 (555) 123-4567'), findsOneWidget);
        expect(find.text('San Francisco, CA'), findsOneWidget);
      });

      testWidgets('should display form fields', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        expect(find.byType(TextFormField), findsNWidgets(3));
        expect(find.text('Your Name'), findsOneWidget);
        expect(find.text('Email Address'), findsOneWidget);
        expect(find.text('Your Message'), findsOneWidget);
      });

      testWidgets('should display submit button', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        expect(find.text('Send Message'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('should display footer', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        expect(find.text('© 2025 John Doe. All rights reserved.'), findsOneWidget);
        expect(find.text('Built with Flutter & ❤️'), findsOneWidget);
      });
    });

    group('Form Validation', () {
      testWidgets('should show validation error for empty name', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        // Find and tap the submit button without filling the form
        await tester.tap(find.text('Send Message'));
        await tester.pumpAndSettle();
        
        expect(find.text('Please enter your name'), findsOneWidget);
      });

      testWidgets('should show validation error for empty email', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        // Fill name but leave email empty
        await tester.enterText(find.widgetWithText(TextFormField, 'Your Name'), 'Test User');
        await tester.tap(find.text('Send Message'));
        await tester.pumpAndSettle();
        
        expect(find.text('Please enter your email'), findsOneWidget);
      });

      testWidgets('should show validation error for invalid email format', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        // Fill with invalid email
        await tester.enterText(find.widgetWithText(TextFormField, 'Your Name'), 'Test User');
        final emailField = find.ancestor(
          of: find.text('Email Address'),
          matching: find.byType(TextFormField),
        );
        await tester.enterText(emailField, 'invalid-email');
        await tester.tap(find.text('Send Message'));
        await tester.pumpAndSettle();
        
        expect(find.text('Please enter a valid email'), findsOneWidget);
      });

      testWidgets('should show validation error for empty message', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        // Fill name and email but leave message empty
        await tester.enterText(find.widgetWithText(TextFormField, 'Your Name'), 'Test User');
        final emailField = find.ancestor(
          of: find.text('Email Address'),
          matching: find.byType(TextFormField),
        );
        await tester.enterText(emailField, 'test@example.com');
        await tester.tap(find.text('Send Message'));
        await tester.pumpAndSettle();
        
        expect(find.text('Please enter your message'), findsOneWidget);
      });

      testWidgets('should show validation error for short message', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        // Fill all fields but with short message
        await tester.enterText(find.widgetWithText(TextFormField, 'Your Name'), 'Test User');
        final emailField = find.ancestor(
          of: find.text('Email Address'),
          matching: find.byType(TextFormField),
        );
        await tester.enterText(emailField, 'test@example.com');
        final messageField = find.ancestor(
          of: find.text('Your Message'),
          matching: find.byType(TextFormField),
        );
        await tester.enterText(messageField, 'Short'); // Less than 10 characters
        await tester.tap(find.text('Send Message'));
        await tester.pumpAndSettle();
        
        expect(find.text('Message should be at least 10 characters'), findsOneWidget);
      });

      testWidgets('should accept valid form data', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        // Fill all fields with valid data
        await tester.enterText(find.widgetWithText(TextFormField, 'Your Name'), 'Test User');
        final emailField = find.ancestor(
          of: find.text('Email Address'),
          matching: find.byType(TextFormField),
        );
        await tester.enterText(emailField, 'test@example.com');
        final messageField = find.ancestor(
          of: find.text('Your Message'),
          matching: find.byType(TextFormField),
        );
        await tester.enterText(messageField, 'This is a valid message with enough characters');
        
        await tester.tap(find.text('Send Message'));
        await tester.pump(); // Start the submission
        
        // Should show loading indicator
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        
        // Wait for submission to complete
        await tester.pumpAndSettle(const Duration(seconds: 3));
        
        // Should show success snackbar
        expect(find.text('Message sent successfully! I\'ll get back to you soon.'), findsOneWidget);
      });
    });

    group('Loading State', () {
      testWidgets('should disable submit button during loading', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        // Fill form with valid data
        await tester.enterText(find.widgetWithText(TextFormField, 'Your Name'), 'Test User');
        final emailField = find.ancestor(
          of: find.text('Email Address'),
          matching: find.byType(TextFormField),
        );
        await tester.enterText(emailField, 'test@example.com');
        final messageField = find.ancestor(
          of: find.text('Your Message'),
          matching: find.byType(TextFormField),
        );
        await tester.enterText(messageField, 'Valid message content');
        
        await tester.tap(find.text('Send Message'));
        await tester.pump();
        
        // Button should be disabled (no onPressed) and show loading indicator
        final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
        expect(button.onPressed, isNull);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('Responsive Layout', () {
      testWidgets('should adapt to mobile layout', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());
        
        // Contact section should still be rendered
        expect(find.text('Let\'s Start a Conversation'), findsOneWidget);
        expect(find.byType(TextFormField), findsNWidgets(3));
      });

      testWidgets('should adapt to desktop layout', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());
        
        // Contact section should still be rendered
        expect(find.text('Let\'s Start a Conversation'), findsOneWidget);
        expect(find.byType(TextFormField), findsNWidgets(3));
      });
    });

    group('Social Media Links', () {
      testWidgets('should display social media icons', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        
        // Look for social media icons (FontAwesome icons)
        expect(find.byIcon(Icons.link), findsWidgets); // Social links should be present
      });
    });
  });
}