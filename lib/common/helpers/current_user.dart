import '../enums/user_role.dart';
import '../models/user_ui_model.dart';

UserUIModel therapistUser = const UserUIModel(
  name: 'Dr. Duaa Magdy',

  role: UserRole.therapist,

  imageUrl:
      'https://picsum.photos/id/152/200/300',
);

UserUIModel patientUser = const UserUIModel(
  name: '',

  role: UserRole.patient,

  imageUrl:
      'https://i.pravatar.cc/300',
);