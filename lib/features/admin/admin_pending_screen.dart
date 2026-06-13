import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_therapy/common/theme/app_colors.dart';

import '../auth/controllers/auth_cubit.dart';
import '../auth/screens/role_selection_screen.dart';
import 'admin_cubit.dart';
import 'admin_state.dart';


class AdminPendingScreen extends StatefulWidget {
  const AdminPendingScreen({super.key});

  @override
  State<AdminPendingScreen> createState() =>
      _AdminPendingScreenState();
}

class _AdminPendingScreenState
    extends State<AdminPendingScreen> {

  @override
  void initState() {
    super.initState();

    context
        .read<AdminCubit>()
        .getPendingTherapists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pending Therapists',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions: [
    IconButton(
      icon: const Icon(
        Icons.logout,
        color: AppColors.primary,
      ),
      onPressed: () async {
        await context.read<AuthCubit>().logout();

        if (!context.mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const RoleSelectionScreen(verifiedEmail: '',),
          ),
          (route) => false,
        );
      },
    ),
  ],
      ),

      body: BlocConsumer<
          AdminCubit,
          AdminState>(
        listener: (
          context,
          state,
        ) {
          if (state
              is AdminActionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
              ),
            );
          }

          if (state
              is AdminFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
              ),
            );
          }
        },

        builder: (
          context,
          state,
        ) {
          if (state is AdminLoading ||
      state is AdminActionLoading) {
    return const Center(
      child: CircularProgressIndicator(),
            );
          }

          if (state
              is PendingTherapistsLoaded) {
            if (state
                .therapists
                .isEmpty) {
              return const Center(
                child: Text(
                  'No pending therapists',
                ),
              );
            }

            return ListView.builder(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              itemCount: state
                  .therapists.length,
              itemBuilder: (
                context,
                index,
              ) {
                final therapist =
                    state.therapists[
                        index];

                return Card(
                  color: AppColors.navBackground,
                  margin:
                      const EdgeInsets.only(
                    bottom: 16,
                  ),
                  elevation: 3,

                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                      16,
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(
                          therapist
                              .fullName,
                          style:
                              const TextStyle(
                            fontSize:
                                18,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          therapist.email,
                        ),

                        const SizedBox(
                          height: 6,
                        ),

                        Text(
                          'License: ${therapist.licenseNumber}',
                        ),

                        const SizedBox(
                          height: 6,
                        ),

                        Text(
                          'Status: ${therapist.verificationStatus}',
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        Row(
                          children: [

                            Expanded(
                              child:
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary
                                    ),
                                onPressed:
                                    () {
                                  context
                                      .read<AdminCubit>()
                                      .approveTherapist(
                                        therapist.id,
                                      );
                                },

                                child:
                                    const Text(
                                  'Approve',style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child:
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white
                                    ),
                                onPressed:
                                    () {
                                  context
                                      .read<AdminCubit>()
                                      .rejectTherapist(
                                        therapist.id,
                                      );
                                },

                                child:
                                    const Text(
                                  'Reject', style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
  ),);
        },
      ),
    );
  }
}