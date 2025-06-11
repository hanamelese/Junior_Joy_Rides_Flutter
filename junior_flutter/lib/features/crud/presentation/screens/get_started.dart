import 'package:flutter/material.dart';

class GetStartedScreen extends StatefulWidget {
  final void Function(String) onNavigate;
  const GetStartedScreen({super.key, required this.onNavigate});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}
class _GetStartedScreenState extends State<GetStartedScreen> {
  final brandColor = const Color(0xFFC5AE3D);
  int _currentPage = 0;
  final int _numberOfPages = 3;
  final List<String> backgroundImages = [
    'assets/images/img_99.png',
    'assets/images/img_9.jpg',
    'assets/images/img_10.jpg',
  ];
  final List<String> contentDescriptions = [
    "Book interviews for children",
    "Order special birthday celebrations",
    "Enjoy fun activities and surprises"
  ];
  final List<String> titles = [
    "Book Interviews",
    "Celebrate Birthdays",
    "Fun & Surprises"
  ];
  final List<String> descriptions = [
    "Easily schedule interviews for your little ones with just a few taps. Connect with the right people to nurture their growth.",
    "Make your child's birthday unforgettable! Order personalized celebrations delivered right to your doorstep.",
    "Discover a world of fun activities, engaging games, and delightful surprises to make every moment special."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF3D3D3D), Color(0xFF252525)],
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    backgroundImages[_currentPage],
                    fit: BoxFit.cover,
                    color: Colors.white.withValues(alpha: 0.8),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        titles[_currentPage],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        descriptions[_currentPage],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () => widget.onNavigate('/user-signup'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandColor,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => widget.onNavigate('learnMore'),
                        child: Text(
                          'Learn More',
                          style: TextStyle(
                            fontSize: 16,
                            color: brandColor,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_numberOfPages, (index) {
                          final isSelected = index == _currentPage;
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _currentPage = index;
                                  });
                                },
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? brandColor
                                        : brandColor.withValues(alpha: 0.5),
                                  ),
                                ),
                              ),
                              if (index < _numberOfPages - 1)
                                const SizedBox(width: 8),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Junior Joyride',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}