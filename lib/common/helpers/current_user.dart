import '../enums/user_role.dart';
import '../models/user_ui_model.dart';

UserUIModel therapistUser = const UserUIModel(
  name: 'Duaa Magdy',

  role: UserRole.therapist,

  imageUrl:
      'https://i.pravatar.cc/300',
);

UserUIModel patientUser = const UserUIModel(
  name: 'Menna Mohamed',

  role: UserRole.patient,

  imageUrl:
      'https://i.pravatar.cc/300',
);