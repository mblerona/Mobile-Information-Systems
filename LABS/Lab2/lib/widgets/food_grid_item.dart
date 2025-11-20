import 'package:flutter/material.dart';
import '../models/food_model.dart';

class FoodGridItem extends StatelessWidget {
  final Food food;
  final VoidCallback onTap;

  const FoodGridItem({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            // Image on top
            Expanded(
              child: Image.network(
                food.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            // Name below
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                food.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
