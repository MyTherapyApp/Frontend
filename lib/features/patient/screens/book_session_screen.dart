import 'package:flutter/material.dart';
import '../helpers/session_manager.dart';

class BookSessionScreen extends StatefulWidget { // 👈 بقت StatefulWidget
  const BookSessionScreen({super.key});

  @override
  State<BookSessionScreen> createState() => _BookSessionScreenState();
}

class _BookSessionScreenState extends State<BookSessionScreen> {
  // 👈 متغيرات لحفظ اختيارات المستخدم
  int? selectedDate = 7; 
  String? selectedTime = '9:00 AM';
  String? selectedType = 'Anonymous session';

  final List<String> times = ['8:00 AM', '8:30 AM', '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM'];
  final List<String> types = ['Audio session', 'Anonymous session', 'Video session'];

  void _bookSession() {
    if (selectedDate == null || selectedTime == null || selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select Date, Time, and Type')),
      );
      return;
    }

    // 👈 إنشاء بيانات الجلسة الجديدة
    final newSession = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(), // ID عشوائي فريد
      'doctorName': 'Dr.Reem Omar', // اسم افتراضي أو تقدري تمرريه من الشاشة السابقة
      'specialty': 'Psychotherapist',
      'date': 'Day $selectedDate', 
      'time': selectedTime,
      'isConfirmed': true,
      'type': selectedType,
    };

    // 👈 إضافتها للذاكرة المركزية
    SessionManager.bookNewSession(newSession);

    // 👈 إظهار رسالة نجاح والرجوع للشاشة السابقة
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Session Booked Successfully!'), backgroundColor: Colors.green),
    );
    Navigator.pop(context, true); 
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
        title: const Text(
          'Book a session',
          style: TextStyle(color: Color(0xFF1B3B86), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select date:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFF4F6FD), borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mon', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('Tue', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('Wed', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('Thu', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('Fri', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('Sat', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('Sun', style: TextStyle(color: Colors.redAccent, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7, mainAxisSpacing: 10, crossAxisSpacing: 10,
                    ),
                    itemCount: 31,
                    itemBuilder: (context, index) {
                      int day = index + 1;
                      bool isSelected = day == selectedDate; 
                      return GestureDetector(
                        onTap: () {
                          setState(() { selectedDate = day; }); // 👈 تحديث اليوم المختار
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF1B3B86) : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$day',
                              style: TextStyle(
                                color: isSelected ? Colors.white : (day % 7 == 0 ? Colors.redAccent : Colors.black87),
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text('Select time:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: times.map((time) => GestureDetector(
                onTap: () { setState(() { selectedTime = time; }); }, // 👈 تحديث الوقت المختار
                child: _buildTimeChip(time, isSelected: selectedTime == time),
              )).toList(),
            ),
            const SizedBox(height: 24),

            const Text('Select type:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 12),
            Center(
              child: Column(
                children: types.map((type) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () { setState(() { selectedType = type; }); }, // 👈 تحديث النوع المختار
                    child: _buildTypeButton(type, isSelected: selectedType == type),
                  ),
                )).toList(),
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _bookSession, // 👈 تنفيذ عملية الحجز
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B3B86),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Book Now!', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeChip(String time, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1B3B86) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Text(
        time,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildTypeButton(String type, {bool isSelected = false}) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF6B94E6) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSelected ? Colors.transparent : Colors.black12),
      ),
      child: Center(
        child: Text(
          type,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black54, fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}