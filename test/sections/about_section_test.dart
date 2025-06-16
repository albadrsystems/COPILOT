import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:copilot/sections/about_section.dart';

void main() {
  group('AboutSection', () {
    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: ResponsiveBreakpoints.builder(
            child: const AboutSection(),
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
        
        expect(find.text('About Me'), findsOneWidget);
      });

      testWidgets('should display about content', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should contain descriptive text about the person
        expect(find.textContaining('passionate'), findsWidgets);
      });

      testWidgets('should have decorative underline', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        // Should have a decorative container (underline) after the title
        expect(find.byType(Container), findsWidgets);
      });
    });

    group('Responsive Layout', () {
      testWidgets('should adapt to desktop layout', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.text('About Me'), findsOneWidget);
      });

      testWidgets('should adapt to mobile layout', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        expect(find.text('About Me'), findsOneWidget);
      });
    });

    group('Background and Styling', () {
      testWidgets('should have correct background color', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        final Container container = tester.widget(find.byType(Container).first);
        expect(container.color, equals(Colors.grey[50]));
      });

      testWidgets('should have proper padding for desktop', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        final Container container = tester.widget(find.byType(Container).first);
        final EdgeInsets padding = container.padding as EdgeInsets;
        expect(padding.horizontal, equals(80.0 * 2)); // 80 on each side
        expect(padding.vertical, equals(100.0 * 2)); // 100 on top and bottom
      });

      testWidgets('should have proper padding for mobile', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();
        
        final Container container = tester.widget(find.byType(Container).first);
        final EdgeInsets padding = container.padding as EdgeInsets;
        expect(padding.horizontal, equals(20.0 * 2)); // 20 on each side
        expect(padding.vertical, equals(60.0 * 2)); // 60 on top and bottom
      });
    });
  });
}