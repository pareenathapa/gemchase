// import 'package:flutter/material.dart';

// class ProfileBaseView extends StatefulWidget {
//   const ProfileBaseView({super.key});

//   @override
//   State<ProfileBaseView> createState() => _ProfileBaseViewState();
// }

// class _ProfileBaseViewState extends State<ProfileBaseView> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('Profile Screen'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ProfileBaseView extends StatefulWidget {
  const ProfileBaseView({super.key});

  @override
  State<ProfileBaseView> createState() => _ProfileBaseViewState();
}

class _ProfileBaseViewState extends State<ProfileBaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Color(0xffd7ae36),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/person.png'), // Replace with the user's profile image
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Parina Thapa', // Replace with the user's name
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'parina@gmail.com', // Replace with the user's email
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildProfileButton(
              icon: Icons.edit,
              label: 'Edit Profile',
              onTap: () {
                // Navigate to edit profile screen
              },
            ),
            _buildProfileButton(
              icon: Icons.lock,
              label: 'Update Password',
              onTap: () {
                // Navigate to update password screen
              },
            ),
            
            _buildProfileButton(
              icon: Icons.logout,
              label: 'Logout',
              onTap: () {
                // Handle user logout
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Color(0xffd7ae36), minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(icon, size: 28),
        label: Text(
          label,
          style:const TextStyle(
            fontSize: 18,
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}
