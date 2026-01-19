import 'package:flutter/material.dart';
import 'movie_popular_view.dart';
import 'movie_top_rated_view.dart';
import 'profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  // Lista de pantallas (Equivalente al contenido del TabView)
  final List<Widget> _screens = [
    const MoviePopularView(),
    const MovieTopRatedView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack mantiene el estado (scroll, textos) de cada pestaña
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        // 'fixed' evita animaciones de movimiento si añades más de 3 ítems
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Top Rated', // <-- Faltaba este label, por eso fallaba
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}
