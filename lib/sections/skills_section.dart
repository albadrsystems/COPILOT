import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: isDesktop ? 100 : 60,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'My Skills',
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 48 : 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Here are the technologies and tools I work with',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[600],
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
                child: _buildSkillCategory('Frontend Development', [
                  SkillItem('Flutter', 0.9, FontAwesomeIcons.mobile),
                  SkillItem('Dart', 0.9, FontAwesomeIcons.code),
                  SkillItem('React', 0.7, FontAwesomeIcons.react),
                  SkillItem('JavaScript', 0.8, FontAwesomeIcons.js),
                  SkillItem('HTML/CSS', 0.8, FontAwesomeIcons.html5),
                ]),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _buildSkillCategory('Backend & Tools', [
                  SkillItem('Firebase', 0.8, FontAwesomeIcons.fire),
                  SkillItem('Node.js', 0.7, FontAwesomeIcons.nodeJs),
                  SkillItem('Git', 0.9, FontAwesomeIcons.git),
                  SkillItem('Figma', 0.8, FontAwesomeIcons.figma),
                  SkillItem('Docker', 0.6, FontAwesomeIcons.docker),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(String title, List<SkillItem> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 25),
        ...skills.map((skill) => _buildSkillBar(skill)),
      ],
    );
  }

  Widget _buildSkillBar(SkillItem skill) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    skill.icon,
                    size: 18,
                    color: const Color(0xFF6366F1),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    skill.name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              Text(
                '${(skill.level * 100).round()}%',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6366F1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: skill.level,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillItem {
  final String name;
  final double level;
  final IconData icon;

  SkillItem(this.name, this.level, this.icon);
}