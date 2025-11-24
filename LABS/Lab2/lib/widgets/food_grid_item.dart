import 'package:flutter/material.dart';
import '../models/food_model.dart';


const Color cardBg = Color(0xFFF6FAFA);

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
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Image.network(
                    food.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 10),
              child: Text(
                food.name.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
