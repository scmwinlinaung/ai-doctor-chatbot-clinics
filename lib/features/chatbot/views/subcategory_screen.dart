import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:clinics/core/widgets/custom_back_button.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/navigation/app_routes.dart';
import 'package:clinics/features/chatbot/cubit/language_cubit.dart';
import 'package:clinics/features/chatbot/models/category_model.dart';
import 'package:clinics/features/chatbot/models/subcategory_model.dart';

class SubcategoryScreen extends StatefulWidget {
  final CategoryModel category;
  final List<SubcategoryModel> subcategories;

  const SubcategoryScreen({
    super.key,
    required this.category,
    required this.subcategories,
  });

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  List<SubcategoryModel> _filteredSubcategories = [];

  @override
  void initState() {
    super.initState();
    _filteredSubcategories = widget.subcategories;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query, String currentLanguage) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      setState(() {
        _filteredSubcategories = widget.subcategories.where((sub) {
          final nameToSearch = currentLanguage == 'mm' && sub.name.mm.isNotEmpty
              ? sub.name.mm
              : sub.name.en;
          return nameToSearch.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, languageState) {
        final title =
            languageState.currentLanguage == 'mm' &&
                widget.category.name.mm.isNotEmpty
            ? widget.category.name.mm
            : widget.category.name.en;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: CustomBackButton(
              callback: () => Navigator.of(context).pop(),
              iconColor: Theme.of(context).primaryColor,
            ),
          ),
          body: GradientBackground(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (query) =>
                        _onSearchChanged(query, languageState.currentLanguage),
                    decoration: InputDecoration(
                      hintText: 'Search subcategories...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white70,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      hintStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Colors.white38,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: _SubcategoryList(
                    languageState: languageState,
                    subcategories: _filteredSubcategories,
                    categoryId: widget.category.id,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SubcategoryList extends StatelessWidget {
  final LanguageState languageState;
  final List<SubcategoryModel> subcategories;
  final String categoryId;
  const _SubcategoryList({
    required this.languageState,
    required this.subcategories,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          final title =
              languageState.currentLanguage == 'mm' &&
                  subcategories[index].name.mm.isNotEmpty
              ? subcategories[index].name.mm
              : subcategories[index].name.en;

          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _SubcategoryCard(
                  title: title,
                  onTap: () {
                    context.push(
                      AppRoutes.questions,
                      extra: {
                        'categoryId': categoryId,
                        'subcategoryId': subcategories[index].id,
                        "subcategoryName": title,
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SubcategoryCard extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _SubcategoryCard({required this.title, required this.onTap});

  @override
  State<_SubcategoryCard> createState() => _SubcategoryCardState();
}

class _SubcategoryCardState extends State<_SubcategoryCard>
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
    // This is a placeholder. You might have a real implementation for this.
    (IconData, Color) getCategoryVisuals(String title) {
      return (Icons.health_and_safety, Colors.blue.withOpacity(0.1));
    }

    final (icon, color) = getCategoryVisuals(widget.title);
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
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).textTheme.titleMedium?.color,
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
  }
}
