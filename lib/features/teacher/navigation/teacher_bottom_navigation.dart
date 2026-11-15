
import 'package:flutter/material.dart';

class TeacherBottomNavigation extends StatelessWidget {
const TeacherBottomNavigation({
super.key,
required this.currentIndex,
required this.onTap,
});

final int currentIndex;
final ValueChanged<int> onTap;

@override
  Widget build(BuildContext context) {
return BottomNavigationBar(
currentIndex: currentIndex,
onTap: onTap,
items: const [
BottomNavigationBarItem(
icon: Icon(Icons.home),
label: 'Home',
),
BottomNavigationBarItem(
icon: Icon(Icons.assignment),
label: 'Result',
),
BottomNavigationBarItem(
icon: Icon(Icons.person),
label: 'Profile',
),
],
);
}
}