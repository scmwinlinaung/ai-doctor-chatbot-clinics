import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinics/features/chatbot/models/category_model.dart';
import 'package:clinics/features/chatbot/cubit/language_cubit.dart';

// A map to assign a unique icon and color to each health category
// This makes the UI more vibrant and intuitive.
(IconData, Color) getCategoryVisuals(String categoryName) {
  final lowerCaseName = categoryName.toLowerCase();
  if (lowerCaseName.contains('women')) {
    return (Icons.pregnant_woman_outlined, Colors.pink.shade100);
  }
  if (lowerCaseName.contains('sexual')) {
    return (Icons.favorite_outline, Colors.red.shade100);
  }
  if (lowerCaseName.contains('mental')) {
    return (Icons.psychology_outlined, Colors.blue.shade100);
  }
  if (lowerCaseName.contains('heart')) {
    return (Icons.monitor_heart_outlined, Colors.red.shade200);
  }
  if (lowerCaseName.contains('lung')) {
    return (Icons.air_outlined, Colors.lightBlue.shade100);
  }
  if (lowerCaseName.contains('digestive')) {
    return (Icons.restaurant_menu_outlined, Colors.orange.shade100);
  }
  if (lowerCaseName.contains('men')) {
    return (Icons.man_outlined, Colors.indigo.shade100);
  }
  if (lowerCaseName.contains('diabetes')) {
    return (Icons.bloodtype_outlined, Colors.teal.shade100);
  }
  // Default icon and color for any unmapped categories
  return (Icons.medical_services_outlined, Colors.grey.shade200);
}

class CategoryCard extends StatefulWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryCard({required this.category, required this.onTap});

  @override
  State<CategoryCard> createState() => CategoryCardState();
}

class CategoryCardState extends State<CategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, languageState) {
        final (icon, color) = getCategoryVisuals(widget.category.name.en);
        final title =
            languageState.currentLanguage == 'mm' &&
                widget.category.name.mm.isNotEmpty
            ? widget.category.name.mm
            : widget.category.name.en;
        // You can customize the subtitle based on your data model if available
        final subtitle = languageState.currentLanguage == 'mm'
            ? "အထွေထွေနှင့် စောင့်ရှောက်မှု"
            : "General & Care";

        return ScaleTransition(
          scale: _scaleAnimation,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // The colored icon container
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Icon(
                      icon,
                      color: Theme.of(
                        context,
                      ).textTheme.titleMedium?.color?.withOpacity(0.7),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Title and Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(
                              context,
                            ).textTheme.titleMedium?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Arrow icon
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14.0,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
