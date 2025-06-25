import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

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
            _buildAboutContent(context, isWideScreen),
            const SizedBox(height: 32),
            _buildExperience(context, isWideScreen),
            const SizedBox(height: 32),
            _buildAchievements(context, isWideScreen),
            const SizedBox(height: 32),
            _buildContactInfo(context, isWideScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isWideScreen) {
    return Row(
      children: [
        CircleAvatar(
          radius: isWideScreen ? 80 : 60,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            'DH',
            style: GoogleFonts.poppins(
              fontSize: isWideScreen ? 48 : 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ).animate().scale(duration: 800.ms),
        
        const SizedBox(width: 24),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Me',
                style: GoogleFonts.poppins(
                  fontSize: isWideScreen ? 36 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
              
              const SizedBox(height: 8),
              
              Text(
                'Senior Software Engineer & Game Developer',
                style: GoogleFonts.poppins(
                  fontSize: isWideScreen ? 20 : 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context, bool isWideScreen) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Journey',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'With over 4 years of experience in software engineering and game development, I specialize in creating immersive gaming experiences using Unity. My expertise spans across mobile game development, multiplayer systems, AR/VR implementations, and performance optimization.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                height: 1.6,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'I\'m passionate about pushing the boundaries of what\'s possible in game development, always staying updated with the latest technologies and best practices. My goal is to create games that not only entertain but also provide meaningful experiences to players.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                height: 1.6,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2);
  }

  Widget _buildExperience(BuildContext context, bool isWideScreen) {
    final experiences = [
      {
        'title': 'Senior Game Developer',
        'company': 'Freelance',
        'period': '2021 - Present',
        'description': 'Developing mobile games using Unity, implementing multiplayer features with Photon, and optimizing performance for various platforms.',
      },
      {
        'title': 'Unity Developer',
        'company': 'Game Studio',
        'period': '2020 - 2021',
        'description': 'Created 2D and 3D games, integrated Firebase services, and collaborated with design teams to implement game mechanics.',
      },
      {
        'title': 'Software Engineer',
        'company': 'Tech Company',
        'period': '2019 - 2020',
        'description': 'Developed cross-platform applications and gained expertise in software architecture and development best practices.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        ...experiences.asMap().entries.map((entry) {
          final index = entry.key;
          final exp = entry.value;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 24),
            child: Card(
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
                            exp['title'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            exp['period'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exp['company'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      exp['description'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        height: 1.5,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(delay: (800 + index * 200).ms).slideX(begin: -0.2);
        }).toList(),
      ],
    );
  }

  Widget _buildAchievements(BuildContext context, bool isWideScreen) {
    final achievements = [
      {
        'icon': Icons.emoji_events,
        'title': 'Kenney Game Jam 2023',
        'description': 'Participated in global game jam competition',
      },
      {
        'icon': Icons.star,
        'title': 'Performance Recognition',
        'description': 'Received performance-based rewards for outstanding work',
      },
      {
        'icon': Icons.games,
        'title': 'Published Games',
        'description': 'Successfully launched multiple games on app stores',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isWideScreen ? 3 : 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isWideScreen ? 1.2 : 3,
          ),
          itemCount: achievements.length,
          itemBuilder: (context, index) {
            final achievement = achievements[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      achievement['icon'] as IconData,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      achievement['title'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      achievement['description'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: (1200 + index * 200).ms).scale(begin: const Offset(0.8, 0.8));
          },
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context, bool isWideScreen) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get In Touch',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildContactItem(
              context,
              Icons.email,
              'Email',
              'dilawarhussain6465@gmail.com',
              () => _launchUrl('mailto:dilawarhussain6465@gmail.com'),
            ),
            const SizedBox(height: 12),
            _buildContactItem(
              context,
              Icons.phone,
              'Phone',
              '+923484947995',
              () => _launchUrl('tel:+923484947995'),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 1600.ms).slideY(begin: 0.2);
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}