import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isWideScreen = screenSize.width > 768;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, isWideScreen),
            const SizedBox(height: 32),
            _buildTechnicalSkills(context, isWideScreen),
            const SizedBox(height: 32),
            _buildSoftSkills(context, isWideScreen),
            const SizedBox(height: 32),
            _buildToolsAndFrameworks(context, isWideScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isWideScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Skills',
          style: GoogleFonts.poppins(
            fontSize: isWideScreen ? 36 : 28,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
        
        const SizedBox(height: 8),
        
        Text(
          'Technical expertise and soft skills that drive my development process',
          style: GoogleFonts.poppins(
            fontSize: isWideScreen ? 18 : 16,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.2),
      ],
    );
  }

  Widget _buildTechnicalSkills(BuildContext context, bool isWideScreen) {
    final technicalSkills = [
      {'name': 'C#', 'level': 0.95, 'years': '4+'},
      {'name': 'Unity 3D/2D', 'level': 0.90, 'years': '4+'},
      {'name': 'Game Development', 'level': 0.92, 'years': '4+'},
      {'name': 'Photon Networking', 'level': 0.85, 'years': '3+'},
      {'name': 'Firebase', 'level': 0.80, 'years': '3+'},
      {'name': 'AR/VR Development', 'level': 0.75, 'years': '2+'},
      {'name': 'Mobile Development', 'level': 0.88, 'years': '4+'},
      {'name': 'Performance Optimization', 'level': 0.82, 'years': '3+'},
    ];

    return _buildSkillSection(
      context,
      'Technical Skills',
      technicalSkills,
      isWideScreen,
      400,
    );
  }

  Widget _buildSoftSkills(BuildContext context, bool isWideScreen) {
    final softSkills = [
      {'name': 'Problem Solving', 'level': 0.95},
      {'name': 'Team Collaboration', 'level': 0.90},
      {'name': 'Project Management', 'level': 0.85},
      {'name': 'Communication', 'level': 0.88},
      {'name': 'Leadership', 'level': 0.80},
      {'name': 'Creativity', 'level': 0.92},
      {'name': 'Adaptability', 'level': 0.87},
      {'name': 'Time Management', 'level': 0.84},
    ];

    return _buildSkillSection(
      context,
      'Soft Skills',
      softSkills,
      isWideScreen,
      800,
    );
  }

  Widget _buildToolsAndFrameworks(BuildContext context, bool isWideScreen) {
    final tools = [
      {'name': 'Visual Studio', 'category': 'IDE'},
      {'name': 'Git/GitHub', 'category': 'Version Control'},
      {'name': 'Photoshop', 'category': 'Graphics'},
      {'name': 'Blender', 'category': '3D Modeling'},
      {'name': 'Android Studio', 'category': 'Mobile'},
      {'name': 'Xcode', 'category': 'Mobile'},
      {'name': 'Jira', 'category': 'Project Management'},
      {'name': 'Slack', 'category': 'Communication'},
      {'name': 'Unity Analytics', 'category': 'Analytics'},
      {'name': 'PlayFab', 'category': 'Backend'},
      {'name': 'Google Play Console', 'category': 'Publishing'},
      {'name': 'App Store Connect', 'category': 'Publishing'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tools & Frameworks',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(delay: 1200.ms).slideX(begin: -0.2),
        
        const SizedBox(height: 24),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isWideScreen ? 4 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isWideScreen ? 2.5 : 2,
          ),
          itemCount: tools.length,
          itemBuilder: (context, index) {
            final tool = tools[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tool['name'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tool['category'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: (1400 + index * 100).ms).scale(begin: const Offset(0.8, 0.8));
          },
        ),
      ],
    );
  }

  Widget _buildSkillSection(
    BuildContext context,
    String title,
    List<Map<String, dynamic>> skills,
    bool isWideScreen,
    int baseDelay,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(delay: baseDelay.ms).slideX(begin: -0.2),
        
        const SizedBox(height: 24),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isWideScreen ? 2 : 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isWideScreen ? 4 : 6,
          ),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            final skill = skills[index];
            return _buildSkillItem(context, skill, baseDelay + (index * 100));
          },
        ),
      ],
    );
  }

  Widget _buildSkillItem(BuildContext context, Map<String, dynamic> skill, int delay) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    skill['name'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (skill.containsKey('years'))
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      skill['years'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            LinearProgressIndicator(
              value: skill['level'] as double,
              backgroundColor: Theme.of(context).colorScheme.surface,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              '${((skill['level'] as double) * 100).toInt()}%',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: -0.2);
  }
}