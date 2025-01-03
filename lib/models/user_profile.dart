class UserProfile {
  final String name;
  final String email;
  final String position;
  final String phone;
  final String location;
  final bool notificationsEnabled;
  final String language;
  final bool darkModeEnabled;
  final String bio;

  UserProfile({
    required this.name,
    required this.email,
    required this.position,
    required this.phone,
    required this.location,
    required this.notificationsEnabled,
    required this.language,
    required this.darkModeEnabled,
    required this.bio,
  });
}