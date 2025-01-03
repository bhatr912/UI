class AnalyticsData {
  final double totalRevenue;
  final double sales;
  final int activeUsers;
  final Map<String, double> storeCategories;
  final Map<String, double> topCountries;
  final List<double> overviewData;
  final List<double> statisticsData;

  AnalyticsData({
    required this.totalRevenue,
    required this.sales,
    required this.activeUsers,
    required this.storeCategories,
    required this.topCountries,
    required this.overviewData,
    required this.statisticsData,
  });
}