import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEEEE),
        elevation: 0,
        automaticallyImplyLeading: false, // Remove default back button
        title: Row(
          children: [
            Icon(Icons.cloud_circle, color: const Color(0xFF29B6F6), size: 28),
            const SizedBox(width: 8),
            const Text(
              'Atmos',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button in body
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Colors.black87,
                ),
              ),
            ),
            // Section Title
            const Text(
              'Latest Alerts & News',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // News Card 1
            _buildNewsCard(
              avatarColor: const Color(0xFF29B6F6),
              authorName: 'Atmos',
              authorRole: 'Admin',
              date: 'February 13, 2026',
              alertTitle: 'Severe Weather Alert',
              description:
                  'Heavy rainfall expected in the downtown area over the next 3 hours. Please take necessary precautions and avoid low-lying areas.',
              hasAlert: true,
            ),

            const SizedBox(height: 16),

            // News Card 2
            _buildNewsCard(
              avatarColor: const Color(0xFF29B6F6),
              authorName: 'Atmos',
              authorRole: 'Admin',
              date: 'February 12, 2026',
              alertTitle: 'Heat Advisory',
              description:
                  'Temperatures expected to reach 38°C this weekend. Stay hydrated, limit outdoor activities during peak hours, and check on elderly neighbours.',
              hasAlert: true,
            ),

            const SizedBox(height: 16),

            // News Card 3
            _buildNewsCard(
              avatarColor: const Color(0xFF29B6F6),
              authorName: 'Atmos',
              authorRole: 'Admin',
              date: 'February 10, 2026',
              alertTitle: 'Weekly Weather Summary',
              description:
                  'This week saw moderate temperatures averaging 26°C with scattered showers on Wednesday. Next week looks clearer with sunny skies expected.',
              hasAlert: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard({
    required Color avatarColor,
    required String authorName,
    required String authorRole,
    required String date,
    required String alertTitle,
    required String description,
    required bool hasAlert,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: avatarColor,
                      child: const Icon(Icons.cloud, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authorName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          authorRole,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF29B6F6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Date
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF29B6F6),
                  ),
                ),
                const SizedBox(height: 10),

                // Alert title
                Row(
                  children: [
                    if (hasAlert)
                      const Icon(Icons.warning_amber_rounded,
                          size: 20, color: Colors.black87),
                    if (hasAlert) const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        alertTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Landscape image placeholder
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Container(
              height: 160,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1A237E),
                    Color(0xFF4A148C),
                    Color(0xFFE65100),
                    Color(0xFFFF8F00),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Stack(
                children: [
                  // Mountain silhouette
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      size: const Size(double.infinity, 80),
                      painter: _MountainPainter(),
                    ),
                  ),
                  // Water reflection
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF1A237E).withValues(alpha: 0.8),
                            const Color(0xFF4A148C).withValues(alpha: 0.6),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF263238)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width * 0.15, size.height * 0.6);
    path.lineTo(size.width * 0.3, size.height * 0.8);
    path.lineTo(size.width * 0.45, size.height * 0.2);
    path.lineTo(size.width * 0.55, size.height * 0.15);
    path.lineTo(size.width * 0.65, size.height * 0.5);
    path.lineTo(size.width * 0.75, size.height * 0.4);
    path.lineTo(size.width * 0.9, size.height * 0.7);
    path.lineTo(size.width, size.height * 0.55);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
