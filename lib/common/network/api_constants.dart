class ApiConstants {
  static const String baseUrl =
      'http://mytherapy.runasp.net';

  // Auth
  static const String login =
      '/api/auth/login';

  static const String registerPatient =
      '/api/auth/register/patient';

  static const String registerTherapist =
      '/api/auth/register/therapist';

  // Email Verification
  static const String sendVerificationCode =
    '/api/auth/send-verification-code';

  static const String verifyEmail =
    '/api/auth/verify-email';

  // Admin
  static const String pendingTherapists =
      '/api/admin/therapists/pending';

  static String approveTherapist(
    String therapistId,
  ) =>
      '/api/admin/therapists/$therapistId/approve';

  static String rejectTherapist(
    String therapistId,
  ) =>
      '/api/admin/therapists/$therapistId/reject';

    // Profile
  static const String uploadLicense =
      '/api/profile/upload-license';

      static const String verificationStatus =
      '/api/profile/verification-status';

      //Therapist Availability
      static const String therapistAvailabilityMy =
    '/api/therapist/availability/my';

    static const String therapistAvailability =
    '/api/therapist/availability';

  static String deleteAvailability(
  String slotId,) =>
    '/api/therapist/availability/$slotId';
}