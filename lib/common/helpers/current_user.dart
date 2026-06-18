import '../enums/user_role.dart';
import '../models/user_ui_model.dart';

UserUIModel therapistUser = const UserUIModel(
  name: 'Doctor',

  role: UserRole.therapist,

  imageUrl:
      'https://i.pravatar.cc/300',
);

UserUIModel patientUser = const UserUIModel(
  name: '',

  role: UserRole.patient,

  imageUrl:
      'https://i.pravatar.cc/300',
);