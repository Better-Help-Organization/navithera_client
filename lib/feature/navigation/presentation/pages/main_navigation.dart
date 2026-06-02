import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:navithera_client/feature/chat/presentation/pages/chat_list_screen.dart';
//import 'package:navithera_client/feature/chat/presentation/pages/chat_screen.dart';
import 'package:navithera_client/feature/home/presentation/pages/home_screen.dart';
import 'package:navithera_client/feature/tools/presentation/pages/tools_screen.dart';
import 'package:navithera_client/feature/profile/presentation/pages/profile_screen.dart';
import 'package:navithera_client/feature/ai_chat/presentation/pages/ai_chat_screen.dart';
import "package:navithera_client/l10n/app_localizations.dart";

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatListScreen(),
    // const UsersListScreen(),

    // const TherapyScreen(),
    const ToolsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildLottieFloatingActionButton() {
    return Transform.translate(
      offset: const Offset(22, 28), // Adjust these values to fine-tune position
      child: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const AiChatScreen()));
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Lottie.asset(
            'assets/animations/Navi.json',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
            repeat: true,
            animate: true,
          ),
        ),
      ),
    );
    // return Container(
    //   width: 70,
    //   height: 70,
    //   decoration: BoxDecoration(
    //     shape: BoxShape.circle,
    //     // gradient: LinearGradient(
    //     //   colors: [const Color(0xFF66B5A3), const Color(0xFF4A9B8A)],
    //     //   begin: Alignment.topLeft,
    //     //   end: Alignment.bottomRight,
    //     // ),
    //     boxShadow: [
    //       BoxShadow(
    //         color: const Color(0xFF66B5A3).withOpacity(0.3),
    //         blurRadius: 15,
    //         offset: const Offset(0, 5),
    //       ),
    //     ],
    //   ),
    //   child: Material(
    //     color: Colors.transparent,
    //     child: InkWell(
    //       borderRadius: BorderRadius.circular(35),
    //       onTap: () {
    //         Navigator.of(context).push(
    //           MaterialPageRoute(builder: (context) => const AiChatScreen()),
    //         );
    //       },
    //       child: Container(
    //         padding: const EdgeInsets.all(8),
    //         child: Lottie.asset(
    //           'assets/animations/Navi.json',
    //           width: 54,
    //           height: 54,
    //           fit: BoxFit.contain,
    //           repeat: true,
    //           animate: true,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent back button from closing the app
        return false;
      },
      child: Scaffold(
        body: IndexedStack(index: _selectedIndex, children: _screens),
        // floatingActionButton: _buildLottieFloatingActionButton(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF66B5A3),
            unselectedItemColor: Colors.grey,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                activeIcon: Icon(Icons.chat_bubble),
                label: AppLocalizations.of(context)!.myCounslor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_outlined),
                activeIcon: Icon(Icons.grid_view),
                label: AppLocalizations.of(context)!.tools,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
