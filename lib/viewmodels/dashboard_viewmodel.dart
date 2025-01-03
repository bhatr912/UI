import 'package:flutter/foundation.dart';
import '../models/analytics_data.dart';

class DashboardViewModel extends ChangeNotifier {
  late AnalyticsData _analyticsData;
  bool _isLoading = true;
  bool _showingProfile = false;

  AnalyticsData get analyticsData => _analyticsData;
  bool get isLoading => _isLoading;
  bool get showingProfile => _showingProfile;

  DashboardViewModel() {
    _loadData();
  }

  Future<void> _loadData() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _analyticsData = AnalyticsData(
      totalRevenue: 3567.99,
      sales: 2465.99,
      activeUsers: 1569,
      storeCategories: {
        'Games': 45.2,
        'Arts': 24.8,
        'Sports': 18.5,
        'News': 11.5,
      },
      topCountries: {
        'United States': 35,
        'Germany': 25,
        'Spain': 20,
        'Italy': 15,
      },
      overviewData: [2000, 1800, 3000, 2800, 3500, 3200],
      statisticsData: [20, 25, 22, 28, 26, 30],
    );

    _isLoading = false;
    notifyListeners();
  }

  void toggleProfileView() {
    _showingProfile = !_showingProfile;
    notifyListeners();
  }
}
