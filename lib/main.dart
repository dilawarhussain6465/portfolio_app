import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/skills_screen.dart';
import 'screens/contact_screen.dart';
import 'services/theme_service.dart';
import 'services/analytics_service.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization failed: $e');
  }
  
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  
  runApp(PortfolioApp(initialThemeMode: isDarkMode));
}

class PortfolioApp extends StatefulWidget {
  final bool initialThemeMode;
  
  const PortfolioApp({Key? key, required this.initialThemeMode}) : super(key: key);

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  late ThemeService _themeService;
  late AnalyticsService _analyticsService;

  @override
  void initState() {
    super.initState();
    _themeService = ThemeService();
    _analyticsService = AnalyticsService();
    _themeService.initialize(widget.initialThemeMode);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeService,
      builder: (context, child) {
        return MaterialApp(
          title: 'Dilawar Hussain - Portfolio',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: MainScreen(
            themeService: _themeService,
            analyticsService: _analyticsService,
          ),
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  final ThemeService themeService;
  final AnalyticsService analyticsService;

  const MainScreen({
    Key? key,
    required this.themeService,
    required this.analyticsService,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeScreens();
  }

  void _initializeScreens() {
    _screens.addAll([
      HomeScreen(themeService: widget.themeService),
      AboutScreen(),
      ProjectsScreen(analyticsService: widget.analyticsService),
      SkillsScreen(),
      ContactScreen(),
    ]);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    
    widget.analyticsService.logScreenView(_getScreenName(index));
  }

  String _getScreenName(int index) {
    switch (index) {
      case 0: return 'Home';
      case 1: return 'About';
      case 2: return 'Projects';
      case 3: return 'Skills';
      case 4: return 'Contact';
      default: return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      body: Row(
        children: [
          if (isWideScreen) _buildSidebar(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: _screens,
            ),
          ),
        ],
      ),
      bottomNavigationBar: isWideScreen ? null : _buildBottomNavigation(),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildNavigation()),
          _buildThemeToggle(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              'DH',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Dilawar Hussain',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Senior Software Engineer',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigation() {
    final navItems = [
      {'icon': Icons.home_outlined, 'label': 'Home', 'index': 0},
      {'icon': Icons.person_outline, 'label': 'About', 'index': 1},
      {'icon': Icons.work_outline, 'label': 'Projects', 'index': 2},
      {'icon': Icons.code, 'label': 'Skills', 'index': 3},
      {'icon': Icons.contact_mail_outlined, 'label': 'Contact', 'index': 4},
    ];

    return ListView.builder(
      itemCount: navItems.length,
      itemBuilder: (context, index) {
        final item = navItems[index];
        final isSelected = _currentIndex == item['index'];
        
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: Icon(
              item['icon'] as IconData,
              color: isSelected 
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            title: Text(
              item['label'] as String,
              style: GoogleFonts.poppins(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected 
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            selected: isSelected,
            selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () => _onTabTapped(item['index'] as int),
          ),
        );
      },
    );
  }

  Widget _buildThemeToggle() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListTile(
        leading: Icon(
          widget.themeService.isDarkMode ? Icons.dark_mode : Icons.light_mode,
        ),
        title: Text(
          widget.themeService.isDarkMode ? 'Dark Mode' : 'Light Mode',
          style: GoogleFonts.poppins(),
        ),
        trailing: Switch(
          value: widget.themeService.isDarkMode,
          onChanged: (value) {
            widget.themeService.toggleTheme();
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTabTapped,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'About',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work_outline),
          activeIcon: Icon(Icons.work),
          label: 'Projects',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.code),
          label: 'Skills',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_mail_outlined),
          activeIcon: Icon(Icons.contact_mail),
          label: 'Contact',
        ),
      ],
    );
  }
}