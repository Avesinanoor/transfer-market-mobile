import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Transfer Market',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Halaman Utama'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle),
            title: const Text('Register Player'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/add');
            },
          ),
        ],
      ),
    );
  }
}
