import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:copilot/sections/skills_section.dart';

void main() {
  group('SkillsSection', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: ResponsiveBreakpoints.builder(
            child: const SkillsSection(),
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
        
        expect(find.text('My Skills'), findsOneWidget);
      });

      testWidgets('should display skills categories', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should display different skill categories
        expect(find.textContaining('Flutter'), findsWidgets);
        expect(find.textContaining('Dart'), findsWidgets);
      });

      testWidgets('should have skill progress indicators', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should have progress indicators (LinearProgressIndicator or similar)
        expect(find.byType(LinearProgressIndicator), findsWidgets);
      });
    });

    group('Responsive Layout', () {
      testWidgets('should adapt to desktop layout', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.text('My Skills'), findsOneWidget);
      });

      testWidgets('should adapt to mobile layout', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.text('My Skills'), findsOneWidget);
      });
    });

    group('Skill Items', () {
      testWidgets('should display skill names and levels', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should display skill percentages or progress
        expect(find.textContaining('%'), findsWidgets);
      });

      testWidgets('should have proper skill organization', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Skills should be organized in rows or columns
        expect(find.byType(Row), findsWidgets);
        expect(find.byType(Column), findsWidgets);
      });
    });
  });
}