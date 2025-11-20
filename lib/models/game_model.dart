import 'package:flutter/material.dart';


class GameModel {
  final String title;
  final String category;
  final double rating;
  final String size;
  final Color cardColor;
  final String imagePath; 
  bool isFavorite; 

  GameModel({
    required this.title,
    required this.category,
    required this.rating,
    required this.size,
    required this.cardColor,
    required this.imagePath,
    this.isFavorite = false,
  });
}


List<GameModel> editorChoiceGames = [
  GameModel(
    title: 'Badland Brawl',
    category: '(Action)',
    rating: 4.5,
    size: '150MB',
    cardColor: const Color(0xFF5F5C6E),
    imagePath: 'assets/images/badland_brawl.jpg',
  ),

  GameModel(
    title: 'Badland',
    category: '(Adventure)',
    rating: 4.8,
    size: '100MB',
    cardColor: const Color(0xFFFEA024),
    imagePath: 'assets/images/badland.jpeg',
  ),

  GameModel(
    title: 'PUBG Mobile',
    category: '(Battle Royal)',
    rating: 4.6,
    size: '80MB',
    cardColor: const Color(0xFF8863F8),
    imagePath: 'assets/images/pubg.jpg',
  ),

  GameModel(
    title: 'Clash Royale',
    category: '(Strategy)',
    rating: 4.4,
    size: '120MB',
    cardColor: const Color(0xFFF86363),
    imagePath: 'assets/images/clash_royale.jpg',
  ),

  GameModel(
    title: 'Brawl Stars',
    category: '(Action)',
    rating: 4.3,
    size: '110MB',
    cardColor: const Color(0xFF6388F8),
    imagePath: 'assets/images/brawl_stars.jpg',
  ),

  GameModel(
    title: 'E-Fotball Mobile',
    category: '(Sports Game)',
    rating: 4.9,
    size: '5GB',
    cardColor: const Color(0xFF63F888),
    imagePath: 'assets/images/efootbal.png',
  ),



  GameModel(
    title: 'Mobile Legends',
    category: '(MOBA)',
    rating: 4.7,
    size: '3GB',
    cardColor: const Color(0xFF0A97FF),
    imagePath: 'assets/images/mobile_legends.jpg',
  ),

  GameModel(
    title: 'Roblox',
    category: '(Sandbox)',
    rating: 4.6,
    size: '2GB',
    cardColor: const Color(0xFF00D1A0),
    imagePath: 'assets/images/roblox.jpg',
  ),

  GameModel(
    title: 'Clash of Clans',
    category: '(Strategy)',
    rating: 4.8,
    size: '350MB',
    cardColor: const Color(0xFFFFC107),
    imagePath: 'assets/images/clash_of_clans.jpg',
  ),

  GameModel(
    title: 'Block Blast',
    category: '(Puzzle)',
    rating: 4.5,
    size: '90MB',
    cardColor: const Color(0xFF9C27B0),
    imagePath: 'assets/images/block_blast.jpg',
  ),
];
