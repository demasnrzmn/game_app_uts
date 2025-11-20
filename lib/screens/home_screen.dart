import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../widgets/game_card.dart';

const List<Map<String, dynamic>> _categories = [
  {'icon': Icons.gamepad, 'name': 'Semua Game'},
  {'icon': Icons.thumb_up, 'name': 'Game Populer'},
  {'icon': Icons.child_care, 'name': 'Game Anak-anak'},
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int bottomIndex = 0;
  PageController pageController = PageController();
  int selectedCategoryIndex = 0;
  late List<GameModel> _games;

  late AnimationController fadeController;
  late Animation<double> fadeAnimation;

  late AnimationController topController;
  late Animation<Offset> topAnimation;

  @override
  void initState() {
    super.initState();
    _games = editorChoiceGames;

    fadeController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    fadeAnimation = CurvedAnimation(parent: fadeController, curve: Curves.easeInOut);

    topController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    topAnimation = Tween(begin: const Offset(0, -0.4), end: Offset.zero)
        .animate(CurvedAnimation(parent: topController, curve: Curves.easeOut));

    fadeController.forward();
    topController.forward();
  }

  @override
  void dispose() {
    fadeController.dispose();
    topController.dispose();
    super.dispose();
  }

  void _updateGameList() {
    setState(() {
      _games = getFilteredGames();
    });
  }

  void changePage(int index) {
    setState(() => bottomIndex = index);
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeOut,
    );
  }

  void _selectCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
      _games = getFilteredGames();
    });
  }

  List<GameModel> getFilteredGames() {
    if (selectedCategoryIndex == 0) {
      return editorChoiceGames; // Semua game
    } else if (selectedCategoryIndex == 1) {
      // Game populer: PUBG, E-Fotball, ML, CoC
      return editorChoiceGames.where((g) =>
          g.title == 'PUBG Mobile' ||
          g.title == 'E-Fotball Mobile' ||
          g.title == 'Mobile Legends' ||
          g.title == 'Clash of Clans'
      ).toList();
    } else {
      // Game anak-anak (Adventure atau Puzzle)
      return editorChoiceGames
          .where((g) =>
              g.category.contains('Adventure') || g.category.contains('Puzzle'))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideTransition(position: topAnimation, child: _buildHeader()),
              const SizedBox(height: 10),
              SlideTransition(position: topAnimation, child: _buildSearchBar()),
              const SizedBox(height: 15),
              _buildCategoryMenu(),
              const SizedBox(height: 15),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _GameListPage(
                      games: _games,
                      onFavoriteToggle: _updateGameList,
                    ),
                    _FavoriteGamePage(games: editorChoiceGames),
                    const Center(
                      child: Text(
                        "Library Game (Coming Soon)",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Image.asset(
            "assets/images/controller.png",
            width: 32,
            height: 32,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.gamepad, color: Colors.blueAccent, size: 32);
            },
          ),
          const SizedBox(width: 10),
          const Text(
            "GAME STORE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.person, color: Colors.white, size: 26),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2F),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search games...",
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white54),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _categories.asMap().entries.map((entry) {
            int index = entry.key;
            final category = entry.value;

            return AnimatedScale(
              scale: index == selectedCategoryIndex ? 1.12 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: _CategoryMenuItem(
                icon: category['icon'] as IconData,
                name: category['name'] as String,
                isSelected: index == selectedCategoryIndex,
                onTap: () => _selectCategory(index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF0D0D1A),
      currentIndex: bottomIndex,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.white54,
      onTap: changePage,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.videogame_asset_rounded),
          label: "Games",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_rounded),
          label: "Favorite",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_rounded),
          label: "Library",
        ),
      ],
    );
  }
}

class _CategoryMenuItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryMenuItem({
    required this.icon,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isSelected ? Colors.blueAccent : Colors.white;
    final Color boxColor =
        isSelected ? Colors.blueAccent.withOpacity(0.2) : const Color(0xFF1A1A2F);
    final Color borderColor = isSelected ? Colors.blueAccent : Colors.transparent;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: borderColor,
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 35,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _GameListPage extends StatelessWidget {
  final List<GameModel> games;
  final VoidCallback onFavoriteToggle;

  const _GameListPage({
    required this.games,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (games.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Text(
            "Belum ada game tersedia saat ini.",
            style: TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PILIH GAME YANG ANDA SUKA ⁉️",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: games.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemBuilder: (context, index) {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: 1.0,
                child: GameCard(
                  game: games[index],
                  onFavoriteToggle: onFavoriteToggle,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _FavoriteGamePage extends StatelessWidget {
  final List<GameModel> games;

  const _FavoriteGamePage({required this.games});

  @override
  Widget build(BuildContext context) {
    final favoriteGames = games.where((game) => game.isFavorite).toList();

    if (favoriteGames.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline, color: Colors.redAccent, size: 50),
            SizedBox(height: 10),
            Text(
              "Belum ada game yang difavoritkan.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Text(
              "Tekan ikon hati pada kartu game di tab 'Games' untuk menambahkannya.",
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        itemCount: favoriteGames.length,
        itemBuilder: (context, index) {
          final game = favoriteGames[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2F),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  game.imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                game.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text(
                '${game.category} • ${game.size}',
                style: TextStyle(color: Colors.grey.shade400),
              ),
              trailing: const Icon(Icons.favorite, color: Colors.redAccent),
            ),
          );
        },
      ),
    );
  }
}
