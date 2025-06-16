import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Test utilities for the Portfolio app.
/// 
/// This file contains helper functions and utilities to make testing easier
/// and more consistent across test files.
class TestUtils {
  /// Standard breakpoints used across the app
  static const List<Breakpoint> breakpoints = [
    Breakpoint(start: 0, end: 450, name: MOBILE),
    Breakpoint(start: 451, end: 800, name: TABLET),
    Breakpoint(start: 801, end: 1920, name: DESKTOP),
    Breakpoint(start: 1921, end: double.infinity, name: '4K'),
  ];

  /// Creates a basic MaterialApp wrapper for testing widgets
  static Widget createBasicTestApp(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: ResponsiveBreakpoints.builder(
          child: child,
          breakpoints: breakpoints,
        ),
      ),
    );
  }

  /// Creates a test app with proper theming matching the main app
  static Widget createThemedTestApp(Widget child) {
    return MaterialApp(
      title: 'Test Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: ResponsiveBreakpoints.builder(
          child: child,
          breakpoints: breakpoints,
        ),
      ),
    );
  }

  /// Sets mobile screen size for testing
  static Future<void> setMobileSize(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 800));
  }

  /// Sets tablet screen size for testing
  static Future<void> setTabletSize(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(700, 800));
  }

  /// Sets desktop screen size for testing
  static Future<void> setDesktopSize(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 800));
  }

  /// Sets large desktop screen size for testing
  static Future<void> setLargeDesktopSize(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1920, 1080));
  }

  /// Helper to find TextFormField by its label
  static Finder findTextFormFieldByLabel(String label) {
    return find.ancestor(
      of: find.text(label),
      matching: find.byType(TextFormField),
    );
  }

  /// Helper to enter text in a form field by its label
  static Future<void> enterTextInFormField(
    WidgetTester tester,
    String label,
    String text,
  ) async {
    final field = findTextFormFieldByLabel(label);
    await tester.enterText(field, text);
  }

  /// Helper to verify form validation errors
  static void expectValidationError(String errorMessage) {
    expect(find.text(errorMessage), findsOneWidget);
  }

  /// Helper to verify no validation errors
  static void expectNoValidationError(String errorMessage) {
    expect(find.text(errorMessage), findsNothing);
  }

  /// Helper to fill out contact form with valid data
  static Future<void> fillContactFormValid(WidgetTester tester) async {
    await enterTextInFormField(tester, 'Your Name', 'Test User');
    await enterTextInFormField(tester, 'Email Address', 'test@example.com');
    await enterTextInFormField(
      tester,
      'Your Message',
      'This is a valid test message with enough characters',
    );
  }

  /// Helper to submit contact form
  static Future<void> submitContactForm(WidgetTester tester) async {
    await tester.tap(find.text('Send Message'));
    await tester.pump();
  }

  /// Helper to wait for async operations to complete
  static Future<void> waitForAsyncOperations(WidgetTester tester, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    await tester.pumpAndSettle(timeout);
  }

  /// Helper to simulate scrolling
  static Future<void> scrollDown(WidgetTester tester, {double offset = -300}) async {
    await tester.drag(find.byType(SingleChildScrollView), Offset(0, offset));
    await tester.pumpAndSettle();
  }

  /// Helper to verify navigation items are present (desktop)
  static void expectDesktopNavigation() {
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    expect(find.text('Skills'), findsOneWidget);
    expect(find.text('Projects'), findsOneWidget);
    expect(find.text('Contact'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsNothing);
  }

  /// Helper to verify mobile navigation
  static void expectMobileNavigation() {
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.text('Home'), findsNothing);
    expect(find.text('About'), findsNothing);
    expect(find.text('Skills'), findsNothing);
    expect(find.text('Projects'), findsNothing);
    expect(find.text('Contact'), findsNothing);
  }

  /// Helper to open mobile menu
  static Future<void> openMobileMenu(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
  }

  /// Helper to navigate using desktop navigation
  static Future<void> navigateToSection(WidgetTester tester, String sectionName) async {
    await tester.tap(find.text(sectionName));
    await tester.pumpAndSettle();
  }

  /// Helper to navigate using mobile navigation
  static Future<void> navigateToSectionMobile(WidgetTester tester, String sectionName) async {
    await openMobileMenu(tester);
    await tester.tap(find.text(sectionName));
    await tester.pumpAndSettle();
  }

  /// Helper to verify all main sections are present
  static void expectAllSectionsPresent() {
    expect(find.text('Hello, I\'m'), findsOneWidget);
    expect(find.text('About Me'), findsOneWidget);
    expect(find.text('Let\'s Start a Conversation'), findsOneWidget);
  }

  /// Helper to verify theme colors
  static void verifyThemeColor(WidgetTester tester, Color expectedColor) {
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.theme?.colorScheme.primary, equals(expectedColor));
  }

  /// Helper to find widgets by accessibility semantics
  static Finder findBySemantics(String semanticsLabel) {
    return find.bySemanticsLabel(semanticsLabel);
  }

  /// Helper to verify loading state
  static void expectLoadingState() {
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  }

  /// Helper to verify success message
  static void expectSuccessMessage(String message) {
    expect(find.text(message), findsOneWidget);
  }

  /// Helper to verify error message
  static void expectErrorMessage(String message) {
    expect(find.text(message), findsOneWidget);
  }
}

/// Common test data for use across tests
class TestData {
  static const String validName = 'John Test';
  static const String validEmail = 'john.test@example.com';
  static const String validMessage = 'This is a test message with sufficient length for validation';
  
  static const String invalidEmail = 'invalid-email';
  static const String shortMessage = 'Short';
  
  static const String successMessage = 'Message sent successfully! I\'ll get back to you soon.';
  
  static const String nameValidationError = 'Please enter your name';
  static const String emailValidationError = 'Please enter your email';
  static const String emailFormatError = 'Please enter a valid email';
  static const String messageValidationError = 'Please enter your message';
  static const String messageLengthError = 'Message should be at least 10 characters';
}

/// Matcher for checking responsive behavior
class ResponsiveMatcher extends Matcher {
  final String breakpointName;
  
  const ResponsiveMatcher(this.breakpointName);
  
  @override
  bool matches(dynamic item, Map matchState) {
    if (item is! BuildContext) return false;
    
    final breakpoint = ResponsiveBreakpoints.of(item).breakpoint.name;
    return breakpoint == breakpointName;
  }
  
  @override
  Description describe(Description description) {
    return description.add('matches responsive breakpoint: $breakpointName');
  }
}

/// Custom matchers for testing
Matcher isMobileBreakpoint() => const ResponsiveMatcher(MOBILE);
Matcher isTabletBreakpoint() => const ResponsiveMatcher(TABLET);
Matcher isDesktopBreakpoint() => const ResponsiveMatcher(DESKTOP);