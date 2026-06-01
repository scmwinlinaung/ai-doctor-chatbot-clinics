import 'package:clinics/core/config/app_colors.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/features/booking/model/doctor_model.dart';
import 'package:flutter/material.dart';

class SearchableGroupedDoctorDropdown extends StatelessWidget {
  final List<DoctorModel> doctors;
  final String? value; // Can be ID or Name depending on context
  final String valueType; // 'id' or 'name'
  final String labelText;
  final IconData icon;
  final ValueChanged<DoctorModel?> onChanged;
  final String? Function(DoctorModel?)? validator;
  final bool showAllOption;
  final bool? isDark; // Changed to nullable

  const SearchableGroupedDoctorDropdown({
    super.key,
    required this.doctors,
    this.value,
    this.valueType = 'id',
    required this.labelText,
    required this.icon,
    required this.onChanged,
    this.validator,
    this.showAllOption = false,
    this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveIsDark = isDark ?? (theme.brightness == Brightness.dark);
    
    // Find the current selected doctor for display
    DoctorModel? selectedDoctor;
    if (value != null) {
      try {
        selectedDoctor = doctors.firstWhere((d) => 
          valueType == 'id' ? d.id == value : d.name == value
        );
      } catch (_) {
        selectedDoctor = null;
      }
    }

    return FormField<DoctorModel?>(
      initialValue: selectedDoctor,
      validator: validator,
      builder: (FormFieldState<DoctorModel?> state) {
        return InkWell(
          onTap: () => _showSearchModal(context, state, effectiveIsDark),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: effectiveIsDark ? Colors.white70 : AppColors.lightSecondaryText),
              prefixIcon: Icon(icon, color: effectiveIsDark ? Colors.white70 : AppColors.primaryColor),
              suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, color: effectiveIsDark ? Colors.white70 : AppColors.primaryColor),
              filled: true,
              fillColor: effectiveIsDark ? Colors.white.withOpacity(0.2) : AppColors.lightBackground,
              errorText: state.errorText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: effectiveIsDark ? Colors.white38 : Colors.transparent, 
                  width: 1.0
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: effectiveIsDark ? theme.primaryColor : AppColors.primaryColor, 
                  width: 2.0
                ),
              ),
              errorStyle: TextStyle(
                color: effectiveIsDark ? Colors.white : AppColors.errorColor,
                fontWeight: effectiveIsDark ? FontWeight.bold : FontWeight.normal,
                backgroundColor: effectiveIsDark ? Colors.redAccent : Colors.transparent,
              ),
            ),
            child: Text(
              state.value?.name ?? (showAllOption ? 'All Doctors' : 'Select Doctor'),
              style: TextStyle(
                color: effectiveIsDark ? Colors.white : AppColors.lightPrimaryText,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSearchModal(BuildContext context, FormFieldState<DoctorModel?> fieldState, bool effectiveIsDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DoctorSearchModal(
        doctors: doctors,
        initialSelection: fieldState.value,
        showAllOption: showAllOption,
        onSelected: (doctor) {
          fieldState.didChange(doctor);
          onChanged(doctor);
          Navigator.pop(context);
        },
        isDark: effectiveIsDark,
      ),
    );
  }
}

class _DoctorSearchModal extends StatefulWidget {
  final List<DoctorModel> doctors;
  final DoctorModel? initialSelection;
  final bool showAllOption;
  final ValueChanged<DoctorModel?> onSelected;
  final bool isDark;

  const _DoctorSearchModal({
    required this.doctors,
    this.initialSelection,
    required this.showAllOption,
    required this.onSelected,
    required this.isDark,
  });

  @override
  State<_DoctorSearchModal> createState() => _DoctorSearchModalState();
}

class _DoctorSearchModalState extends State<_DoctorSearchModal> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Map<String, List<DoctorModel>> _getGroupedDoctors() {
    final filtered = widget.doctors.where((d) => 
      (d.name ?? "").toLowerCase().contains(_searchQuery) ||
      (d.specialization ?? "").toLowerCase().contains(_searchQuery)
    ).toList();

    final Map<String, List<DoctorModel>> grouped = {};
    for (var doctor in filtered) {
      final spec = doctor.specialization ?? 'General';
      if (!grouped.containsKey(spec)) {
        grouped[spec] = [];
      }
      grouped[spec]!.add(doctor);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final grouped = _getGroupedDoctors();
    final specializations = grouped.keys.toList()..sort();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: widget.isDark ? (theme.brightness == Brightness.dark ? theme.cardColor : const Color(0xFF1E1E1E)) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: widget.isDark ? Colors.white24 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              style: TextStyle(color: widget.isDark ? Colors.white : AppColors.lightPrimaryText),
              decoration: InputDecoration(
                hintText: 'Search doctor or specialization...',
                hintStyle: TextStyle(color: widget.isDark ? Colors.white54 : AppColors.lightSecondaryText),
                prefixIcon: Icon(Icons.search, color: widget.isDark ? Colors.white70 : AppColors.primaryColor),
                filled: true,
                fillColor: widget.isDark ? Colors.white.withOpacity(0.1) : AppColors.lightBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: (widget.showAllOption ? 1 : 0) + 
                         specializations.length + 
                         grouped.values.fold(0, (sum, list) => sum + list.length),
              itemBuilder: (context, index) {
                int currentIndex = 0;

                final textStyle = TextStyle(color: widget.isDark ? Colors.white : AppColors.lightPrimaryText);
                final subtitleStyle = TextStyle(color: widget.isDark ? Colors.white60 : AppColors.lightSecondaryText);

                // All Doctors option
                if (widget.showAllOption) {
                  if (index == 0) {
                    return ListTile(
                      title: Text('All Doctors', style: textStyle.copyWith(fontWeight: FontWeight.bold)),
                      leading: const Icon(Icons.people_outline, color: AppColors.primaryColor),
                      onTap: () => widget.onSelected(null),
                    );
                  }
                  currentIndex++;
                }

                for (var spec in specializations) {
                  // Specialization Header
                  if (index == currentIndex) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        spec.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                    );
                  }
                  currentIndex++;

                  final doctorsInSpec = grouped[spec]!;
                  if (index >= currentIndex && index < currentIndex + doctorsInSpec.length) {
                    final doctor = doctorsInSpec[index - currentIndex];
                    final isSelected = widget.initialSelection?.id == doctor.id;
                    
                    return ListTile(
                      title: Text(doctor.name ?? 'Unnamed Doctor', style: textStyle),
                      subtitle: Text(doctor.specialization ?? 'General', style: subtitleStyle),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                        child: const Icon(Icons.person_outline, color: AppColors.primaryColor),
                      ),
                      trailing: isSelected ? const Icon(Icons.check_circle, color: AppColors.primaryColor) : null,
                      onTap: () => widget.onSelected(doctor),
                    );
                  }
                  currentIndex += doctorsInSpec.length;
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
