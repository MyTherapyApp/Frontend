import 'package:flutter/material.dart';
import 'book_session_screen.dart';

class TherapistProfileScreen extends StatelessWidget {
  final String name;
  final String specialty;
  final String rating;
  final String imageId;

  const TherapistProfileScreen({
    super.key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.imageId,
  });

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
          'Specialist',
          style: TextStyle(
            color: Color(0xFF1B3B86),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الدكتور
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[200],
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/id/$imageId/600/400',),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // الاسم والتقييم
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(width: 4),
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            
            // التخصص
            Text(
              specialty,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 16),

            // البادجات (الخبرة والسعر)
            Row(
              children: [
                _buildBadge(Icons.work_outline, '4 y.exp'),
                const SizedBox(width: 12),
                _buildBadge(Icons.attach_money, '50/60 min'),
              ],
            ),
            const SizedBox(height: 24),

            // About Section
            const Text('About Dr.Asma', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            const Text(
              'I help clients manage anxiety, depression, and relationship issues through CBT and mindfulness in a safe, supportive space.',
              style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 20),

            // Education Section
            const Text('Education & Certification', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            const Text(
              'MSc in Clinical Psychology - Cairo University |\nCertified CBT Therapist | Member, Egyptian Psychological Association',
              style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 20),

            // Availability Section
            const Text('Availability', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            const Text(
              'Mon 10:00 AM, 6:00 PM\nWed 5:00 PM\nFri 3:00 PM, 8:00 PM',
              style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 20),

            // Session Details Section
            const Text('Session Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            const Text(
              'Session Type: Online Video / Audio/Anonymous\nSession Duration: 60 minutes\nSession Fee: 50\$\nPayment Options: Visa / Vodafone Cash / Fawry',
              style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 32),

            // 1. زرار الحجز (Book Now)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BookSessionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B3B86),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Book Now', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            
            const SizedBox(height: 12), // فاصل بين الزرارين

            // 2. زرار المراسلة (Message a doctor)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // كود المراسلة هنا
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // خلفية بيضاء
                  side: const BorderSide(color: Color(0xFF1B3B86), width: 1.5), // حدود كحلي
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Message a doctor', style: TextStyle(color: Color(0xFF1B3B86), fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget مساعد عشان نرسم بيه المربعات اللبني بتاعة الخبرة والسعر
  Widget _buildBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2FF), // لون لبني فاتح
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.black87),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}