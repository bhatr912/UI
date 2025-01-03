import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import 'widgets/metric_card.dart';
import 'widgets/overview_chart.dart';
import 'widgets/statistics_chart.dart';
import 'widgets/category_list.dart';
import 'widgets/countries_list.dart';
import 'profile/profile_view.dart';
import '../utils/responsive_helper.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              title: const Text('Dashboard',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.purple,
              iconTheme: const IconThemeData(color: Colors.white),
            )
          : null,
      drawer: isMobile ? _buildDrawer(context) : null,
      body: Row(
        children: [
          if (!isMobile) _buildSidebar(context),
          // Main Content
          Expanded(
            child: Consumer<DashboardViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return viewModel.showingProfile
                    ? const ProfileView()
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Analytics Header and Search Bar in Row
                            if (!isMobile)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Analytics',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.purple,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  _buildSearchField(),
                                ],
                              ),
                            if (isMobile) ...[
                              const Text(
                                'Analytics',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.purple,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildSearchField(),
                            ],
                            const SizedBox(height: 24),

                            // Metrics Section
                            if (isMobile)
                              Column(
                                children: [
                                  MetricCard(
                                    title: 'Total Revenue',
                                    value:
                                        '\$${viewModel.analyticsData.totalRevenue}',
                                    change: '+12.5%',
                                    icon: Icons.attach_money,
                                  ),
                                  const SizedBox(height: 16),
                                  MetricCard(
                                    title: 'Sales',
                                    value: '\$${viewModel.analyticsData.sales}',
                                    change: '+8.2%',
                                    icon: Icons.shopping_cart,
                                  ),
                                  const SizedBox(height: 16),
                                  MetricCard(
                                    title: 'Active Users',
                                    value: viewModel.analyticsData.activeUsers
                                        .toString(),
                                    change: '+4.5%',
                                    icon: Icons.people,
                                  ),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  Expanded(
                                    child: MetricCard(
                                      title: 'Total Revenue',
                                      value:
                                          '\$${viewModel.analyticsData.totalRevenue}',
                                      change: '+12.5%',
                                      icon: Icons.attach_money,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: MetricCard(
                                      title: 'Sales',
                                      value:
                                          '\$${viewModel.analyticsData.sales}',
                                      change: '+8.2%',
                                      icon: Icons.shopping_cart,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: MetricCard(
                                      title: 'Active Users',
                                      value: viewModel.analyticsData.activeUsers
                                          .toString(),
                                      change: '+4.5%',
                                      icon: Icons.people,
                                    ),
                                  ),
                                ],
                              ),

                            const SizedBox(height: 24),

                            // Charts Section
                            if (isMobile) ...[
                              _buildOverviewSection(viewModel),
                              const SizedBox(height: 24),
                              _buildCategorySection(viewModel),
                              const SizedBox(height: 24),
                              _buildStatisticsSection(viewModel),
                              const SizedBox(height: 24),
                              _buildCountriesSection(viewModel),
                            ] else ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: _buildOverviewSection(viewModel),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    child: _buildCategorySection(viewModel),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: _buildStatisticsSection(viewModel),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    child: _buildCountriesSection(viewModel),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            offset: const Offset(2, 0),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        children: [
          // Enhanced Logo Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade100),
              ),
            ),
            child: Row(
              children: [
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 32,
                  height: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),

          // Navigation Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildNavItemWithChildren(
                  'Dashboard',
                  Icons.dashboard_rounded,
                  ['Overview', 'Analytics'],
                  isSelected: true,
                ),
                _buildNavItemWithChildren(
                  'Statistics',
                  Icons.bar_chart,
                  ['Revenue', 'Traffic'],
                ),
                _buildNavItemWithChildren(
                  'Users',
                  Icons.people,
                  ['Overview', 'Security'],
                ),
                _buildNavItemWithChildren(
                  'Inventory',
                  Icons.inventory,
                  ['Products', 'Stock'],
                ),
                _buildNavItemWithChildren(
                  'Billing',
                  Icons.receipt,
                  ['Invoices', 'Payments'],
                ),
                _buildNavItemWithChildren(
                  'Settings',
                  Icons.settings,
                  ['General', 'Security', 'Notifications'],
                ),
              ],
            ),
          ),

          // Enhanced Profile Section
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade400, Colors.purple.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.shade100,
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  final viewModel =
                      Provider.of<DashboardViewModel>(context, listen: false);
                  viewModel.toggleProfileView();
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.purple,
                          child:
                              Icon(Icons.person, color: Colors.white, size: 20),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'John Doe',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 32,
                  height: 32,
                ),
                SizedBox(width: 12),
                Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          _buildNavItemWithChildren(
            'Dashboard',
            Icons.dashboard_rounded,
            ['Overview', 'Analytics'],
            isSelected: true,
          ),
          _buildNavItemWithChildren(
            'Statistics',
            Icons.bar_chart,
            ['Revenue', 'Traffic'],
          ),
          _buildNavItemWithChildren(
            'Users',
            Icons.people,
            ['Overview', 'Security'],
          ),
          _buildNavItemWithChildren(
            'Inventory',
            Icons.inventory,
            ['Products', 'Stock'],
          ),
          _buildNavItemWithChildren(
            'Billing',
            Icons.receipt,
            ['Invoices', 'Payments'],
          ),
          _buildNavItemWithChildren(
            'Settings',
            Icons.settings,
            ['General', 'Security', 'Notifications'],
          ),
          const Divider(),
          _buildProfileSection(context),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    final viewModel = Provider.of<DashboardViewModel>(context, listen: false);
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.purple,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: const Text(
        'John Doe',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.grey.shade600,
      ),
      onTap: () {
        viewModel.toggleProfileView();
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildNavItemWithChildren(
      String title, IconData icon, List<String> children,
      {bool isSelected = false}) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple.shade50 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.purple : Colors.grey.shade600,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.purple : Colors.grey.shade700,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        childrenPadding: const EdgeInsets.only(left: 16),
        children: children.map((child) {
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            leading: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            ),
            title: Text(
              child,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              // Handle navigation here
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      width: 300,
      child: TextField(
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          hintText: 'Search dashboard...',
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: Colors.grey.shade600,
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.purple),
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewSection(DashboardViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          OverviewChart(data: viewModel.analyticsData.overviewData),
        ],
      ),
    );
  }

  Widget _buildCategorySection(DashboardViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Store Category',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          CategoryList(categories: viewModel.analyticsData.storeCategories),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection(DashboardViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          StatisticsChart(data: viewModel.analyticsData.statisticsData),
        ],
      ),
    );
  }

  Widget _buildCountriesSection(DashboardViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Countries',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          CountriesList(countries: viewModel.analyticsData.topCountries),
        ],
      ),
    );
  }
}
