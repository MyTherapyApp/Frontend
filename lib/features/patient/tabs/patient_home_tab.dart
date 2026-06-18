import 'package:flutter/material.dart';

import '../helpers/session_manager.dart';
import '../screens/therapist_profile_screen.dart';
import '../../../common/enums/user_role.dart';
import '../../../common/helpers/current_user.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../common/widgets/header_action_button.dart';
import '../../../common/widgets/home_header.dart';
import '../../search/screens/search_screen.dart';
import '../../../common/widgets/section_header.dart';
import '../widgets/custom_session_card.dart';
import '../widgets/therapist_info_card.dart';
import '../widgets/tip_card.dart';
import '../screens/my_sessions_tabs_screen.dart';
import '../screens/book_session_screen.dart';

class PatientHomeTab extends StatefulWidget {
  final ValueChanged<int>? onTabChanged;

  const PatientHomeTab({super.key, this.onTabChanged});

  @override
  State<PatientHomeTab> createState() => _PatientHomeTabState();
}

class _PatientHomeTabState extends State<PatientHomeTab> {
  // تم إزالة أكواد Zego من هنا لتنظيف الشاشة

  void _refreshScreen() => setState(() {});

  void _confirmAndCancelSession(Map<String, dynamic> session) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Cancel Session', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B3B86))),
          content: Text('Are you sure you want to cancel your session with ${session['doctorName']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('No', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B3B86)),
              onPressed: () {
                SessionManager.cancelSession(session['id']);
                _refreshScreen();
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cancelled session with ${session['doctorName']}')),
                );
              },
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyStateWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: const Column(
        children: [
          Icon(Icons.event_busy_rounded, size: 32, color: Colors.grey),
          SizedBox(height: 8),
          Text('No sessions found', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeSessions = SessionManager.upcomingSessions;
    final upcomingSession = activeSessions.isNotEmpty ? activeSessions.first : null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(
                  user: patientUser,
                  actions: [
                    HeaderActionButton(
                      icon: Icons.notifications_rounded,
                      onTap: () {
                        if (widget.onTabChanged != null) {
                          widget.onTabChanged!(2);
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(height: 16),
                CustomSearchField(
                  hintText: 'Search a Therapist...',
                  readOnly: true,
                  enabledFocus: false,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen(role: UserRole.patient)));
                  },
                ),
                const SizedBox(height: 32),
                const SectionHeader(title: 'Upcoming session:'),
                const SizedBox(height: 16),
                
                upcomingSession != null
                    ? CustomSessionCard(
                        doctorName: upcomingSession['doctorName'],
                        specialty: upcomingSession['specialty'],
                        date: upcomingSession['date'],
                        time: upcomingSession['time'],
                        isConfirmed: upcomingSession['isConfirmed'],
                        // تمرير الـ ID مباشرة لأن الخدمة أصبحت تعمل في الخلفية
                        inviteeID: 'therapist_doaa', 
                        inviteeName: 'Doaa (Therapist)',
                        bottomActionRow: UpcomingActionRow(
                          onCancel: () => _confirmAndCancelSession(upcomingSession),
                          onReschedule: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const BookSessionScreen())).then((_) => _refreshScreen());
                          },
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const MySessionsTabsScreen(initialTabIndex: 0))).then((_) => _refreshScreen());
                        },
                      )
                    : _buildEmptyStateWidget(),
                
                const SizedBox(height: 32),
                const SectionHeader(title: 'Recommended Therapists:'),
                const SizedBox(height: 16),
                SizedBox(
                  height: 145,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      TherapistInfoCard(
                        name: 'Dr.Reem Omar',
                        specialty: 'Psychotherapist',
                        rating: '4.8',
                        price: '10\$',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const TherapistProfileScreen(name: 'Dr.Reem Omar', specialty: 'Psychotherapist', rating: '4.8',imageId: '1005')));
                        },
                      ),
                      TherapistInfoCard(
                        name: 'Dr.Ali Omar',
                        specialty: 'Psychotherapist',
                        rating: '4.9',
                        price: '15\$',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const TherapistProfileScreen(name: 'Dr.Ali Omar', specialty: 'Psychotherapist', rating: '4.9',imageId: '1006')));
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SectionHeader(
                  title: 'My sessions:',
                  actionText: 'see All',
                  onActionTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MySessionsTabsScreen(initialTabIndex: 0))).then((_) => _refreshScreen());
                  },
                ),
                const SizedBox(height: 16),
                activeSessions.isNotEmpty
                    ? SizedBox(
                        height: 185,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: activeSessions.length,
                          itemBuilder: (context, index) {
                            final session = activeSessions[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: SizedBox(
                                width: 295,
                                child: CustomSessionCard(
                                  doctorName: session['doctorName'],
                                  specialty: session['specialty'],
                                  date: session['date'],
                                  time: session['time'],
                                  isConfirmed: true,
                                  statusText: 'Confirmed',
                                  statusColor: Colors.green,
                                  // تمرير الـ ID مباشرة هنا أيضاً
                                  inviteeID: 'therapist_doaa',
                                  inviteeName: 'Doaa (Therapist)',
                                  bottomActionRow: UpcomingActionRow(
                                    onCancel: () => _confirmAndCancelSession(session),
                                    onReschedule: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => const BookSessionScreen())).then((_) => _refreshScreen());
                                    },
                                  ),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MySessionsTabsScreen(initialTabIndex: 0))).then((_) => _refreshScreen());
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : _buildEmptyStateWidget(),
                const SizedBox(height: 32),
                const SectionHeader(title: "Today's Tips For You:"),
                const SizedBox(height: 16),
                SizedBox(
                  height: 110,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      TipCard(text: 'Healing Journey starts from a small step'),
                      TipCard(text: 'Small steps every day lead to big results'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}