class PatientModel {
  final String name;
  final String age;
  final String status;
  final String language;
  final String city;
  final String imageId;

  PatientModel({
    required this.name,
    required this.age,
    required this.status,
    required this.language,
    required this.city,
    required this.imageId,
  });
}

final recentPatients = [
  PatientModel(
    name: 'menna abobazla',
    age: '21',
    status: 'Active',
    language: 'Arabic',
    city: 'Cairo',
    imageId: '1011',
  ),
  PatientModel(
    name: 'Sara Ahmed',
    age: '22',
    status: 'Active',
    language: 'English',
    city: 'Alexandria',
    imageId: '1027',
  ),
  PatientModel(
    name: 'Esraa Magdy',
    age: '22',
    status: 'Active',
    language: 'English',
    city: 'Fayoum',
    imageId: '1005',
  ),
];