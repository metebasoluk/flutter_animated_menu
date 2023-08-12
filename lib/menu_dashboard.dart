import 'package:flutter/material.dart';

class MenuDashboard extends StatefulWidget {
  const MenuDashboard({super.key});

  @override
  State<MenuDashboard> createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  late double ekranGenisligi, ekranYuksekligi;
  bool menuAcikmi = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _scaleMenuAnimation;
  final Duration _duration = const Duration(milliseconds: 500);
  late Animation<Offset> _menuOffsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.6).animate(_controller);
    _scaleMenuAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _menuOffsetAnimation = Tween(
            begin: const Offset(-1, 0), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ekranGenisligi = MediaQuery.of(context).size.width;
    ekranYuksekligi = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF343442),
      body: SafeArea(
        child: Stack(
          children: [
            menuOlustur(context),
            dashBoardOlustur(context),
          ],
        ),
      ),
    );
  }

  menuOlustur(BuildContext context) {
    return SlideTransition(
      position: _menuOffsetAnimation,
      child: ScaleTransition(
        scale: _scaleMenuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text('Mesajlar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text('Utility Bills',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text('Branches',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dashBoardOlustur(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      top: 0,
      bottom: 0,
      left: menuAcikmi ? 0.4 * ekranGenisligi : 0,
      right: menuAcikmi ? -0.4 * ekranGenisligi : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius:
              menuAcikmi ? const BorderRadius.all(Radius.circular(40)) : null,
          elevation: 8,
          color: const Color(0xFF343442),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: const Icon(Icons.menu, color: Colors.white),
                        onTap: () {
                          setState(() {
                            if (menuAcikmi) {
                              _controller.reverse();
                            } else {
                              _controller.forward();
                            }
                            menuAcikmi = !menuAcikmi;
                          });
                        },
                      ),
                      const Text(
                        'My Cards',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 200,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          color: Colors.blueGrey,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.teal,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.greenAccent,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(
                            Icons.person,
                            color: Colors.blueGrey,
                          ),
                          title: Text(
                            'Öğrenci $index',
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: const Icon(
                            Icons.add,
                            color: Colors.blueGrey,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: 50)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
