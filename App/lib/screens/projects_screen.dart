import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';
import '../services/analytics_service.dart';
import '../data/projects_data.dart';

class ProjectsScreen extends StatefulWidget {
  final AnalyticsService analyticsService;

  const ProjectsScreen({Key? key, required this.analyticsService}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _selectedCategory = 'All';
  List<Project> _projects = [];
  List<Project> _filteredProjects = [];

  final List<String> _categories = [
    'All',
    'Client Projects',
    'Products',
    'Multiplayer',
    '2D',
    '3D',
  ];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  void _loadProjects() {
    _projects = ProjectsData.getAllProjects();
    _filterProjects();
  }

  void _filterProjects() {
    setState(() {
      if (_selectedCategory == 'All') {
        _filteredProjects = _projects;
      } else {
        _filteredProjects = _projects
            .where((project) => project.category == _selectedCategory)
            .toList();
      }
    });
  }

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
            _buildCategoryFilter(context, isWideScreen),
            const SizedBox(height: 32),
            _buildProjectsGrid(context, isWideScreen),
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
          'My Projects',
          style: GoogleFonts.poppins(
            fontSize: isWideScreen ? 36 : 28,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
        
        const SizedBox(height: 8),
        
        Text(
          'Explore my portfolio of games and applications built with Unity',
          style: GoogleFonts.poppins(
            fontSize: isWideScreen ? 18 : 16,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.2),
      ],
    );
  }

  Widget _buildCategoryFilter(BuildContext context, bool isWideScreen) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(
                category,
                style: GoogleFonts.poppins(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
                _filterProjects();
                widget.analyticsService.logEvent('category_filter', {
                  'category': category,
                });
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              checkmarkColor: Theme.of(context).colorScheme.primary,
            ),
          ).animate().fadeIn(delay: (400 + index * 100).ms).scale(begin: const Offset(0.8, 0.8));
        },
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, bool isWideScreen) {
    if (_filteredProjects.isEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No projects found in this category',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isWideScreen ? 2 : 1,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: isWideScreen ? 1.3 : 1.1,
      ),
      itemCount: _filteredProjects.length,
      itemBuilder: (context, index) {
        final project = _filteredProjects[index];
        return _buildProjectCard(context, project, index);
      },
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project, int index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  if (project.imageUrl.isNotEmpty)
                    Image.network(
                      project.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderImage(context, project);
                      },
                    )
                  else
                    _buildPlaceholderImage(context, project),
                  
                  if (project.isFeatured)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Featured',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    project.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: project.technologies.take(3).map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tech,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const Spacer(),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildProjectLinks(context, project),
                      IconButton(
                        onPressed: () => _showProjectDetails(context, project),
                        icon: const Icon(Icons.info_outline),
                        tooltip: 'View Details',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (600 + index * 200).ms).slideY(begin: 0.2);
  }

  Widget _buildPlaceholderImage(BuildContext context, Project project) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.games,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 8),
          Text(
            project.title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProjectLinks(BuildContext context, Project project) {
    final links = <Widget>[];
    
    if (project.playStoreUrl != null) {
      links.add(_buildLinkButton(
        context,
        Icons.shop,
        'Play Store',
        () => _launchUrl(project.playStoreUrl!, 'play_store'),
      ));
    }
    
    if (project.appStoreUrl != null) {
      links.add(_buildLinkButton(
        context,
        Icons.apple,
        'App Store',
        () => _launchUrl(project.appStoreUrl!, 'app_store'),
      ));
    }
    
    if (project.webUrl != null) {
      links.add(_buildLinkButton(
        context,
        Icons.web,
        'Web',
        () => _launchUrl(project.webUrl!, 'web'),
      ));
    }
    
    if (project.videoUrl != null) {
      links.add(_buildLinkButton(
        context,
        Icons.play_circle_outline,
        'Video',
        () => _launchUrl(project.videoUrl!, 'video'),
      ));
    }

    return Row(
      children: links.take(2).toList(),
    );
  }

  Widget _buildLinkButton(
    BuildContext context,
    IconData icon,
    String tooltip,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        tooltip: tooltip,
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  void _showProjectDetails(BuildContext context, Project project) {
    widget.analyticsService.logProjectView(project.title);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          project.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                project.description,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Text(
                'Technologies:',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: project.technologies.map((tech) {
                  return Chip(
                    label: Text(
                      tech,
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Text(
                'Release Date: ${_formatDate(project.releaseDate)}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.year}';
  }

  Future<void> _launchUrl(String url, String linkType) async {
    widget.analyticsService.logExternalLink(linkType, url);
    
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}