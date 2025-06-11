import 'package:flutter/material.dart';


class HalfScreenMenu extends StatelessWidget {
  final VoidCallback onDismiss;

  const HalfScreenMenu({super.key, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.deepPurple),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Navigation', style: TextStyle(color: Colors.white, fontSize: 24)),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: onDismiss,
                  child: const Text('Close Menu', style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              onDismiss();
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              onDismiss();
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
          ListTile(
            title: const Text('Birthday'),
            onTap: () {
              onDismiss();
              Navigator.pushReplacementNamed(context, '/invitation');
            },
          ),
          ListTile(
            title: const Text('Interview Management'),
            onTap: () {
              onDismiss();
              Navigator.pushReplacementNamed(context, '/interviewManagment');
            },
          ),
          ListTile(
            title: const Text('Wish List'),
            onTap: () {
              onDismiss();
              Navigator.pushReplacementNamed(context, '/wishList');
            },
          ),
        ],
      ),
    );
  }
}

class BaseScaffold extends StatefulWidget {
  final String title; // Retained but not displayed directly in the new app bar style
  final Widget body;
  final int currentIndex;
  final bool showBottomNav;
  final bool showDrawer; // Drawer is replaced by the custom menu for navigation

  const BaseScaffold({
    super.key,
    required this.title,
    required this.body,
    this.currentIndex = 0,
    this.showBottomNav = true,
    this.showDrawer = false, // Default to false as custom menu replaces it
  });

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  // Initial opacity for the app bar. You can link this to scroll position
  // if you want the app bar to fade in/out based on scrolling.
  double _appBarOpacity = 1.0;

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/invitation');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/basic-interview');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This makes the body extend behind the transparent app bar
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedOpacity(
          opacity: _appBarOpacity,
          duration: const Duration(milliseconds: 200),
          child: AppBar(
            backgroundColor: Colors.transparent, // Make app bar transparent
            elevation: 0, // Remove shadow
            actions: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true, // Allows dismissing by tapping outside
                    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                    barrierColor: Colors.black54, // Overlay color
                    transitionDuration: const Duration(milliseconds: 200),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return Align(
                        alignment: Alignment.centerLeft, // Align menu to the left
                        child: Material(
                          color: Colors.transparent, // Important for the menu's own background to show
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7, // 70% width
                            height: MediaQuery.of(context).size.height, // Full height
                            child: HalfScreenMenu(
                              onDismiss: () {
                                Navigator.pop(context); // Dismiss the dialog
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    transitionBuilder: (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-1.0, 0.0), // Starts off-screen to the left
                          end: Offset.zero, // Slides to its position
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut, // Smooth animation
                        )),
                        child: child,
                      );
                    },
                  );
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.transparent, // Ensure button background is transparent
                  padding: const EdgeInsets.all(8),
                ),
              ),
              // You can add other actions here if needed
            ],
            // The `title` property of AppBar is not used here as per the new style.
            // If you want a title, you'd add a Text widget to `actions` or `leading`.
          ),
        ),
      ),
      body: widget.body, // The main content of the scaffold
      bottomNavigationBar: widget.showBottomNav
          ? BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red,
        currentIndex: widget.currentIndex,
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_outlined),
            label: 'Birthday',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam_outlined),
            label: 'Interview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      )
          : null,
    );
  }
}
