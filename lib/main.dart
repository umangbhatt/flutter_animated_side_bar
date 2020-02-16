import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color.fromRGBO(32, 33, 36, 1.0),
        appBarTheme: AppBarTheme(),
        primarySwatch: Colors.blue,
        primaryColor: Color.fromRGBO(48, 49, 52, 1.0),
        accentColor: Color(int.parse('0xff2399CC')),
        iconTheme: IconThemeData(color: Colors.white)),
    home: MainScreen()));

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 500);
  AnimationController _controller;

  AppBar appBar = AppBar();
  double borderRadius = 0.0;

  int _navBarIndex = 0;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {
        _navBarIndex = tabController.index;
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return WillPopScope(
      onWillPop: () async {
        if (!isCollapsed) {
          setState(() {
            _controller.reverse();
            borderRadius = 0.0;
            isCollapsed = !isCollapsed;
          });
          return false;
        } else
          return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: <Widget>[
            menu(context),
            AnimatedPositioned(
                left: isCollapsed ? 0 : 0.6 * screenWidth,
                right: isCollapsed ? 0 : -0.2 * screenWidth,
                top: isCollapsed ? 0 : screenHeight * 0.1,
                bottom: isCollapsed ? 0 : screenHeight * 0.1,
                duration: duration,
                curve: Curves.fastOutSlowIn,
                child: dashboard(context)),
          ],
        ),
      ),
    );
  }

  Widget menu(context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Menu item 1',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: 10),
                Text(
                  'Menu item 2',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: 10),
                Text(
                  'Menu item 3',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: 10),
                Text(
                  'Menu item 4',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: 10),
                Text(
                  'Menu item 5',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
    // ),
    // )
  }

  Widget dashboard(context) {
    return SafeArea(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        type: MaterialType.card,
        animationDuration: duration,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Dashboard'),
              leading: IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _controller,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isCollapsed) {
                        _controller.forward();

                        borderRadius = 16.0;
                      } else {
                        _controller.reverse();

                        borderRadius = 0.0;
                      }

                      isCollapsed = !isCollapsed;
                    });
                  }),
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius)),
              child: BottomNavigationBar(
                  currentIndex: _navBarIndex,
                  type: BottomNavigationBarType.shifting,
                  onTap: (index) {
                    setState(() {
                      _navBarIndex = index;
                    });
                  },
                  backgroundColor: Theme.of(context).primaryColorDark,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard),
                        title: Text(
                          '.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.explore),
                        title: Text('.',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.notifications),
                        title: Text('.',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle),
                        title: Text('.',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ]),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Container(
                      height: 200,
                      child: PageView(
                        controller: PageController(viewportFraction: 0.8),
                        scrollDirection: Axis.horizontal,
                        pageSnapping: true,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            color: Colors.redAccent,
                            width: 100,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            color: Colors.blueAccent,
                            width: 100,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            color: Colors.greenAccent,
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
