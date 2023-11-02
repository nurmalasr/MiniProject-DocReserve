import '../utils/colors.dart';
import '../views/article/article_page.dart';
import '../views/home_page.dart';
import '../views/profile_page.dart';
import '../views/report_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/page_bloc.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final bloc = PageBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, int>(
      bloc: bloc,
      builder: (context, state) => Scaffold(
        body: IndexedStack(
          index: state,
          children: const [
            HomePage(),
            ReportPage(),
            ArticlePage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: primaryColor,
          unselectedItemColor: primaryColor.withOpacity(0.6),
          onTap: (index) {
            bloc.changeTab(index);
          },
          currentIndex: state,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Report',
              icon: Icon(Icons.data_usage_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Article',
              icon: Icon(Icons.article_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
