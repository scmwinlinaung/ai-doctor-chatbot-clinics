import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/navigation/app_routes.dart';
import 'package:clinics/core/widgets/custom_back_button.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/core/widgets/loading_overlay.dart';
import 'package:clinics/features/chatbot/cubit/category_cubit.dart';
import 'package:clinics/features/chatbot/models/category_model.dart';
import 'package:clinics/features/chatbot/models/subcategory_model.dart';
import 'package:clinics/features/chatbot/widgets/category_card.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(BuildContext context, String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      context.read<CategoryCubit>().fetchCategories(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryCubit()..fetchCategories(""),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Health Category',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: CustomBackButton(
            iconColor: Theme.of(context).primaryColor,
            callback: () => Navigator.of(context).pop(),
          ),
        ),
        body: Builder(
          builder: (context) {
            return GradientBackground(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (query) => _onSearchChanged(context, query),
                      decoration: InputDecoration(
                        hintText: 'Search categories...',
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
                    child: BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (context, state) {
                        // Use the modern `when` or `map` for cleaner state handling with Freezed
                        return state.when(
                          initial: () => const SizedBox.shrink(),
                          loading: () => const Center(child: LoadingWidget()),
                          failure: (errorMessage) => Center(
                            child: Text(
                              errorMessage ?? 'Failed to load categories',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),
                          success: (categories) =>
                              _CategoryList(categories: categories),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  final List<CategoryModel> categories;
  const _CategoryList({required this.categories});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          // Each list item is wrapped in configuration for staggering
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: CategoryCard(
                  category: category,
                  onTap: () => _openSubcategories(
                    context,
                    category.subcategories,
                    category,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openSubcategories(
    BuildContext context,
    List<SubcategoryModel> subs,
    CategoryModel category,
  ) {
    context.push(
      AppRoutes.subcategories,
      extra: {'category': category, 'subcategories': subs},
    );
  }
}
