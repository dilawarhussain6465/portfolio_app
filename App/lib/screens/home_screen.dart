import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/theme_service.dart';

class HomeScreen extends StatelessWidget {
  final ThemeService themeService;

  const HomeScreen({Key? key, required this.themeService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isWideScreen = screenSize.width > 768;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
                Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              ],
            ),
          ),
          child: Column(
            children: [
              _buildHeroSection(context, isWideScreen),
              _buildFeaturesSection(context, isWideScreen),
              _buildCallToActionSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isWideScreen) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Flex(
        direction: isWideScreen ? Axis.horizontal : Axis.vertical,
        children: [
          Expanded(
            flex: isWideScreen ? 3 : 1,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, I\'m',
                    style: GoogleFonts.poppins(
                      fontSize: isWideScreen ? 24 : 20,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Dilawar Hussain',
                    style: GoogleFonts.poppins(
                      fontSize: isWideScreen ? 48 : 36,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.2),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'Senior Software Engineer',
                    style: GoogleFonts.poppins(
                      fontSize: isWideScreen ? 28 : 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideX(begin: -0.2),
                  
                  const SizedBox(height: 24),
                  
                  Text(
                    'Passionate Unity game developer with 4+ years of experience creating immersive gaming experiences. Specializing in multiplayer games, AR/VR development, and performance optimization.',
                    style: GoogleFonts.poppins(
                      fontSize: isWideScreen ? 18 : 16,
                      height: 1.6,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ).animate().fadeIn(delay: 600.ms, duration: 600.ms).slideY(begin: 0.2),
                  
                  const SizedBox(height: 32),
                  
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to projects
                        },
                        icon: const Icon(Icons.work_outline),
                        label: const Text('Explore Portfolio'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                      ).animate().fadeIn(delay: 800.ms, duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
                      
                      const SizedBox(width: 16),
                      
                      OutlinedButton.icon(
                        onPressed: () {
                          // Navigate to contact
                        },
                        icon: const Icon(Icons.contact_mail_outlined),
                        label: const Text('Contact Me'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                      ).animate().fadeIn(delay: 1000.ms, duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          if (isWideScreen)
            Expanded(
              flex: 2,
              child: Container(
                child: _buildAnimatedBackground(context),
              ).animate().fadeIn(delay: 1200.ms, duration: 800.ms),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated circles
          ...List.generate(5, (index) {
            return Positioned(
              left: (index * 50.0) % 200,
              top: (index * 80.0) % 300,
              child: Container(
                width: 60 + (index * 20.0),
                height: 60 + (index * 20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                .scale(duration: (2000 + index * 500).ms)
                .fade(duration: (1500 + index * 300).ms),
            );
          }),
          
          // Central icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            child: const Icon(
              Icons.games,
              size: 60,
              color: Colors.white,
            ),
          ).animate(onPlay: (controller) => controller.repeat())
            .rotate(duration: 10000.ms),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context, bool isWideScreen) {
    final features = [
      {
        'icon': Icons.games_outlined,
        'title': 'Game Development',
        'description': 'Expert in Unity 3D/2D game development with multiplayer capabilities',
      },
      {
        'icon': Icons.phone_android,
        'title': 'Cross-Platform',
        'description': 'Mobile games for iOS and Android with optimal performance',
      },
      {
        'icon': Icons.code,
        'title': 'Clean Code',
        'description': 'Well-structured, maintainable code following best practices',
      },
      {
        'icon': Icons.speed,
        'title': 'Performance',
        'description': 'Optimized games with smooth gameplay and efficient resource usage',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Text(
            'What I Do',
            style: GoogleFonts.poppins(
              fontSize: isWideScreen ? 36 : 28,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(duration: 600.ms),
          
          const SizedBox(height: 48),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isWideScreen ? 2 : 1,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isWideScreen ? 1.5 : 2.5,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        feature['icon'] as IconData,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        feature['title'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        feature['description'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: (index * 200).ms, duration: 600.ms)
                .slideY(begin: 0.2);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCallToActionSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32),
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Ready to Start Your Next Project?',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s discuss how I can help bring your game ideas to life',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to contact
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text('Get In Touch'),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2);
  }
}