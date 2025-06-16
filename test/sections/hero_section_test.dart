import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:copilot/sections/hero_section.dart';

void main() {
  group('HeroSection', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: ResponsiveBreakpoints.builder(
            child: const HeroSection(),
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            ],
          ),
        ),
      );
    }

    group('Content Rendering', () {
      testWidgets('should display hero content', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.text('Hello, I\'m'), findsOneWidget);
        expect(find.text('John Doe'), findsOneWidget);
      });

      testWidgets('should display description text', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.textContaining('Passionate about creating beautiful'), findsOneWidget);
      });

      testWidgets('should display animated text kit', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Check for animated text (Flutter Developer, Mobile App Creator, etc.)
        expect(find.textContaining('Flutter Developer'), findsWidgets);
      });

      testWidgets('should display action buttons', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.text('View My Work'), findsOneWidget);
        expect(find.text('Contact Me'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsNWidgets(2));
      });

      testWidgets('should display profile section', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Profile section should contain an icon (placeholder for profile image)
        expect(find.byIcon(Icons.person), findsOneWidget);
      });
    });

    group('Responsive Layout', () {
      testWidgets('should display desktop layout correctly', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // In desktop layout, should use ResponsiveRowColumnType.ROW
        expect(find.text('Hello, I\'m'), findsOneWidget);
        expect(find.text('John Doe'), findsOneWidget);
        
        // Social links should be visible in desktop layout
        expect(find.byIcon(Icons.link), findsWidgets);
      });

      testWidgets('should display mobile layout correctly', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // In mobile layout, should use ResponsiveRowColumnType.COLUMN
        expect(find.text('Hello, I\'m'), findsOneWidget);
        expect(find.text('John Doe'), findsOneWidget);
        
        // Social links should still be visible in mobile layout
        expect(find.byIcon(Icons.link), findsWidgets);
      });
    });

    group('Gradient Background', () {
      testWidgets('should have gradient background', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Find the main container with gradient
        final Container container = tester.widget(find.byType(Container).first);
        expect(container.decoration, isA<BoxDecoration>());
        
        final BoxDecoration decoration = container.decoration as BoxDecoration;
        expect(decoration.gradient, isA<LinearGradient>());
        
        final LinearGradient gradient = decoration.gradient as LinearGradient;
        expect(gradient.colors.length, equals(3));
        expect(gradient.colors[0], equals(const Color(0xFF6366F1)));
        expect(gradient.colors[1], equals(const Color(0xFF8B5CF6)));
        expect(gradient.colors[2], equals(const Color(0xFFEC4899)));
      });
    });

    group('Social Links', () {
      testWidgets('should display social media links', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should have social media icons (GitHub, LinkedIn, Twitter, Email)
        // These would be rendered as custom icons, but we can check for gesture detectors
        expect(find.byType(GestureDetector), findsWidgets);
      });

      testWidgets('should have proper social link structure', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // In desktop layout, social links should be in a row
        expect(find.byType(Row), findsWidgets);
      });
    });

    group('Screen Height Adaptation', () {
      testWidgets('should adapt to screen height', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 600));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Main container should use screen height
        final Container container = tester.widget(find.byType(Container).first);
        expect(container.height, equals(600.0));
      });

      testWidgets('should adapt to different screen height', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 1000));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Main container should use new screen height
        final Container container = tester.widget(find.byType(Container).first);
        expect(container.height, equals(1000.0));
      });
    });

    group('Button Interactions', () {
      testWidgets('should handle view my work button tap', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Find and tap the "View My Work" button
        final viewWorkButton = find.text('View My Work');
        expect(viewWorkButton, findsOneWidget);
        
        // Should be able to tap without errors
        await tester.tap(viewWorkButton);
        await tester.pumpAndSettle();
      });

      testWidgets('should handle contact me button tap', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Find and tap the "Contact Me" button
        final contactButton = find.text('Contact Me');
        expect(contactButton, findsOneWidget);
        
        // Should be able to tap without errors
        await tester.tap(contactButton);
        await tester.pumpAndSettle();
      });
    });

    group('Profile Image Section', () {
      testWidgets('should display profile placeholder', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should have a circular profile image placeholder
        expect(find.byType(ClipOval), findsOneWidget);
        expect(find.byIcon(Icons.person), findsOneWidget);
      });

      testWidgets('should adapt profile size for mobile', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Profile section should still be rendered
        expect(find.byIcon(Icons.person), findsOneWidget);
      });

      testWidgets('should adapt profile size for desktop', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Profile section should still be rendered
        expect(find.byIcon(Icons.person), findsOneWidget);
      });
    });
  });
}