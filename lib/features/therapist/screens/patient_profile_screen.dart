import 'package:flutter/material.dart';

class PatientProfileScreen extends StatelessWidget {
  final String name;
  final String age;
  final String status;
  final String language;
  final String city;
  final String imageId;

  const PatientProfileScreen({
    super.key,
    required this.name,
    required this.age,
    required this.status,
    required this.language,
    required this.city,
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
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 18,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 55,
              backgroundImage: NetworkImage(
                'https://picsum.photos/id/$imageId/300/300',
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Video Call Session',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 30),

          _buildSectionTitle('Personal informations'),

          _buildBullet('Age: $age'),

          Row(
            children: [
              const Text(
                '• Account Status: ',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                status,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          _buildBullet('Preferred language: $language'),

          _buildBullet('Address: $city'),

          const SizedBox(height: 20),

          _buildSectionTitle('Mental Health Background'),

          _buildBullet('Previous Therapy Experience: No'),

          _buildBullet('Family History of Mental Issues: No History'),

          const SizedBox(height: 20),

          _buildSectionTitle('Emotional & Psychological Symptoms'),

          _buildBullet('Frequent Panic Attacks'),

          _buildBullet('Frequent mood changes'),

          _buildBullet('Feeling easily irritated or angry'),

          _buildBullet('Feeling sad, empty, or lacking motivation'),

          const SizedBox(height: 20),

          _buildSectionTitle('Payment Method'),

          _buildBullet('Credit Card'),

          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
Widget _buildSectionTitle(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1B3B86),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _buildBullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 6,
      bottom: 6,
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        '• $text',
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    ),
  );
}
}