import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:my_therapy/common/theme/app_colors.dart';
import 'package:my_therapy/common/widgets/custom_appbar.dart';

import '../../../common/network/api_constants.dart';
import '../controllers/availability_cubit.dart';
import '../controllers/availability_state.dart';
import '../services/therapist_service_impl.dart';

class ChooseAvailabilityScreen extends StatefulWidget {
  const ChooseAvailabilityScreen({super.key});

  @override
  State<ChooseAvailabilityScreen> createState() => _ChooseAvailabilityScreenState();
}

class _ChooseAvailabilityScreenState extends State<ChooseAvailabilityScreen> {
  String _formatDate(DateTime date) {
    return DateFormat(
      'dd MMM yyyy • hh:mm a',
    ).format(date);
  }

Future<void> _showAddAvailabilityDialog(
  BuildContext context,
) async {
  DateTime? startTime;
  DateTime? endTime;

  await showDialog(
    context: context,
    useRootNavigator: false,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Add Availability',),
        content: StatefulBuilder(
          builder: (
            context,
            setDialogState,
          ) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    startTime == null
                        ? 'Select Start Time'
                        : startTime.toString(),
                  ),
                  leading: const Icon(
                    Icons.schedule,
                  ),
                  onTap: () async {
                    final date =
                        await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate:DateTime(2100,),
                      initialDate: DateTime.now(),
                    );
                    if (!context.mounted) return;
                    if (date == null) {
                      return;
                    }

                    final time =
                        await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay.now(),
                    );
                    if (!context.mounted) return;
                    if (time == null) {
                      return;
                    }

                    setDialogState(() {
                      startTime =
                          DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  },
                ),

                ListTile(
                  title: Text(
                    endTime == null
                        ? 'Select End Time'
                        : endTime.toString(),
                  ),
                  leading: const Icon(
                    Icons.schedule_send,
                  ),
                  onTap: () async {
                    final date =
                        await showDatePicker(
                      context: context,
                      firstDate:
                          DateTime.now(),
                      lastDate:
                          DateTime(2100,),
                      initialDate:DateTime.now(),
                    );

                    if (!context.mounted) return;

                    if (date == null) {
                      return;
                    }

                    final time =
                        await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay.now(),
                    );
                    if (!context.mounted) return;
                    if (time == null) {
                      return;
                    }

                    setDialogState(() {
                      endTime =
                          DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext,);
            },
            child: const Text(
              'Cancel',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (startTime == null ||
                  endTime == null) {
                return;
              }

              await context
                  .read<AvailabilityCubit>()
                  .addAvailability(
                    startTime: startTime!,
                    endTime: endTime!,
                  );

              if (!context.mounted) {
                return;
              }
              if (!dialogContext.mounted) {
                return;}

              Navigator.pop(dialogContext,);
            },
            child: const Text('Add',),
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AvailabilityCubit(
        TherapistServiceImpl(),
      )..getMyAvailability(),
      child: Builder(
        builder: ( context) { 
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Choose Availability',
            showBackArrow: true,
          ),
          body: BlocBuilder<AvailabilityCubit,AvailabilityState>(
            builder: (context, state) {
              if (state is AvailabilityLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
        
              if (state is AvailabilityError) {
                return Center(
                  child: Text(
                    state.message,
                  ),
                );
              }
        
              if (state is AvailabilityLoaded) {
                if (state.slots.isEmpty) {
                  return const Center(
                    child: Text(
                      'No availability slots found',
                    ),
                  );
                }
        
                return ListView.separated(
                  padding:const EdgeInsets.all(16),
                  itemCount: state.slots.length,
                  separatorBuilder:
                      (_, __) =>
                          const SizedBox(height: 12,),
                  itemBuilder:(context, index) {
                    final slot =state.slots[index];
        
                    return Container(
                      padding: const EdgeInsets.all(16,),
                      decoration:BoxDecoration(
                        color: AppColors.navBackground,
                        borderRadius:
                            BorderRadius.circular(16,),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05,),
                            blurRadius: 8,
                            offset: const Offset(0,3,),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Row(
  children: [
    CircleAvatar(
  radius: 22,
  backgroundImage:
      slot.therapistProfilePicture != null
          ? NetworkImage(
              "${ApiConstants.baseUrl}/${slot.therapistProfilePicture}",
            )
          : null,
  child: slot.therapistProfilePicture == null
      ? const Icon(
          Icons.person,
        )
      : null,
),
    const SizedBox(width: 8),

    Expanded(
      child: Text(
        'Dr. ${slot.therapistName}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    IconButton(
      icon: const Icon(
        Icons.delete_outline,
        color: Colors.red,
      ),
      onPressed: () async {
        final confirm =
            await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text(
              'Delete Availability',
            ),
            content: const Text(
              'Are you sure you want to delete this slot?',
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.pop(context, false,),
                child: const Text('Cancel',),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pop(context, true,),
                child: const Text('Delete',),
              ),
            ],
          ),
        );

        if (confirm == true) {
          await context
              .read<
                  AvailabilityCubit>()
              .deleteAvailability(
                slot.slotId,
              );
        }
      },
    ),
  ],
),
        
                          const SizedBox(height: 12,),
        
                          Row(
                            children: [
                              const Icon(
                                Icons.play_circle_outline,
                                size: 20,
                              ),
                              const SizedBox(width: 8,),
                              Expanded(
                                child: Text(
                                  'Start: ${_formatDate(slot.startTime)}',
                                ),
                              ),
                            ],
                          ),
        
                          const SizedBox(height: 8,),
        
                          Row(
                            children: [
                              const Icon(Icons.stop_circle_outlined,
                                size: 20,
                              ),
                              const SizedBox(width: 8,),
                              Expanded(
                                child: Text(
                                  'End: ${_formatDate(slot.endTime)}',
                                ),
                              ),
                            ],
                          ),
        
                          const SizedBox(height: 12,),
        
                          Container(
                            padding:const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration:BoxDecoration(
                              color: slot
                                      .isBooked
                                  ? Colors.red
                                      .withOpacity(
                                      0.1)
                                  : Colors.green
                                      .withOpacity(
                                      0.1),
                              borderRadius:
                                  BorderRadius.circular(20,),
                            ),
                            child: Text(
                              slot.isBooked
                                  ? 'Booked'
                                  : 'Available',
                              style:
                                  TextStyle(
                                color: slot
                                        .isBooked
                                    ? Colors.red
                                    : Colors
                                        .green,
                                fontWeight:
                                    FontWeight
                                        .w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  
                );
              }
        
              return const SizedBox();
            },
          ),
          floatingActionButton:
              FloatingActionButton(
            backgroundColor:
                AppColors.primary,
            shape: const CircleBorder(),
            onPressed: () {
              _showAddAvailabilityDialog(
                context,
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        );
  },
      ),
    );
  }
}