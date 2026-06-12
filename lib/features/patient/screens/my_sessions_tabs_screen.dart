import 'package:flutter/material.dart';
import '../helpers/session_manager.dart'; // 👈 استدعاء الذاكرة المركزية
import '../widgets/custom_session_card.dart';
import 'book_session_screen.dart';

class MySessionsTabsScreen extends StatefulWidget {
  final int initialTabIndex;

  const MySessionsTabsScreen({super.key, this.initialTabIndex = 0});

  @override
  State<MySessionsTabsScreen> createState() => _MySessionsTabsScreenState();
}

class _MySessionsTabsScreenState extends State<MySessionsTabsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialTabIndex);
  }

  void _showCancelDialog(BuildContext context, Map<String, dynamic> session) {
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
                // 👈 بنلغي باستخدام الـ SessionManager وبنحدث الشاشة
                setState(() {
                  SessionManager.cancelSession(session['id']);
                });
                Navigator.pop(dialogContext);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Session cancelled successfully.'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My sessions', style: TextStyle(color: Color(0xFF1B3B86), fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black87,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          indicator: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0xFF1B3B86)),
          tabs: [
            _buildTabButton('Upcoming'),
            _buildTabButton('Completed'),
            _buildTabButton('Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSessionList(SessionManager.upcomingSessions, type: 'upcoming'), // 👈 بنقرأ من الـ Manager
          _buildSessionList(SessionManager.completedSessions, type: 'completed'),
          _buildSessionList(SessionManager.cancelledSessions, type: 'cancelled'),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12, width: 0.5),
        ),
        child: Align(alignment: Alignment.center, child: Text(text)),
      ),
    );
  }

  Widget _buildSessionList(List<Map<String, dynamic>> sessions, {required String type}) {
    if (sessions.isEmpty) {
      return const Center(child: Text('No sessions found', style: TextStyle(color: Colors.grey)));
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        
        String? statusText;
        Color? statusColor;
        Widget? actionRow;

        if (type == 'upcoming') {
          statusText = 'Confirmed';
          statusColor = Colors.green;
          actionRow = UpcomingActionRow(
            onCancel: () => _showCancelDialog(context, session),
            onReschedule: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const BookSessionScreen())).then((_) => setState(() {}));
            },
          );
        } else if (type == 'completed') {
          statusText = 'Done';
          statusColor = Colors.blue;
          actionRow = CompletedActionRow(onSeeNotes: () {});
        } else if (type == 'cancelled') {
          statusText = 'Cancelled';
          statusColor = Colors.red;
          actionRow = CancelledActionRow(
            onReschedule: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const BookSessionScreen())).then((_) => setState(() {}));
            }, 
            onMessageDoctor: () {},
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: CustomSessionCard(
            doctorName: session['doctorName'],
            specialty: session['specialty'],
            date: session['date'],
            time: session['time'],
            isConfirmed: type == 'upcoming',
            statusText: statusText,
            statusColor: statusColor,
            bottomActionRow: actionRow,
          ),
        );
      },
    );
  }
}