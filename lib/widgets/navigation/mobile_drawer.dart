import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_sense/constants/app_colors.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondaryGreen,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.eco, color: Colors.white, size: 48),
                SizedBox(height: 12),
                Text(
                  'Green Sense',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Every green seed grows a brighter future',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  icon: Icons.home,
                  title: 'Home',
                  route: '/',
                  isActive: currentPath == '/',
                ),
                _DrawerItem(
                  icon: Icons.lightbulb_outline,
                  title: 'Insight Lab',
                  route: '/insight-lab',
                  isActive: currentPath.startsWith('/insight-lab'),
                ),
                _DrawerItem(
                  icon: Icons.eco,
                  title: 'Action Plan',
                  route: '/action-plan',
                  isActive: currentPath.startsWith('/action-plan'),
                ),
                _DrawerItem(
                  icon: Icons.people,
                  title: 'Impact Stories',
                  route: '/impact-stories',
                  isActive: currentPath.startsWith('/impact-stories'),
                ),
                _DrawerItem(
                  icon: Icons.calculate,
                  title: 'Carbon Calculator',
                  route: '/calculator',
                  isActive: currentPath.startsWith('/calculator'),
                ),
                _DrawerItem(
                  icon: Icons.quiz,
                  title: 'Quiz',
                  route: '/quiz',
                  isActive: currentPath.startsWith('/quiz'),
                ),
                _DrawerItem(
                  icon: Icons.emoji_events,
                  title: 'Daily Challenges',
                  route: '/challenges',
                  isActive: currentPath.startsWith('/challenges'),
                ),
                _DrawerItem(
                  icon: Icons.volunteer_activism,
                  title: 'Take the Pledge',
                  route: '/pledge',
                  isActive: currentPath.startsWith('/pledge'),
                ),
                const Divider(),
                _DrawerItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  route: '/about',
                  isActive: currentPath == '/about',
                ),
                _DrawerItem(
                  icon: Icons.contact_mail,
                  title: 'Contact',
                  route: '/contact',
                  isActive: currentPath == '/contact',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  final bool isActive;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.route,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppColors.primaryColor : AppColors.textSecondary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? AppColors.primaryColor : AppColors.textPrimary,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      tileColor: isActive
        ? AppColors.primaryColor.withOpacity(0.1)
        : null,
      onTap: () {
        context.go(route);
        Navigator.pop(context); // Close drawer
      },
    );
  }
}
