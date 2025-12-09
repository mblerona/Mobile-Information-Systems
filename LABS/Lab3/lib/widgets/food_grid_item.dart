import 'package:flutter/material.dart';
import '../models/food_model.dart';

const Color cardBg = Color(0xFFF6FAFA);

class FoodGridItem extends StatelessWidget {
  final Food food;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onTapFavorite;

  const FoodGridItem({
    super.key,
    required this.food,
    required this.onTap,
    required this.isFavorite,
    required this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.20),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {

            const double bottomHeight = 56.0;
            final double imageHeight =
            (constraints.maxHeight - bottomHeight).clamp(0, constraints.maxHeight);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // image area
                SizedBox(
                  height: imageHeight,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Image.network(
                      food.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // bottom area with name + favorite button
                SizedBox(
                  height: bottomHeight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 12, 10, 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            food.name.toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: onTapFavorite,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
