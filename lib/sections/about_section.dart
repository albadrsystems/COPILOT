import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: isDesktop ? 100 : 60,
      ),
      color: Colors.grey[50],
      child: Column(
        children: [
          Text(
            'About Me',
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
                child: _buildBiographySection(isDesktop),
              ),
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: _buildSkillsSection(isDesktop),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBiographySection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who I Am',
          style: GoogleFonts.poppins(
            fontSize: isDesktop ? 32 : 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'I\'m a passionate Flutter developer with 3+ years of experience creating beautiful, performant mobile applications. I specialize in cross-platform development and have a keen eye for UI/UX design.',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[700],
            height: 1.8,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'My journey in software development started with a curiosity about how mobile apps work. This curiosity led me to dive deep into Flutter, and I haven\'t looked back since. I love the challenge of turning complex problems into simple, elegant solutions.',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[700],
            height: 1.8,
          ),
        ),
        const SizedBox(height: 30),
        _buildStatsRow(isDesktop),
      ],
    );
  }

  Widget _buildStatsRow(bool isDesktop) {
    return ResponsiveRowColumn(
      layout: isDesktop 
          ? ResponsiveRowColumnType.ROW 
          : ResponsiveRowColumnType.COLUMN,
      rowSpacing: 40,
      columnSpacing: 20,
      children: [
        ResponsiveRowColumnItem(
          child: _buildStatItem('3+', 'Years Experience'),
        ),
        ResponsiveRowColumnItem(
          child: _buildStatItem('50+', 'Projects Completed'),
        ),
        ResponsiveRowColumnItem(
          child: _buildStatItem('20+', 'Happy Clients'),
        ),
      ],
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF6366F1),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Skills',
          style: GoogleFonts.poppins(
            fontSize: isDesktop ? 32 : 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 30),
        _buildSkillCategory('Frontend Development', [
          SkillItem('Flutter', 0.9, FontAwesomeIcons.mobile),
          SkillItem('Dart', 0.9, FontAwesomeIcons.code),
          SkillItem('React', 0.7, FontAwesomeIcons.react),
          SkillItem('JavaScript', 0.8, FontAwesomeIcons.js),
        ]),
        const SizedBox(height: 30),
        _buildSkillCategory('Backend & Tools', [
          SkillItem('Firebase', 0.8, FontAwesomeIcons.fire),
          SkillItem('Node.js', 0.7, FontAwesomeIcons.nodeJs),
          SkillItem('Git', 0.9, FontAwesomeIcons.git),
          SkillItem('Figma', 0.8, FontAwesomeIcons.figma),
        ]),
      ],
    );
  }

  Widget _buildSkillCategory(String title, List<SkillItem> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        ...skills.map((skill) => _buildSkillBar(skill)),
      ],
    );
  }

  Widget _buildSkillBar(SkillItem skill) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    skill.icon,
                    size: 16,
                    color: const Color(0xFF6366F1),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    skill.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              Text(
                '${(skill.level * 100).round()}%',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6366F1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: skill.level,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(3),
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
