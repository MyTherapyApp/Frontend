import 'package:flutter/material.dart';
import 'package:my_therapy/common/widgets/custom_appbar.dart'; //
import '../../patient/screens/therapist_profile_screen.dart';

import '../../../common/enums/user_role.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../common/widgets/header_action_button.dart';
import '../../therapist/screens/patient_profile_screen.dart';

class SearchScreen extends StatefulWidget {
  final UserRole role;
  const SearchScreen({super.key, required this.role}); //

  @override
  State<SearchScreen> createState() => _SearchScreenState(); //
}

class _SearchScreenState extends State<SearchScreen> {
  // Therapist List
  final List<Map<String, String>> _allTherapists = [
    {'name': 'DR. Adel Gad', 'specialty': 'Psychotherapist', 'rating': '4.8','imageId': '10'},
    {'name': 'DR. Hana Radi', 'specialty': 'Psychotherapist', 'rating': '4.7','imageId': '20'},
    {'name': 'DR. Asma Mohamed', 'specialty': 'Psychotherapist', 'rating': '4.9','imageId': '30'},
    {'name': 'DR. Silia Mogahed', 'specialty': 'Psychotherapist', 'rating': '4.6','imageId': '40'},
    {'name': 'DR. Samer Nader', 'specialty': 'Psychotherapist', 'rating': '4.5','imageId': '50'},
    {'name': 'DR. Menna Ali', 'specialty': 'Psychotherapist', 'rating': '4.8','imageId': '60'},
    {'name': 'DR. Laila Mohamed', 'specialty': 'Psychotherapist', 'rating': '4.7','imageId': '70'},
    {'name': 'DR. John Maikel', 'specialty': 'Psychotherapist', 'rating': '4.9','imageId': '80'},
  ];

  // Patient list appears at Therapist interface
  final List<Map<String, String>> _allPatients = [
  {'name': 'Asma Omar','age': '22','status': 'Active','language': 'English','city': 'Cairo','imageId': '64',},
  {'name': 'Esraa Ahmed','age': '24','status': 'Active','language': 'Arabic','city': 'Giza','imageId': '100',},
  {'name': 'Ali Mohamed','age': '28','status': 'Under Treatment','language': 'Arabic','city': 'Fayoum','imageId': '120',},
  {'name': 'Omar Mahmoud','age': '30','status': 'Active','language': 'English','city': 'Alexandria','imageId': '140',},
  {'name': 'Esraa Mahmoud','age': '27','status': 'Active','language': 'English','city': 'Alexandria','imageId': '180',},
  {'name': 'Doaa Magdy','age': '22','status': 'Active','language': 'English','city': 'Fayoum','imageId': '200',},
    {'name': 'menna abobazla','age': '21','status': 'Active','language': 'Arabic','city': 'Fayoum','imageId': '1011',},
      {'name': 'Sara Ahmed','age': '25','status': 'Active','language': 'English','city': 'Fayoum','imageId': '1027',},
        {'name': 'Esraa Magdy','age': '27','status': 'Active','language': 'English','city': 'Fayoum','imageId': '1005',},





];

  List<Map<String, String>> _filteredResults = [];

  @override
  void initState() {
    super.initState();
    _filteredResults = widget.role == UserRole.therapist ? _allPatients : _allTherapists;
  }

  void _onSearchChanged(String query) {
    final baseList = widget.role == UserRole.therapist ? _allPatients : _allTherapists;
    
    setState(() {
  if (query.isEmpty) {
    _filteredResults = baseList;
  } else {
    _filteredResults = baseList.where((item) {
      if (widget.role == UserRole.therapist) {
        return item['name']!
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item['city']!
                .toLowerCase()
                .contains(query.toLowerCase());
      } else {
        return item['name']!
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item['specialty']!
                .toLowerCase()
                .contains(query.toLowerCase());
      }
    }).toList();
  }
});
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: CustomAppBar( 
        title: widget.role == UserRole.therapist 
            ? 'Patients List' 
            : 'Doctor List', 
        showBackArrow: true, 
        action: Container( 
          width: 40, 
          height: 40, 
          decoration: const BoxDecoration( 
            shape: BoxShape.circle, 
            color: Color(0xFFEBF4FB), 
          ),
          child: HeaderActionButton( 
            icon: Icons.tune_rounded, 
            onTap: () {}, 
          ),
        ),
      ),
      body: Padding( //
        padding: const EdgeInsets.symmetric( 
          horizontal: 20, 
          vertical: 16, 
        ),
        child: Column( 
          children: [
            CustomSearchField( //
              hintText: widget.role == UserRole.therapist 
                  ? 'Search a Patient...' 
                  : 'Search a Doctor...', 
              autofocus: true, 
              onChanged: _onSearchChanged, 
            ),
            const SizedBox(height: 20),

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
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8, 
                      ),
                      itemCount: _filteredResults.length,
                      itemBuilder: (context, index) {
                        final item = _filteredResults[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFEBF4FB),
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
                                  radius: 32,
                                  backgroundImage: NetworkImage(
                                  'https://picsum.photos/id/${item['imageId']}/200/200',
                            ),
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
                                widget.role == UserRole.therapist
                                ? item['city']!
                            : item['specialty']!,
                                style: const TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                              const SizedBox(height: 12),
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
                                          imageId: item['imageId']!,
                                    ),
                                  ),
                                );
                                  } else {
                                    Navigator.push(
                                    context,
                                      MaterialPageRoute(
                                        builder: (_) => PatientProfileScreen(
                                          name: item['name']!,
                                          age: item['age']!,
                                          status: item['status']!,
                                          language: item['language']!,
                                          city: item['city']!,
                                          imageId: item['imageId']!,
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