import 'package:flutter/material.dart';
import 'package:clinics/core/config/app_colors.dart';
import 'package:clinics/core/widgets/custom_back_button.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/features/booking/models/clinic_model.dart';

// --- NEW SCREEN FOR CLINIC DETAIL ---

class ClinicDetailScreen extends StatelessWidget {
  final ClinicModel clinic;

  // NOTE: This is a placeholder for the actual booking screen widget
  // final Widget bookingScreen;

  const ClinicDetailScreen({
    super.key,
    required this.clinic,
    // required this.bookingScreen,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure the theme is ready
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (_) => bookingScreen));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Navigating to Booking Flow...')),
            );
          },
          child: const Text('Book Appointment Now'),
        ),
      ),

      // 2. Main Scrollable Body with Gradient Background
      body: GradientBackground(
        child: CustomScrollView(
          slivers: [
            // 3. Immersive, Collapsible Header
            _buildSliverAppBar(context, theme),

            // 4. Clinic Details Section
            _buildDetailsSection(theme),

            // 5. Doctor List Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: DoctorListSection(clinic: clinic),
              ),
            ),

            // Extra space to prevent content overlap with bottomNavigationBar
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context, ThemeData theme) {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      backgroundColor: theme.primaryColor,
      elevation: 0,
      leading: CustomBackButton(
        callback: () {
          Navigator.of(context).pop();
        },
        iconColor: Theme.of(context).primaryColor,
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
        title: Text(
          clinic.title,
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              clinic.image,
              fit: BoxFit.cover,
              // Darken the image slightly for better title readability (UI/UX)
              color: Colors.black.withOpacity(0.4),
              colorBlendMode: BlendMode.darken,
            ),
            // Gradient overlay at the bottom to transition to the title
            const Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 120,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildDetailsSection(ThemeData theme) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location and Rating (Placeholder)
            Row(
              children: [
                Icon(Icons.location_on, size: 20, color: theme.primaryColor),
                const SizedBox(width: 4),
                Text(
                  '${clinic.city}, ${clinic.region}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.lightSecondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(Icons.star, size: 20, color: AppColors.secondaryColor),
                Text(' 4.8 (1.2k)', style: theme.textTheme.bodyMedium),
              ],
            ),
            const Divider(height: 30),

            // Description Header
            Text('About the Clinic', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),

            // Description Body
            Text(clinic.description, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 20),

            // Facilities/Services (Placeholder for extra detail)
            Text('Services', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: const [
                Chip(
                  avatar: Icon(Icons.wifi, size: 18),
                  label: Text('Free Wi-Fi'),
                ),
                Chip(
                  avatar: Icon(Icons.local_parking, size: 18),
                  label: Text('Parking'),
                ),
                Chip(
                  avatar: Icon(Icons.coffee, size: 18),
                  label: Text('Cafeteria'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- DOCTOR LIST WIDGET WITH INTERACTIVE ANIMATION ---

class DoctorListSection extends StatefulWidget {
  final ClinicModel clinic;
  const DoctorListSection({super.key, required this.clinic});

  @override
  State<DoctorListSection> createState() => _DoctorListSectionState();
}

class _DoctorListSectionState extends State<DoctorListSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleDoctors = _isExpanded
        ? widget.clinic.doctors
        : widget.clinic.doctors.take(3).toList();

    final remainingCount = widget.clinic.doctors.length - visibleDoctors.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Our Doctors (${widget.clinic.doctors.length})',
            style: theme.textTheme.titleLarge,
          ),
        ),

        // Animated list of doctors
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: -1.0,
                child: child,
              ),
            );
          },
          child: ListView.builder(
            key: ValueKey(
              _isExpanded,
            ), // Key ensures the AnimatedSwitcher works
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: visibleDoctors.length,
            itemBuilder: (context, index) {
              return _DoctorTile(
                name: visibleDoctors[index].name,
                theme: theme,
              );
            },
          ),
        ),

        // "Show More/Less" button
        if (widget.clinic.doctors.length > 3)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              icon: Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: theme.primaryColor,
              ),
              label: Text(
                _isExpanded
                    ? 'Show Less'
                    : 'Show ${remainingCount} More Doctors',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DoctorTile extends StatelessWidget {
  final String name;
  final ThemeData theme;

  const _DoctorTile({required this.name, required this.theme});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.primaryColor.withOpacity(0.1),
        child: Icon(Icons.person, color: theme.primaryColor),
      ),
      title: Text(
        name,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text('General Practitioner', style: theme.textTheme.bodyMedium),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Optional: Navigate to a detailed doctor profile
      },
    );
  }
}
