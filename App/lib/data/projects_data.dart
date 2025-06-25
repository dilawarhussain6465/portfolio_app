import '../models/project.dart';

class ProjectsData {
  static List<Project> getAllProjects() {
    return [
      Project(
        id: '1',
        title: 'Kream & Sugar',
        description: 'A delightful cooking and management game where players run their own bakery, creating delicious treats and managing customer orders.',
        imageUrl: 'https://images.pexels.com/photos/1126728/pexels-photo-1126728.jpeg',
        technologies: ['Unity', 'C#', 'Firebase', 'In-App Purchases'],
        category: 'Client Projects',
        playStoreUrl: 'https://play.google.com/store',
        appStoreUrl: 'https://apps.apple.com',
        isFeatured: true,
        releaseDate: DateTime(2023, 6),
      ),
      
      Project(
        id: '2',
        title: 'Batre Checkers',
        description: 'A modern take on the classic checkers game with online multiplayer, tournaments, and AI opponents of varying difficulty levels.',
        imageUrl: 'https://images.pexels.com/photos/260024/pexels-photo-260024.jpeg',
        technologies: ['Unity', 'C#', 'Photon', 'AI'],
        category: 'Multiplayer',
        webUrl: 'https://playbatre.com',
        videoUrl: 'https://drive.google.com/file/d/example',
        isFeatured: true,
        releaseDate: DateTime(2023, 8),
      ),
      
      Project(
        id: '3',
        title: 'PlayerSense',
        description: 'An analytics and player behavior tracking system for game developers to understand player engagement and optimize game mechanics.',
        imageUrl: 'https://images.pexels.com/photos/159888/pexels-photo-159888.jpeg',
        technologies: ['Unity', 'C#', 'Analytics', 'Big Data'],
        category: 'Products',
        webUrl: 'https://playersense.com',
        releaseDate: DateTime(2023, 4),
      ),
      
      Project(
        id: '4',
        title: 'Matty The Water Molecules',
        description: 'An educational 3D adventure game that teaches chemistry concepts through interactive gameplay and molecular exploration.',
        imageUrl: 'https://images.pexels.com/photos/2280549/pexels-photo-2280549.jpeg',
        technologies: ['Unity', 'C#', '3D Graphics', 'Educational'],
        category: '3D',
        webUrl: 'https://itch.io/matty-water-molecules',
        videoUrl: 'https://drive.google.com/file/d/example',
        isFeatured: true,
        releaseDate: DateTime(2023, 2),
      ),
      
      Project(
        id: '5',
        title: 'Zombie Survival Arena',
        description: 'Fast-paced zombie survival game with procedurally generated levels, weapon crafting, and intense combat mechanics.',
        imageUrl: 'https://images.pexels.com/photos/2193291/pexels-photo-2193291.jpeg',
        technologies: ['Unity', 'C#', 'Procedural Generation', 'Audio'],
        category: '3D',
        playStoreUrl: 'https://play.google.com/store',
        videoUrl: 'https://drive.google.com/file/d/example',
        releaseDate: DateTime(2022, 11),
      ),
      
      Project(
        id: '6',
        title: 'Pixel Runner',
        description: 'A nostalgic 2D endless runner with pixel art graphics, power-ups, and challenging obstacles inspired by retro gaming.',
        imageUrl: 'https://images.pexels.com/photos/442576/pexels-photo-442576.jpeg',
        technologies: ['Unity', 'C#', '2D Graphics', 'Pixel Art'],
        category: '2D',
        playStoreUrl: 'https://play.google.com/store',
        appStoreUrl: 'https://apps.apple.com',
        releaseDate: DateTime(2022, 9),
      ),
      
      Project(
        id: '7',
        title: 'Multiplayer Racing Championship',
        description: 'Real-time multiplayer racing game with customizable cars, multiple tracks, and competitive tournaments.',
        imageUrl: 'https://images.pexels.com/photos/358220/pexels-photo-358220.jpeg',
        technologies: ['Unity', 'C#', 'Photon', 'Physics'],
        category: 'Multiplayer',
        webUrl: 'https://racing-championship.com',
        videoUrl: 'https://drive.google.com/file/d/example',
        releaseDate: DateTime(2022, 7),
      ),
      
      Project(
        id: '8',
        title: 'AR Furniture Placement',
        description: 'Augmented reality application for visualizing furniture in real-world spaces before purchase, with accurate scaling and lighting.',
        imageUrl: 'https://images.pexels.com/photos/1090638/pexels-photo-1090638.jpeg',
        technologies: ['Unity', 'AR Foundation', 'C#', '3D Modeling'],
        category: 'Products',
        appStoreUrl: 'https://apps.apple.com',
        playStoreUrl: 'https://play.google.com/store',
        releaseDate: DateTime(2022, 5),
      ),
    ];
  }
}