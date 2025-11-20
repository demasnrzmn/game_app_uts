import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/selected_category_provider.dart';

const Color darkBackground = Color(0xFF1A1A1D);

class CategoryChip extends ConsumerWidget {
  final String title;
  final IconData icon;
  final Color color; 

  const CategoryChip({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(selectedCategoryProvider) == title;

    return GestureDetector(
      onTap: () {
        ref.read(selectedCategoryProvider.notifier).state = title;
      },

      child: AnimatedScale(
        scale: isSelected ? 1.15 : 1.0,
        duration: const Duration(milliseconds: 180),

        child: Column(
          children: [
            Container(
              height: 58,
              width: 58,

              decoration: BoxDecoration(
                color: darkBackground,
                borderRadius: BorderRadius.circular(18),

                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? color.withOpacity(0.95)
                        : color.withOpacity(0.25),
                    blurRadius: isSelected ? 25 : 8,
                    spreadRadius: isSelected ? 4 : 1,
                  ),
                ],
              ),

              child: Icon(
                icon,
                size: 32,
                color: isSelected
                    ? color.withOpacity(1.0)
                    : color.withOpacity(0.7),
                shadows: [
                  Shadow(
                    color: isSelected
                        ? color.withOpacity(0.9)
                        : Colors.transparent,
                    blurRadius: isSelected ? 20 : 0,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: TextStyle(
                color:
                    isSelected ? color.withOpacity(1.0) : Colors.grey.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 13.5,
                letterSpacing: 0.7,
                shadows: isSelected
                    ? [
                        Shadow(
                          color: color.withOpacity(0.9),
                          blurRadius: 15,
                        )
                      ]
                    : [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
