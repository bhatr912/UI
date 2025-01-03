import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final Map<String, double> categories;

  const CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: categories.entries.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getCategoryIcon(entry.key),
                        size: 20,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${entry.value}%',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: entry.value / 100,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(_getCategoryColor(entry.key)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'games':
        return Icons.games;
      case 'arts':
        return Icons.palette;
      case 'sports':
        return Icons.sports;
      case 'news':
        return Icons.newspaper;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'games':
        return Colors.blue;
      case 'arts':
        return Colors.purple;
      case 'sports':
        return Colors.green;
      case 'news':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
