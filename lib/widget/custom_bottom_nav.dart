import 'package:flutter/material.dart';
import 'package:store/models/product_model.dart';
class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(4, (index) {
          IconData icon;
          switch (index) {
            case 0:
              icon = Icons.home;
              break;
            case 1:
              icon = Icons.favorite;
              break;
            case 2:
              icon = Icons.shopping_cart;
              break;
            default:
              icon = Icons.person;
          }

          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onItemSelected(index),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          );
        }),
      ),
    );
  }
}
