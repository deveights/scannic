import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes back button if any
        backgroundColor: Colors.transparent, // Invisible background
        foregroundColor: Colors.transparent, // Hides icons/text
        elevation: 0, // Removes shadow
        title: Text(''), // Ensures no title appears
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsetsDirectional.only(top: 50),
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                width: 105,
                height: 105,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 248, 248),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0,
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                      color: const Color.fromARGB(172, 238, 238, 238),
                    ),
                  ],
                ),
                child: Image.asset('assets/images/user.jpg', fit: BoxFit.cover),
              ),
              SizedBox(height: 8),
              Text(
                'Jane Doe',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(minimumSize: Size(300, 50)),
                child: Text('Edit Profile'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildButton('Notifications', Icons.notifications, () {
                      // Handle notifications
                    }),
                    _buildButton('Language', Icons.language, () {
                      // Handle language selection
                    }),
                    SwitchListTile(
                      title: Text('Dark Mode'),
                      secondary: Icon(Icons.dark_mode),
                      value: false,
                      onChanged: (value) {
                        // setState(() {
                        //   isDarkMode = value;
                        // });
                      },
                    ),
                    _buildButton('Settings', Icons.settings, () {
                      // Handle settings
                    }),
                    _buildButton('Log Out', Icons.logout, () {
                      // Handle logout
                    }, isDestructive: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    String title,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.black),
      title: Text(
        title,
        style: TextStyle(color: isDestructive ? Colors.red : Colors.black),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
