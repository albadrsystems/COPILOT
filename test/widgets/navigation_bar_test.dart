import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:copilot/widgets/navigation_bar.dart';

void main() {
  group('CustomNavigationBar', () {
    late GlobalKey heroKey;
    late GlobalKey aboutKey;
    late GlobalKey skillsKey;
    late GlobalKey projectsKey;
    late GlobalKey contactKey;
    late Function(GlobalKey) mockOnNavigate;
    late List<GlobalKey> navigatedKeys;

    setUp(() {
      heroKey = GlobalKey();
      aboutKey = GlobalKey();
      skillsKey = GlobalKey();
      projectsKey = GlobalKey();
      contactKey = GlobalKey();
      navigatedKeys = [];
      mockOnNavigate = (GlobalKey key) {
        navigatedKeys.add(key);
      };
    });

    Widget createTestWidget({Size screenSize = const Size(1200, 800)}) {
      return MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ResponsiveBreakpoints.builder(
                child: CustomNavigationBar(
                  onNavigate: mockOnNavigate,
                  heroKey: heroKey,
                  aboutKey: aboutKey,
                  skillsKey: skillsKey,
                  projectsKey: projectsKey,
                  contactKey: contactKey,
                ),
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                ],
              );
            },
          ),
        ),
      );
    }

    group('Desktop Layout', () {
      testWidgets('should display logo/name', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());

        expect(find.text('John Doe'), findsOneWidget);
      });

      testWidgets('should display all navigation items', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());

        expect(find.text('Home'), findsOneWidget);
        expect(find.text('About'), findsOneWidget);
        expect(find.text('Skills'), findsOneWidget);
        expect(find.text('Projects'), findsOneWidget);
        expect(find.text('Contact'), findsOneWidget);
      });

      testWidgets('should not display mobile menu icon', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.menu), findsNothing);
      });

      testWidgets('should call onNavigate when nav item is tapped', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.text('About'));
        await tester.pumpAndSettle();

        expect(navigatedKeys.length, equals(1));
        expect(navigatedKeys.first, equals(aboutKey));
      });
    });

    group('Mobile Layout', () {
      testWidgets('should display logo/name', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());

        expect(find.text('John Doe'), findsOneWidget);
      });

      testWidgets('should display mobile menu icon', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.menu), findsOneWidget);
      });

      testWidgets('should not display navigation items directly', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());

        // Navigation items should not be visible directly in mobile layout
        expect(find.text('Home'), findsNothing);
        expect(find.text('About'), findsNothing);
        expect(find.text('Skills'), findsNothing);
        expect(find.text('Projects'), findsNothing);
        expect(find.text('Contact'), findsNothing);
      });

      testWidgets('should show mobile menu when menu icon is tapped', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());

        // Tap the menu icon
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        // Verify bottom sheet with navigation items appears
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('About'), findsOneWidget);
        expect(find.text('Skills'), findsOneWidget);
        expect(find.text('Projects'), findsOneWidget);
        expect(find.text('Contact'), findsOneWidget);
      });

      testWidgets('should navigate when mobile menu item is tapped', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(createTestWidget());

        // Open mobile menu
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        // Tap a navigation item in the mobile menu
        await tester.tap(find.text('Skills'));
        await tester.pumpAndSettle();

        expect(navigatedKeys.length, equals(1));
        expect(navigatedKeys.first, equals(skillsKey));
      });
    });

    group('Scroll Behavior', () {
      testWidgets('should change appearance when scrolled', (WidgetTester tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 800));
        
        // Create a scrollable widget with navigation bar
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ResponsiveBreakpoints.builder(
              child: Column(
                children: [
                  CustomNavigationBar(
                    onNavigate: mockOnNavigate,
                    heroKey: heroKey,
                    aboutKey: aboutKey,
                    skillsKey: skillsKey,
                    projectsKey: projectsKey,
                    contactKey: contactKey,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height: 2000, // Make it scrollable
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              ],
            ),
          ),
        ));

        // Initial state - transparent background
        Container navContainer = tester.widget(find.byType(AnimatedContainer).first);
        BoxDecoration? decoration = navContainer.decoration as BoxDecoration?;
        expect(decoration?.color, equals(Colors.transparent));

        // Scroll down to trigger scroll behavior
        await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -200));
        await tester.pumpAndSettle();

        // Should now have white background with opacity
        navContainer = tester.widget(find.byType(AnimatedContainer).first);
        decoration = navContainer.decoration as BoxDecoration?;
        expect(decoration?.color, isNot(equals(Colors.transparent)));
      });
    });
  });
}