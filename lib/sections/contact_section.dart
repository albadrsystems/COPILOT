import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: isDesktop ? 100 : 60,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Get In Touch',
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 48 : 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Ready to start your next project? Let\'s work together!',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          ResponsiveRowColumn(
            layout: isDesktop 
                ? ResponsiveRowColumnType.ROW 
                : ResponsiveRowColumnType.COLUMN,
            rowSpacing: 60,
            columnSpacing: 40,
            children: [
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _buildContactInfo(isDesktop),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _buildContactForm(isDesktop),
              ),
            ],
          ),
          const SizedBox(height: 60),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildContactInfo(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let\'s Start a Conversation',
          style: GoogleFonts.poppins(
            fontSize: isDesktop ? 32 : 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'I\'m always interested in new opportunities and exciting projects. Whether you have a project in mind or just want to say hello, feel free to reach out!',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 30),
        _buildContactItem(
          FontAwesomeIcons.envelope,
          'Email',
          'john.doe@example.com',
          'mailto:john.doe@example.com',
        ),
        const SizedBox(height: 20),
        _buildContactItem(
          FontAwesomeIcons.phone,
          'Phone',
          '+1 (555) 123-4567',
          'tel:+15551234567',
        ),
        const SizedBox(height: 20),
        _buildContactItem(
          FontAwesomeIcons.locationDot,
          'Location',
          'San Francisco, CA',
          null,
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            _buildSocialIcon(FontAwesomeIcons.github, 'https://github.com'),
            const SizedBox(width: 15),
            _buildSocialIcon(FontAwesomeIcons.linkedin, 'https://linkedin.com'),
            const SizedBox(width: 15),
            _buildSocialIcon(FontAwesomeIcons.twitter, 'https://twitter.com'),
            const SizedBox(width: 15),
            _buildSocialIcon(FontAwesomeIcons.instagram, 'https://instagram.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value, String? url) {
    return GestureDetector(
      onTap: url != null ? () => _launchUrl(url) : null,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(22.5),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildContactForm(bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField(
              controller: _nameController,
              label: 'Your Name',
              icon: FontAwesomeIcons.user,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              icon: FontAwesomeIcons.envelope,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _messageController,
              label: 'Your Message',
              icon: FontAwesomeIcons.message,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                if (value.length < 10) {
                  return 'Message should be at least 10 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF667eea),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Send Message',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          color: Colors.white.withOpacity(0.7),
          fontSize: 14,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        errorStyle: GoogleFonts.poppins(
          color: Colors.red[300],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.white.withOpacity(0.2),
        ),
        const SizedBox(height: 30),
        Text(
          '© 2025 John Doe. All rights reserved.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Built with Flutter & ❤️',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        _isLoading = true;
      });

      // Simulate form submission
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Message sent successfully! I\'ll get back to you soon.',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
