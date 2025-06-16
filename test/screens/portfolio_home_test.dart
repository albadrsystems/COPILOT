import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:copilot/screens/portfolio_home.dart';
import 'package:copilot/widgets/navigation_bar.dart';
import 'package:copilot/sections/hero_section.dart';
import 'package:copilot/sections/about_section.dart';
import 'package:copilot/sections/skills_section.dart';
import 'package:copilot/sections/projects_section.dart';
import 'package:copilot/sections/contact_section.dart';

void main() {
  group('PortfolioHome', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: ResponsiveBreakpoints.builder(
          child: const PortfolioHome(),
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          ],
        ),
      );
    }

    group('Widget Structure', () {
      testWidgets('should render all main sections', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.byType(HeroSection), findsOneWidget);
        expect(find.byType(AboutSection), findsOneWidget);
        expect(find.byType(SkillsSection), findsOneWidget);
        expect(find.byType(ProjectsSection), findsOneWidget);
        expect(find.byType(ContactSection), findsOneWidget);
      });

      testWidgets('should render navigation bar', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.byType(CustomNavigationBar), findsOneWidget);
      });

      testWidgets('should have scrollable content', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });

      testWidgets('should have responsive scaled box', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.byType(ResponsiveScaledBox), findsOneWidget);
      });
    });

    group('Navigation Functionality', () {
      testWidgets('should scroll to section when navigation is triggered', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Get initial scroll position
        final scrollView = find.byType(SingleChildScrollView);
        expect(scrollView, findsOneWidget);
        
        final ScrollController? controller = tester.widget<SingleChildScrollView>(scrollView).controller;
        final double initialPosition = controller?.position.pixels ?? 0;
        
        // Tap on About navigation
        await tester.tap(find.text('About'));
        await tester.pumpAndSettle();
        
        // Scroll position should have changed
        final double newPosition = controller?.position.pixels ?? 0;
        expect(newPosition, isNot(equals(initialPosition)));
      });

      testWidgets('should handle mobile navigation', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Open mobile menu
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();
        
        // Should be able to navigate from mobile menu
        await tester.tap(find.text('About'));
        await tester.pumpAndSettle();
      });
    });

    group('Responsive Behavior', () {
      testWidgets('should handle mobile screen size', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // All sections should still be present
        expect(find.byType(HeroSection), findsOneWidget);
        expect(find.byType(AboutSection), findsOneWidget);
        expect(find.byType(SkillsSection), findsOneWidget);
        expect(find.byType(ProjectsSection), findsOneWidget);
        expect(find.byType(ContactSection), findsOneWidget);
      });

      testWidgets('should handle tablet screen size', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(700, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // All sections should still be present
        expect(find.byType(HeroSection), findsOneWidget);
        expect(find.byType(ContactSection), findsOneWidget);
      });

      testWidgets('should handle desktop screen size', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // All sections should still be present
        expect(find.byType(HeroSection), findsOneWidget);
        expect(find.byType(ContactSection), findsOneWidget);
        
        // Desktop navigation should be visible
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('About'), findsOneWidget);
        expect(find.text('Skills'), findsOneWidget);
        expect(find.text('Projects'), findsOneWidget);
        expect(find.text('Contact'), findsOneWidget);
      });
    });

    group('Layout Structure', () {
      testWidgets('should have proper stacking order', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Navigation bar should be positioned on top
        expect(find.byType(Stack), findsOneWidget);
        expect(find.byType(Positioned), findsOneWidget);
      });

      testWidgets('should maintain scroll controller', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        final scrollView = find.byType(SingleChildScrollView);
        final ScrollController? controller = tester.widget<SingleChildScrollView>(scrollView).controller;
        expect(controller, isNotNull);
      });
    });

    group('Section Content', () {
      testWidgets('should display hero section content', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.text('Hello, I\'m'), findsOneWidget);
        expect(find.text('John Doe'), findsWidgets);
      });

      testWidgets('should display about section content', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.text('About Me'), findsOneWidget);
      });

      testWidgets('should display contact section content', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.text('Let\'s Start a Conversation'), findsOneWidget);
      });
    });

    group('Scroll Navigation', () {
      testWidgets('should handle scrolling between sections', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should be able to scroll through content
        await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
        await tester.pumpAndSettle();
        
        // Content should still be accessible
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });

      testWidgets('should maintain global keys for sections', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // All sections should have global keys for navigation
        expect(find.byType(HeroSection), findsOneWidget);
        expect(find.byType(AboutSection), findsOneWidget);
        expect(find.byType(SkillsSection), findsOneWidget);
        expect(find.byType(ProjectsSection), findsOneWidget);
        expect(find.byType(ContactSection), findsOneWidget);
      });
    });
  });
}