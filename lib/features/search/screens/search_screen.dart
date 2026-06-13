import 'package:flutter/material.dart';
import 'package:my_therapy/common/widgets/custom_appbar.dart'; //
import '../../patient/screens/therapist_profile_screen.dart';

import '../../../common/enums/user_role.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../common/widgets/header_action_button.dart';

class SearchScreen extends StatefulWidget {
  final UserRole role;
  const SearchScreen({super.key, required this.role}); //

  @override
  State<SearchScreen> createState() => _SearchScreenState(); //
}

class _SearchScreenState extends State<SearchScreen> {
  // 1. لستة الدكاترة (تظهر للمريض) كما في السكتش تماماً
  final List<Map<String, String>> _allTherapists = [
    {'name': 'DR. Adel Gad', 'specialty': 'Psychotherapist', 'rating': '4.8'},
    {'name': 'DR. Hana Radi', 'specialty': 'Psychotherapist', 'rating': '4.7'},
    {'name': 'DR. Asma Mohamed', 'specialty': 'Psychotherapist', 'rating': '4.9'},
    {'name': 'DR. Silia Mogahed', 'specialty': 'Psychotherapist', 'rating': '4.6'},
    {'name': 'DR. Samer Nader', 'specialty': 'Psychotherapist', 'rating': '4.5'},
    {'name': 'DR. Menna Ali', 'specialty': 'Psychotherapist', 'rating': '4.8'},
    {'name': 'DR. Laila Mohamed', 'specialty': 'Psychotherapist', 'rating': '4.7'},
    {'name': 'DR. John Maikel', 'specialty': 'Psychotherapist', 'rating': '4.9'},
  ];

  // 2. لستة المرضى (تظهر للدكتور لو الـ role هو therapist)
  final List<Map<String, String>> _allPatients = [
    {'name': 'Esraa Ahmed', 'specialty': 'Patient', 'rating': '5.0'},
    {'name': 'Ali Mohamed', 'specialty': 'Patient', 'rating': '5.0'},
    {'name': 'Omar Mahmoud', 'specialty': 'Patient', 'rating': '5.0'},
  ];

  // اللستة المفلترة الديناميكية التي ستعرض في الشاشة
  List<Map<String, String>> _filteredResults = [];

  @override
  void initState() {
    super.initState();
    // تحديد اللستة الابتدائية بناءً على نوع المستخدم الحالي عند فتح الشاشة
    _filteredResults = widget.role == UserRole.therapist ? _allPatients : _allTherapists;
  }

  // دالة التصفية والبحث في الوقت الفعلي
  void _onSearchChanged(String query) {
    final baseList = widget.role == UserRole.therapist ? _allPatients : _allTherapists;
    
    setState(() {
      if (query.isEmpty) {
        _filteredResults = baseList;
      } else {
        _filteredResults = baseList
            .where((item) =>
                item['name']!.toLowerCase().contains(query.toLowerCase()) ||
                item['specialty']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) { //
    return Scaffold( //
      appBar: CustomAppBar( //
        title: widget.role == UserRole.therapist //
            ? 'Patients List' //
            : 'Doctor List', //
        showBackArrow: true, //
        action: Container( //
          width: 40, //
          height: 40, //
          decoration: const BoxDecoration( //
            shape: BoxShape.circle, //
            color: Color(0xfffebf4fb), //
          ),
          child: HeaderActionButton( //
            icon: Icons.tune_rounded, //
            onTap: () {}, //
          ),
        ),
      ),
      body: Padding( //
        padding: const EdgeInsets.symmetric( //
          horizontal: 20, //
          vertical: 16, //
        ),
        child: Column( // 👈 تم تحويله إلى Column ليتحمل حقل البحث وتحته النتايج
          children: [
            CustomSearchField( //
              hintText: widget.role == UserRole.therapist //
                  ? 'Search a Patient...' //
                  : 'Search a Doctor...', //
              autofocus: true, //
              onChanged: _onSearchChanged, // ⚡ ربط الكتابة بدالة الفلترة التفاعلية
            ),
            const SizedBox(height: 20),

            // 👈 جزء عرض نتايج البحث بشكل شبكة كروت دائرية متناسقة
            Expanded(
              child: _filteredResults.isEmpty
                  ? const Center(
                      child: Text(
                        'No results found!',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    )
                  : GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // كارتين في كل صف
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8, // تناسب حجم الكارت
                      ),
                      itemCount: _filteredResults.length,
                      itemBuilder: (context, index) {
                        final item = _filteredResults[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFF0F2F9)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: const Color(0xFFF4F6FD),
                                child: Icon(Icons.person, size: 30, color: Colors.grey[400]),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color(0xFF1B3B86),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['specialty']!,
                                style: const TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                              const SizedBox(height: 12),
                              // زرار عرض البروفايل
                              SizedBox(
                                width: 105,
                                height: 30,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1B3B86),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    if (widget.role == UserRole.patient) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => TherapistProfileScreen(
                                            name: item['name']!,
                                            specialty: item['specialty']!,
                                            rating: item['rating']!,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'View Profile',
                                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}