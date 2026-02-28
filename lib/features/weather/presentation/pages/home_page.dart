import 'package:atmos_frontend/core/auth/auth_state.dart';
import 'package:atmos_frontend/features/auth/presentation/widgets/auth_popup.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 2; // Start on Home/Weather (center tab)

  // Tab titles for the AppBar
  final List<String> _tabTitles = [
    'Planner',
    'AI Assistant',
    'Atmos',
    'News',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEEEE),
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            if (_currentIndex == 2)
              const Icon(Icons.cloud_circle, color: Color(0xFF29B6F6), size: 28),
            if (_currentIndex == 2)
              const SizedBox(width: 8),
            Text(
              _tabTitles[_currentIndex],
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFEEEEEE),
          border: Border(
            top: BorderSide(color: Color(0xFFDDDDDD), width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFEEEEEE),
          selectedItemColor: const Color(0xFF29B6F6),
          unselectedItemColor: Colors.grey,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Planner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.smart_toy),
              label: 'AI',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    // Planner (0) requires authentication via popup, then push full page
    if (index == 0) {
      if (!AuthState().isSignedIn) {
        showSignInPopup(context).then((success) {
          if (!mounted) return;
          if (success) {
            Navigator.pushNamed(context, '/planner');
          }
        });
      } else {
        Navigator.pushNamed(context, '/planner');
      }
      return;
    }

    // AI (1) requires authentication via popup, then push full page
    if (index == 1) {
      if (!AuthState().isSignedIn) {
        showSignInPopup(context).then((success) {
          if (!mounted) return;
          if (success) {
            Navigator.pushNamed(context, '/ai');
          }
        });
      } else {
        Navigator.pushNamed(context, '/ai');
      }
      return;
    }

    // Home (2) is the only inline content
    if (index == 2) {
      setState(() {
        _currentIndex = index;
      });
      return;
    }

    // News (3) and Settings (4) open as full pages with back button
    if (index == 3) {
      Navigator.pushNamed(context, '/news');
      return;
    }
    if (index == 4) {
      Navigator.pushNamed(context, '/settings');
      return;
    }
  }

  Widget _buildBody() {
    // Only index 2 (Home) has inline body content now
    return _buildWeatherContent();
  }

  /// The actual weather/home content matching the design.
  Widget _buildWeatherContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 12),
                      Icon(Icons.search, color: Colors.grey, size: 22),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search location...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF29B6F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Today's Weather Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF29B6F6), Color(0xFF4FC3F7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Today',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '28°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Partly Cloudy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.cloud,
                  size: 80,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // 5-Day Forecast Header
          const Text(
            '5-Day Forecast',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          // Forecast List
          _buildForecastRow('Mon', Icons.wb_sunny, '28°', '20°'),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          _buildForecastRow('Tue', Icons.cloud, '25°', '19°'),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          _buildForecastRow('Wed', Icons.grain, '22°', '18°'),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          _buildForecastRow('Thu', Icons.wb_sunny, '30°', '22°'),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          _buildForecastRow('Fri', Icons.thunderstorm, '24°', '17°'),
        ],
      ),
    );
  }

  Widget _buildForecastRow(
    String day,
    IconData icon,
    String high,
    String low,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          const Spacer(),
          Icon(icon, color: const Color(0xFF29B6F6), size: 24),
          const Spacer(),
          Text(
            '$high / $low',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
