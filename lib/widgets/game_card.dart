import 'package:flutter/material.dart';
import '../models/game_model.dart';

class GameCard extends StatefulWidget {
  final GameModel game;
  final VoidCallback? onFavoriteToggle;
  const GameCard({super.key, required this.game, this.onFavoriteToggle});

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> with TickerProviderStateMixin {
  late AnimationController favCtrl;
  late Animation<double> favAnim;
  late AnimationController tapCtrl;
  bool pressed = false;
  bool imgPressed = false;

  @override
  void initState() {
    super.initState();
    favCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    favAnim = Tween<double>(begin: 1.0, end: 1.22)
        .animate(CurvedAnimation(parent: favCtrl, curve: Curves.elasticOut));
    tapCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 140));
  }

  @override
  void dispose() {
    favCtrl.dispose();
    tapCtrl.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    if (!widget.game.isFavorite) {
      favCtrl.forward().then((_) => favCtrl.reverse());
    } else {
      favCtrl.forward().then((_) => favCtrl.reverse());
    }
    setState(() => widget.game.isFavorite = !widget.game.isFavorite);
    widget.onFavoriteToggle?.call();
  }

  void _onInstallTap() {
    tapCtrl.forward().then((_) => tapCtrl.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => pressed = true),
      onTapUp: (_) => setState(() => pressed = false),
      onTapCancel: () => setState(() => pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        transform: Matrix4.identity()
          ..translate(0.0, pressed ? 6.0 : 0.0)
          ..scale(pressed ? 0.985 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF1A1A2F),
          boxShadow: [
            BoxShadow(
              color: widget.game.cardColor.withOpacity(0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent, // penting untuk hp
                onTapDown: (_) => setState(() => imgPressed = true),
                onTapUp: (_) => setState(() => imgPressed = false),
                onTapCancel: () => setState(() => imgPressed = false),
                child: Transform.scale(
                  scale: imgPressed ? 0.965 : 1.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180), // lebih smooth
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Image.asset(widget.game.imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) =>
                                      Container(color: widget.game.cardColor))),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.35) // cerah dikit
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 10,
                            child: GestureDetector(
                              onTap: _toggleFavorite,
                              child: ScaleTransition(
                                scale: favAnim,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.45),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Icon(
                                    widget.game.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: widget.game.isFavorite
                                        ? Colors.redAccent
                                        : Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(widget.game.size,
                                  style: const TextStyle(color: Colors.white, fontSize: 11)),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: GestureDetector(
                              onTap: _onInstallTap,
                              child: ScaleTransition(
                                scale: Tween<double>(begin: 1.0, end: 0.94).animate(tapCtrl),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: widget.game.cardColor.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text('INSTALL',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.game.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.game.category,
                          style: TextStyle(color: Colors.white.withOpacity(0.78), fontSize: 12)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 6),
                          Text(widget.game.rating.toString(),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
