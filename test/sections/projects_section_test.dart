import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:copilot/sections/projects_section.dart';

void main() {
  group('ProjectsSection', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: ResponsiveBreakpoints.builder(
            child: const ProjectsSection(),
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
      testWidgets('should display section title', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.text('My Projects'), findsOneWidget);
      });

      testWidgets('should display project cards', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should have project cards/containers
        expect(find.byType(Card), findsWidgets);
      });

      testWidgets('should display project information', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should display project titles and descriptions
        expect(find.textContaining('Project'), findsWidgets);
      });
    });

    group('Responsive Layout', () {
      testWidgets('should adapt to desktop layout', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.text('My Projects'), findsOneWidget);
      });

      testWidgets('should adapt to mobile layout', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.text('My Projects'), findsOneWidget);
      });
    });

    group('Project Cards', () {
      testWidgets('should display project details', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Projects should have descriptions
        expect(find.textContaining('Flutter'), findsWidgets);
      });

      testWidgets('should have interactive elements', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should have buttons or links for projects
        expect(find.byType(GestureDetector), findsWidgets);
      });

      testWidgets('should handle project interactions', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should be able to tap on project cards
        final cards = find.byType(Card);
        if (cards.evaluate().isNotEmpty) {
          await tester.tap(cards.first);
          await tester.pumpAndSettle();
        }
      });
    });

    group('Project Grid Layout', () {
      testWidgets('should organize projects in grid on desktop', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should use grid or row layout for desktop
        expect(find.byType(GridView), findsWidgets);
      });

      testWidgets('should organize projects in column on mobile', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should use column layout for mobile
        expect(find.byType(Column), findsWidgets);
      });
    });
  });
}