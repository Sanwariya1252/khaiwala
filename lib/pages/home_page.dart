// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:khaiwala/pages/game_page.dart';
import 'package:khaiwala/pages/mybid_page.dart';
import 'package:khaiwala/pages/resultchart_page.dart';
import 'package:khaiwala/pages/support_page.dart';
import 'package:khaiwala/pages/winner_page.dart';
import 'package:khaiwala/styles/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    const ResultchartPage(),
    const SupportPage(),
    const HomeContentPage(),
    const WinnerPage(),
    const MybidPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _pages[_selectedIndex],

            // Show Trader Mode button only on Home
            if (_selectedIndex == 2)
              Positioned(
                left: MediaQuery.of(context).size.width * 0.5 - 75,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage()),
                    );
                  },
                  child: CustomPaint(
                    painter: _TabPainter(),
                    child: Container(
                      width: 150,
                      height: 42,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sports_esports_rounded,
                            color: AppColors.blackColor,
                            size: 26,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Play Mode",
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
            height: 60,
            backgroundColor: Color(0xFFE8F5E9),
            elevation: 0,
            iconTheme: WidgetStatePropertyAll(
              IconThemeData(color: AppColors.blackColor, size: 28),
            ),
            labelTextStyle: WidgetStatePropertyAll(
              TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            indicatorShape: CircleBorder(
              side: BorderSide(color: AppColors.primaryColor, width: 35),
            ),
          ),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.insert_chart_rounded),
                label: 'Result Chart',
              ),
              NavigationDestination(
                icon: Icon(Icons.support_agent_rounded),
                label: 'Support',
              ),
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                icon: Icon(Icons.emoji_events_outlined),
                label: 'Winner',
              ),
              NavigationDestination(
                icon: Icon(Icons.gavel_rounded),
                label: 'My Bids',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// This painter draws the curved tab shape
class _TabPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xff009f75), Color(0xFFE8F5E9)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final Path path = Path()
      ..moveTo(0, size.height * 0.3)
      ..quadraticBezierTo(size.width * 0.5, 0, size.width, size.height * 0.3)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BlinkingContainer extends StatefulWidget {
  final Widget child;
  const BlinkingContainer({super.key, required this.child});

  @override
  _BlinkingContainerState createState() => _BlinkingContainerState();
}

class _BlinkingContainerState extends State<BlinkingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: AppColors.primaryColor,
      end: AppColors.logoFontColor,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.child,
        );
      },
    );
  }
}

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    var arrColors = [Colors.red, Colors.pink, Colors.orange, Colors.purple];
    return SingleChildScrollView(
      child: Column(
        children: [
          // Top Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/images/khaiwala.png",
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "Welcome Back,\n Sonu Sanwariya",
                        style: TextStyle(
                          fontFamily: "Barabara",
                          fontSize: 12,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications,
                            size: 30,
                            color: AppColors.blackColor,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: AppColors.backGroundColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              "15",
                              style: TextStyle(
                                color: AppColors.logoFontColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.wallet,
                        size: 30,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Available Balance...",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.backGroundColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        "₹ 5430/-",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.backGroundColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.all(5.0),
            height: 175,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              border: Border.all(color: AppColors.primaryColor, width: 2),
              boxShadow: const [BoxShadow(color: Colors.grey)],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.all(5.0),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: AppColors.primaryColor, width: 2),
              boxShadow: const [BoxShadow(color: Colors.grey)],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  height: 30,
                  width: 125,
                  child: BlinkingContainer(
                    child: const Center(
                      child: Text(
                        "Latest Result",
                        style: TextStyle(
                          fontFamily: "Barabara",
                          fontSize: 16,
                          color: AppColors.backGroundColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB42217),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            "66",
                            style: TextStyle(
                              fontFamily: "Barabara",
                              fontSize: 22,
                              color: AppColors.backGroundColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: const Text(
                          "FARIDABAD",
                          style: TextStyle(
                            fontFamily: "Barabara",
                            fontSize: 11,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A650D),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: const Text(
                          "66",
                          style: TextStyle(
                            fontFamily: "Barabara",
                            fontSize: 22,
                            color: AppColors.backGroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7),
                      child: Text(
                        "OLD",
                        style: TextStyle(
                          fontFamily: "Barabara",
                          fontSize: 14,
                          color: Color(0xFFB42217),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 11),
                      child: Text(
                        "06:01 AM",
                        style: TextStyle(
                          fontFamily: "Barabara",
                          fontSize: 14,
                          color: AppColors.logoFontColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        "NEW",
                        style: TextStyle(
                          fontFamily: "Barabara",
                          fontSize: 14,
                          color: Color(0xFF0A650D),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Text(
                  "12-12-2012",
                  style: TextStyle(
                    fontFamily: "Barabara",
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Today Results",
            style: TextStyle(
              fontFamily: "Barabara",
              fontSize: 20,
              color: AppColors.headingColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            itemCount: arrColors.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: arrColors[index],
                  borderRadius: BorderRadius.circular(11),
                ),
                height: 60,
                child: Center(
                  child: Text(
                    'Item ${index + 1}',
                    style: const TextStyle(
                      fontFamily: "Barabara",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
