import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:clinics/core/navigation/app_routes.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/core/widgets/loading_overlay.dart';
import 'package:clinics/features/home/cubit/advertisement_cubit.dart';
import 'package:clinics/features/theme/cubit/theme_cubit.dart';
import 'package:clinics/features/home/views/user_settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentAd = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  // Dummy list of advertisement image URLs. Replace with your actual images.
  final List<String> _advertisements = [
    'https://img.freepik.com/free-vector/medical-healthcare-service-banner-template_23-2149631022.jpg?w=1380&t=st=1696242553~exp=1696243153~hmac=a407a1b415a201c89f5c8a14e1f7b76d75c6d3d4414f04d7d3b2c125d3013b35',
    'https://img.freepik.com/free-psd/medical-healthcare-poster-template_23-2148940596.jpg?w=1380&t=st=1696242583~exp=1696243183~hmac=35914b35d792d47f9e832b49876e55c3c13b1e3e54b6d925d7b5b5c93c4e3e3b',
    'https://img.freepik.com/free-vector/flat-design-medical-facebook-cover_23-2149127845.jpg?w=1380&t=st=1696242602~exp=1696243202~hmac=c63d6b0b6e15d862f13cb447043818e6141a4a58b688d5e08b1a8d0b2841ff5e',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdvertisementCubit()..fetchAdvertisements(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      // This opens the drawer from the left.
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo.jpg'),
                    ),
                  );
                },
              ),
              title: Text(
                'Health Guide',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),
            // Assigning the Drawer to the 'drawer' property for left-side opening.
            drawer: const Drawer(child: UserSettingsScreen()),
            body: GradientBackground(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _buildCategoryCard(
                                context,
                                icon: Icons.grid_view_rounded,
                                label: 'Questions And\nAnswers',
                                color: Theme.of(context).primaryColor,
                                onTap: () {
                                  context.push(AppRoutes.category);
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildCategoryCard(
                                context,
                                icon: Icons.calendar_month_outlined,
                                label: 'Book\nAppointment',
                                color: Theme.of(context).primaryColor,
                                onTap: () {
                                  context.push(AppRoutes.clinics);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 32),
                      _buildAdvertisementCarousel(),
                      _buildArticleCarousel(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildArticleCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Articles", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        CarouselSlider(
          controller: _carouselController,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 1,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentAd = index;
              });
            },
          ),
          items: _advertisements.map((ad) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                      image: NetworkImage(ad),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        // Dots indicator for the carousel
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _advertisements.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _currentAd == entry.key ? 24.0 : 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color:
                      (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_currentAd == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.all(0),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 32),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdvertisementCarousel() {
    return BlocBuilder<AdvertisementCubit, AdvertisementState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: LoadingWidget()),
          failure: (errorMessage) => Center(
            child: Text(
              errorMessage ?? 'Failed to load categories',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
          success: (advertisements) => Column(
            children: [
              CarouselSlider(
                controller: _carouselController,
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 1,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentAd = index;
                    });
                  },
                ),
                items: advertisements.map((ad) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            image: NetworkImage(ad.image),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              // Dots indicator for the carousel
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _advertisements.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(entry.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentAd == entry.key ? 24.0 : 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color:
                            (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black)
                                .withOpacity(
                                  _currentAd == entry.key ? 0.9 : 0.4,
                                ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
