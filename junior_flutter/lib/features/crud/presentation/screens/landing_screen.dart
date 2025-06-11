import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/user_view_model_provider.dart';
import 'package:junior_flutter/features/crud/presentation/components/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


final userViewModelProvider = ChangeNotifierProvider((ref) => UserProvider(ref));


class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  final ScrollController _scrollController = ScrollController();
  int _selectedTabIndex = 0;
  double _appBarOpacity = 1.0;

  final GlobalKey _featuredShowsKey = GlobalKey();
  final GlobalKey _upcomingEventsKey = GlobalKey();

  final List<FeaturedShow> featuredShows = [
    FeaturedShow('Wonder Kids Special', 'img_1', 'Today, 3:00 PM',
        'https://www.youtube.com/watch?v=513a1r65OZY'),
    FeaturedShow('Birthday Bash', 'img_2', 'Today, 3:00 PM',
        'https://www.youtube.com/watch?v=90w2RegGf9w'),
    FeaturedShow('Adventure Time', 'img_3', 'Tomorrow, 11:00 AM', null),
    FeaturedShow('Story Land', 'img_2', 'Saturday, 2:00 PM',
        'https://www.youtube.com/watch?v=cgpOqSIffZ8'),
    FeaturedShow('Fun with Colors', 'img_1', 'Sunday, 9:00 AM', null),
    FeaturedShow('More Fun Show', 'img_3', 'Monday, 1:00 PM',
        'https://www.youtube.com/watch?v=YwIGTtTdHY4'),
  ];

  final List<EventItem> events = [
    EventItem('TV Appearances', 'Be a star on our show!', 'ethiopis_1',
        'https://www.youtube.com/watch?v=YwIGTtTdHY4'),
    EventItem('Birthday Celebrations', 'Celebrate with Etopis!', 'tv_shows',
        'https://www.youtube.com/watch?v=90w2RegGf9w'),
    EventItem('Talent Showcase', 'Show us your amazing talents!', 'talent',
        'https://www.youtube.com/watch?v=cgpOqSIffZ8'),
  ];


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _appBarOpacity = 1.0 - (_scrollController.offset / 200).clamp(0.0, 1.0);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomFilterChip({
    required String label,
    required IconData icon,
    required int index,
  }) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
        _scrollToSection(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.black87,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Replaced context.watch with ref.watch for Riverpod
    final viewModel = ref.watch(userViewModelProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedOpacity(
          opacity: _appBarOpacity,
          duration: const Duration(milliseconds: 200),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFFFFACD), const Color(0xFFFFFFE0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: CustomPaint(
              painter: CirclePainter(),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 60),
                    child: Text(
                      'Welcome\nto Junior\nJoyride',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 10,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/images/img.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                              child: Text('Image Failed to Load: $error'));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('1.2k', 'Happy Kids'),
                Container(
                  width: 2,
                  height: 50,
                  color: Colors.grey[500],
                ),
                _buildStatColumn('250+', 'Shows'),
                Container(
                  width: 2,
                  height: 50,
                  color: Colors.grey[500],
                ),
                _buildStatColumn('4.9', 'Rating'),
              ],
            ),
          ),

          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCustomFilterChip(
                    label: 'All Shows',
                    icon: Icons.star,
                    index: 0,
                  ),
                  const SizedBox(width: 12),
                  _buildCustomFilterChip(
                    label: 'Special',
                    icon: Icons.star,
                    index: 1,
                  ),
                  const SizedBox(width: 12),
                  _buildCustomFilterChip(
                    label: 'Birthday',
                    icon: Icons.cake,
                    index: 2,
                  ),
                ],
              ),
            ),
          ),
          // End of the Filter Chips Section

          const SizedBox(height: 16),
          Column(
            key: _featuredShowsKey,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  'Featured Shows',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredShows.length,
                  itemBuilder: (context, index) {
                    return _buildFeaturedShowItem(featuredShows[index]);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            key: _upcomingEventsKey,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  'Upcoming Events',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              _buildUpcomingEventsSection(),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildFeaturedShowsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: Text(
            'Featured Shows',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredShows.length,
            itemBuilder: (context, index) {
              return _buildFeaturedShowItem(featuredShows[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedShowItem(FeaturedShow show) {
    final String? videoId = show.youtubeVideoUrl != null
        ? YoutubePlayer.convertUrlToId(show.youtubeVideoUrl!)
        : null;

    return GestureDetector(
      onTap: () {
        if (videoId != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PLayerScreen(videoId: videoId),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No video available for this show.')),
          );
        }
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4)
          ],
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(8)),
                child: videoId != null
                    ? Image.network(
                  YoutubePlayer.getThumbnail(videoId: videoId)!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/${show.imageResourceId}.jpg',
                      height: 200,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                )
                    : Image.asset(
                  'assets/images/${show.imageResourceId}.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                        child: Text('Image Placeholder: $error'));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    show.title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.play_arrow, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        show.schedule,
                        style:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingEventsSection() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return _buildEventItem(events[index]);
      },
    );
  }

  Widget _buildEventItem(EventItem event) {
    final String? videoId = event.youtubeVideoUrl != null
        ? YoutubePlayer.convertUrlToId(event.youtubeVideoUrl!)
        : null;

    return GestureDetector(
      onTap: () {
        if (videoId != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PLayerScreen(videoId: videoId),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No video available for this event.')),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4)
          ],
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: videoId != null
                    ? Image.network(
                  YoutubePlayer.getThumbnail(videoId: videoId)!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/${event.imageResourceId}.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                )
                    : Image.asset(
                  'assets/images/${event.imageResourceId}.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                        child: Text('Image Placeholder: $error'));
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              event.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              event.description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToSection(int index) {
    if (index == 1) { // Special
      Scrollable.ensureVisible(
        _featuredShowsKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else if (index == 2) { // Birthday
      Scrollable.ensureVisible(
        _upcomingEventsKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      print('Scrolling to section $index (All Shows or unhandled)');
    }
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = const Color(0xFFADD8E6).withOpacity(0.6);
    final paint2 = Paint()..color = const Color(0xFFFFA07A).withOpacity(0.6);
    final paint3 = Paint()..color = const Color(0xFF98FB98).withOpacity(0.6);

    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.4), 60, paint1);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.45), 55, paint2);
    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.7), 65, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FeaturedShow {
  final String title;
  final String imageResourceId;
  final String schedule;
  final String? youtubeVideoUrl;

  FeaturedShow(
      this.title, this.imageResourceId, this.schedule, this.youtubeVideoUrl);
}

class EventItem {
  final String title;
  final String description;
  final String imageResourceId;
  final String? youtubeVideoUrl;

  EventItem(this.title, this.description, this.imageResourceId,
      this.youtubeVideoUrl);
}

// Ensure your main function wraps the MyApp with ProviderScope
// This main function is typically in lib/main.dart, not this file.
// It's provided here for completeness if you're testing this file in isolation.
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Junior Joyride',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      home: const LandingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
