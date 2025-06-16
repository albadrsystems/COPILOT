import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(GlobalKey) onNavigate;
  final GlobalKey heroKey;
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  const CustomNavigationBar({
    super.key,
    required this.onNavigate,
    required this.heroKey,
    required this.aboutKey,
    required this.projectsKey,
    required this.contactKey,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    // Listen to scroll events to change navbar appearance
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Scrollable.maybeOf(context) != null) {
        Scrollable.of(context).position.addListener(_onScroll);
      }
    });
  }

  void _onScroll() {
    final scrollOffset = Scrollable.of(context).position.pixels;
    final isScrolled = scrollOffset > 100;
    if (isScrolled != _isScrolled) {
      setState(() {
        _isScrolled = isScrolled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: _isScrolled 
            ? Colors.white.withOpacity(0.95)
            : Colors.transparent,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo/Name
          Text(
            'John Doe',
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: _isScrolled ? Colors.black87 : Colors.white,
            ),
          ),
          
          // Navigation Items
          if (isDesktop) ...[
            Row(
              children: [
                _buildNavItem('Home', widget.heroKey),
                const SizedBox(width: 30),
                _buildNavItem('About', widget.aboutKey),
                const SizedBox(width: 30),
                _buildNavItem('Projects', widget.projectsKey),
                const SizedBox(width: 30),
                _buildNavItem('Contact', widget.contactKey),
              ],
            ),
          ] else ...[
            IconButton(
              icon: Icon(
                Icons.menu,
                color: _isScrolled ? Colors.black87 : Colors.white,
              ),
              onPressed: () => _showMobileMenu(context),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, GlobalKey key) {
    return GestureDetector(
      onTap: () => widget.onNavigate(key),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: _isScrolled ? Colors.black87 : Colors.white,
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMobileNavItem('Home', widget.heroKey),
            _buildMobileNavItem('About', widget.aboutKey),
            _buildMobileNavItem('Projects', widget.projectsKey),
            _buildMobileNavItem('Contact', widget.contactKey),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(String title, GlobalKey key) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        widget.onNavigate(key);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (Scrollable.maybeOf(context) != null) {
      Scrollable.of(context).position.removeListener(_onScroll);
    }
    super.dispose();
  }
}
