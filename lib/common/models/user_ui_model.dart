import '../enums/user_role.dart';

class UserUIModel {
  final String name;

  final String? imageUrl;

  final UserRole role;

  const UserUIModel({
    required this.name,

    required this.role,

    this.imageUrl,

  });
  

  bool get isTherapist {
    return role == UserRole.therapist;
  }

  bool get isPatient {
    return role == UserRole.patient;
  }

  String get displayName {
  if (isTherapist) {
    return 'Dr. $name';
  }

  return name;
}

}