import 'package:flutter/material.dart';
import 'package:junior_flutter/features/crud/presentation/components/Screen.dart';

class MenuItem {
  final String id;
  final String title;
  final String contentDescription;
  final IconData icon;

  MenuItem({
    required this.id,
    required this.title,
    required this.contentDescription,
    required this.icon,
  });
}

class HalfScreenMenu extends StatefulWidget {
  final Function() onDismiss;

  const HalfScreenMenu({super.key, required this.onDismiss});

  @override
  State<HalfScreenMenu> createState() => _HalfScreenMenuState();
}

class _HalfScreenMenuState extends State<HalfScreenMenu> {
  String? _selectedItemId;

  @override
  void initState() {
    super.initState();
    _selectedItemId = 'home';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 300,
        color: Colors.white,
        child: Column(
          children: [
            const MenuHeader(),
            MenuBody(
              items: [
                MenuItem(
                  id: 'home',
                  title: 'Home',
                  contentDescription: 'Go to home screen',
                  icon: Icons.home,
                ),
                MenuItem(
                  id: 'birthday',
                  title: 'Birthday',
                  contentDescription: 'View birthdays',
                  icon: Icons.card_giftcard,
                ),
                MenuItem(
                  id: 'interview',
                  title: 'Interview',
                  contentDescription: 'Schedule interview',
                  icon: Icons.videocam,
                ),
                MenuItem(
                  id: 'profile',
                  title: 'Profile',
                  contentDescription: 'View profile',
                  icon: Icons.person,
                ),
              ],
              selectedItemId: _selectedItemId,
              onItemClick: (menuItem) {
                setState(() {
                  _selectedItemId = menuItem.id;
                });
                widget.onDismiss();
                switch (menuItem.id) {
                  case 'home':
                    Navigator.pushNamed(context, Screen.landingScreen);
                    break;
                  case 'birthday':
                    //Navigator.pushNamed(context, Screen.invitation);
                    break;
                  case 'interview':
                   // Navigator.pushNamed(context, Screen.basicInterviewScreen);
                    break;
                  case 'profile':
                    //Navigator.pushNamed(context, Screen.profileScreen);
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      color: Colors.grey[200],
      width: double.infinity,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Full Name',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class MenuBody extends StatelessWidget {
  final List<MenuItem> items;
  final TextStyle itemTextStyle;
  final Function(MenuItem) onItemClick;
  final String? selectedItemId;

  const MenuBody({
    super.key,
    required this.items,
    this.itemTextStyle = const TextStyle(fontSize: 18),
    required this.onItemClick,
    this.selectedItemId,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ...items.map((item) => Container(
            color: selectedItemId == item.id ? Colors.grey[200] : Colors.transparent,
            child: ListTile(
              leading: Icon(
                item.icon,
                color: selectedItemId == item.id ? Theme.of(context).primaryColor : Colors.grey[700],
              ),
              title: Text(
                item.title,
                style: itemTextStyle.copyWith(
                  color: selectedItemId == item.id ? Theme.of(context).primaryColor : Colors.black87,
                  fontWeight: selectedItemId == item.id ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              onTap: () => onItemClick(item),
            ),
          )),
          const SizedBox(height: 16),
          Divider(
            indent: 16,
            endIndent: 16,
            color: Colors.grey[300],
            thickness: 1,
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Contact us',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.play_circle_fill, color: Colors.grey[700], size: 30),
                  onPressed: () {
                    // TODO: Implement YouTube link action
                  },
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.grey[700], size: 30),
                  onPressed: () {
                    // TODO: Implement Instagram link action
                  },
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(Icons.call, color: Colors.grey[700], size: 30),
                  onPressed: () {
                    // TODO: Implement call action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
