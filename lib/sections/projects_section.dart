import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  ProjectsSection({super.key});

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
            'My Projects',
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
            'Here are some of my recent projects that showcase my skills and experience',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          ResponsiveGridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: ResponsiveGridDelegate(
              crossAxisExtent: isDesktop ? 400 : 350,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              childAspectRatio: 0.8,
            ),
            itemCount: _projects.length,
            itemBuilder: (context, index) {
              return _buildProjectCard(_projects[index], isDesktop);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(ProjectItem project, bool isDesktop) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: project.gradientColors,
              ),
            ),
            child: Center(
              child: Icon(
                project.icon,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
          
          // Project Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    project.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.6,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15),
                  
                  // Technologies
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.technologies.map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          tech,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF6366F1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const Spacer(),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _launchUrl(project.githubUrl),
                          icon: const Icon(
                            FontAwesomeIcons.github,
                            size: 16,
                          ),
                          label: const Text('Code'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey[700],
                            side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl(project.liveUrl),
                          icon: const Icon(
                            FontAwesomeIcons.externalLink,
                            size: 16,
                          ),
                          label: const Text('Live'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6366F1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  final List<ProjectItem> _projects = [
    ProjectItem(
      title: 'E-Commerce Mobile App',
      description: 'A fully functional e-commerce mobile application built with Flutter, featuring user authentication, product catalog, shopping cart, and payment integration.',
      technologies: ['Flutter', 'Firebase', 'Stripe', 'Provider'],
      githubUrl: 'https://github.com/johndoe/ecommerce-app',
      liveUrl: 'https://play.google.com/store/apps/details?id=com.example.ecommerce',
      icon: FontAwesomeIcons.shoppingCart,
      gradientColors: [
        Color(0xFF667eea),
        Color(0xFF764ba2),
      ],
    ),
    ProjectItem(
      title: 'Weather Forecast App',
      description: 'A beautiful weather application that provides real-time weather information and forecasts using OpenWeatherMap API with stunning animations.',
      technologies: ['Flutter', 'REST API', 'BLoC', 'Animations'],
      githubUrl: 'https://github.com/johndoe/weather-app',
      liveUrl: 'https://weather-app-demo.netlify.app',
      icon: FontAwesomeIcons.cloudSun,
      gradientColors: [
        Color(0xFF4facfe),
        Color(0xFF00f2fe),
      ],
    ),
    ProjectItem(
      title: 'Task Management System',
      description: 'A comprehensive task management application with team collaboration features, real-time updates, and productivity analytics.',
      technologies: ['Flutter', 'Node.js', 'MongoDB', 'Socket.io'],
      githubUrl: 'https://github.com/johndoe/task-manager',
      liveUrl: 'https://taskmanager-demo.herokuapp.com',
      icon: FontAwesomeIcons.tasks,
      gradientColors: [
        Color(0xFF43e97b),
        Color(0xFF38f9d7),
      ],
    ),
    ProjectItem(
      title: 'Fitness Tracking App',
      description: 'A comprehensive fitness application with workout tracking, nutrition monitoring, and social features to help users achieve their fitness goals.',
      technologies: ['Flutter', 'SQLite', 'Provider', 'Charts'],
      githubUrl: 'https://github.com/johndoe/fitness-tracker',
      liveUrl: 'https://fitness-tracker-demo.web.app',
      icon: FontAwesomeIcons.dumbbell,
      gradientColors: [
        Color(0xFFfa709a),
        Color(0xFFfee140),
      ],
    ),
    ProjectItem(
      title: 'Recipe Sharing Platform',
      description: 'A social platform for food enthusiasts to share recipes, rate dishes, and discover new culinary experiences with beautiful UI and smooth animations.',
      technologies: ['Flutter', 'Firebase', 'Cloud Storage', 'Riverpod'],
      githubUrl: 'https://github.com/johndoe/recipe-app',
      liveUrl: 'https://recipe-sharing-demo.web.app',
      icon: FontAwesomeIcons.utensils,
      gradientColors: [
        Color(0xFFf093fb),
        Color(0xFFf5576c),
      ],
    ),
    ProjectItem(
      title: 'Language Learning App',
      description: 'An interactive language learning application with gamification elements, progress tracking, and adaptive learning algorithms.',
      technologies: ['Flutter', 'AI/ML', 'Firebase', 'Gamification'],
      githubUrl: 'https://github.com/johndoe/language-app',
      liveUrl: 'https://language-learning-demo.web.app',
      icon: FontAwesomeIcons.graduationCap,
      gradientColors: [
        Color(0xFF4481eb),
        Color(0xFF04befe),
      ],
    ),
  ];
}

class ProjectItem {
  final String title;
  final String description;
  final List<String> technologies;
  final String githubUrl;
  final String liveUrl;
  final IconData icon;
  final List<Color> gradientColors;

  ProjectItem({
    required this.title,
    required this.description,
    required this.technologies,
    required this.githubUrl,
    required this.liveUrl,
    required this.icon,
    required this.gradientColors,
  });
}
