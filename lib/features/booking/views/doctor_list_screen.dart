import 'package:clinics/core/config/app_colors.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/core/widgets/loading_overlay.dart';
import 'package:clinics/features/auth/services/token_storage_service.dart';
import 'package:clinics/features/booking/cubit/clinic_cubit.dart';
import 'package:clinics/features/booking/cubit/doctor_notification_cubit.dart';
import 'package:clinics/features/booking/cubit/doctor_notification_state.dart';
import 'package:clinics/features/booking/model/clinic_model.dart';
import 'package:clinics/features/booking/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specializationController = TextEditingController();
  String _nameQuery = "";
  String _specializationQuery = "";

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
    _nameController.addListener(() {
      setState(() {
        _nameQuery = _nameController.text.toLowerCase();
      });
    });
    _specializationController.addListener(() {
      setState(() {
        _specializationQuery = _specializationController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _specializationController.dispose();
    super.dispose();
  }

  Future<void> _fetchDoctors() async {
    final tokenStorage = GetIt.instance<TokenStorageService>();
    final clinicId = await tokenStorage.getClinicId();
    if (clinicId != null && mounted) {
      context.read<ClinicCubit>().getAClinicByID(clinicId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorNotificationCubit, DoctorNotificationState>(
      listener: (context, state) {
        if (state is DoctorNotificationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Notification sent successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is DoctorNotificationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            'Doctors List',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: GradientBackground(
          child: SafeArea(
            child: Column(
              children: [
                _buildSearchFilters(),
                Expanded(
                  child: BlocBuilder<ClinicCubit, ClinicState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () => const Center(child: LoadingWidget()),
                        loaded: (clinic) {
                          final doctors = (clinic.doctors ?? []).where((doctor) {
                            final nameMatch = (doctor.name ?? "")
                                .toLowerCase()
                                .contains(_nameQuery);
                            final specMatch = (doctor.specialization ?? "")
                                .toLowerCase()
                                .contains(_specializationQuery);
                            return nameMatch && specMatch;
                          }).toList();

                          if (doctors.isEmpty) {
                            return const Center(
                              child: Text(
                                'No doctors found',
                                style: TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: doctors.length,
                            itemBuilder: (context, index) {
                              final doctor = doctors[index];
                              return _DoctorCard(doctor: doctor);
                            },
                          );
                        },
                        error: (message) => Center(child: Text('Error: $message')),
                        orElse: () => const SizedBox.shrink(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Search by Doctor Name',
              prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _specializationController,
            decoration: InputDecoration(
              hintText: 'Search by Specialization',
              prefixIcon: const Icon(Icons.medical_services_outlined,
                  color: AppColors.primaryColor),
              filled: true,
              fillColor: Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const _DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      shadowColor: Colors.black26,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            color: AppColors.primaryColor,
            size: 30,
          ),
        ),
        title: Text(
          doctor.name ?? 'Unnamed Doctor',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            doctor.specialization ?? 'Specialist',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
        trailing: BlocBuilder<DoctorNotificationCubit, DoctorNotificationState>(
          builder: (context, state) {
            final isLoading = state is DoctorNotificationLoading;
            return IconButton(
              icon: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const Icon(
                      Icons.notifications_active_rounded,
                      color: AppColors.primaryColor,
                      size: 28,
                    ),
              onPressed: isLoading
                  ? null
                  : () {
                      if (doctor.id != null) {
                        final clinicState = context.read<ClinicCubit>().state;
                        String clinicTitle = "the clinic";
                        
                        clinicState.maybeWhen(
                          loaded: (clinic) {
                            clinicTitle = clinic.title ?? "the clinic";
                          },
                          orElse: () {},
                        );

                        final currentTime = DateFormat('HH:mm').format(DateTime.now());
                        final message = "Doctor ${doctor.name} is arrive at $clinicTitle now ($currentTime).";

                        context
                            .read<DoctorNotificationCubit>()
                            .notifyByDoctor(doctor.id!, message: message);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Doctor ID is missing')),
                        );
                      }
                    },
            );
          },
        ),
      ),
    );
  }
}
