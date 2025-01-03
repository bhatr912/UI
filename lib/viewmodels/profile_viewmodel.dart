import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';

class ProfileViewModel extends ChangeNotifier {
  late UserProfile _userProfile;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  UserProfile get userProfile => _userProfile;

  Future<void> loadUserProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      _userProfile = UserProfile(
        name: 'John Doe',
        email: 'john@example.com',
        position: 'Senior Manager',
        phone: '+1 234 567 890',
        location: 'New York, USA',
        notificationsEnabled: true,
        language: 'English',
        darkModeEnabled: false,
        bio:
            '''Experienced senior manager with over 10 years in technology leadership. Specializing in agile methodologies and digital transformation initiatives. Previously led teams at Fortune 500 companies, driving innovation and improving operational efficiency. Passionate about mentoring young professionals and staying current with emerging technologies. MBA from Stanford University.''',
      );
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print('Error loading profile: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(UserProfile updatedProfile) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call to update profile
      await Future.delayed(const Duration(seconds: 1));
      _userProfile = updatedProfile;
      // Notify listeners about the successful update
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print('Error updating profile: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
