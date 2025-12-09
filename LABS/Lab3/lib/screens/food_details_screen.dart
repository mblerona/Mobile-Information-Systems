import 'package:flutter/material.dart';
import 'package:lab3_recipe_app/screens/profile.dart';

import '../models/food_details_model.dart';
import 'favorite_screen.dart';

const Color screenBg = Color(0xFF803636);
const Color cardBg = Color(0xFFF6FAFA);
const Color stepBg = Color(0xFFDEE4E4);

class FoodDetailsScreen extends StatelessWidget {
  const FoodDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final food = ModalRoute.of(context)!.settings.arguments as FoodDetails;

    final rawLines = food.instructions
        .split(RegExp(r'\r?\n'))
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();

    List<String> steps = [];

    for (int i = 0; i < rawLines.length; i++) {
      final line = rawLines[i];

      final isStepHeader = RegExp(
        r'^step\s*\d+[:.]?$',
        caseSensitive: false,
      ).hasMatch(line);

      if (isStepHeader) {
        if (i + 1 < rawLines.length) {
          steps.add(rawLines[i + 1]);
          i++;
        }
      } else {
        steps.add(line);
      }
    }

    return Scaffold(
      appBar: AppBar(

        backgroundColor: const Color(0xFFFEF8F5),
        title: Text(
          food.name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          // View Favorites button
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()),
              );
            },
            icon: const Icon(
              Icons.favorite,
              color: Color(0xFF4A3A32),
              size: 14,
            ),
            label: const Text(
              'View Favorites',
              style: TextStyle(
                color: Color(0xFF4A3A32),
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),

          // Separator |
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '|',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // Profile icon
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
              print("Profile tapped");
            },
            icon: const Icon(
              Icons.person,
              color: Color(0xFF4A3A32),
              size: 18,
            ),
          ),
        ],
      ),
      backgroundColor: screenBg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // IMAGE CARD
            Container(
              margin: const EdgeInsets.only(bottom: 16),
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.network(
                      food.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // INGREDIENTS CARD
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        food.name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...food.ingredients.map(
                          (ingredient) => Text(
                        '• ${ingredient.name} - ${ingredient.measure}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // INSTRUCTIONS CARD
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Instructions',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (steps.isEmpty)
                      Text(
                        food.instructions,
                        style: const TextStyle(fontSize: 11),
                      )
                    else
                      Column(
                        children: [
                          for (int i = 0; i < steps.length; i++)
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: stepBg,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Step ${i + 1}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    steps[i],
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            // YOUTUBE LINK CARD
            // YOUTUBE LINK CARD
            if (food.youtubeUrl != null && food.youtubeUrl!.trim().isNotEmpty)
              Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    const Text(

                      'YouTube link:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),


                    Expanded(
                      child: SelectableText(
                        food.youtubeUrl!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        maxLines: 1,
                        scrollPhysics: ClampingScrollPhysics(),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
