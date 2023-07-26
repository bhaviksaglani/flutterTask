import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  TabController? _tabController;
  int selectedTab = 0;
  Map<int, bool> state = {};
  int currentIndex = 0;
  final selectedItemColor = Colors.white;
  final unSelectedItemColor = Colors.black;
  final selectedBackGroundColor = Colors.orange;
  final unselectedBackGroundColor = Colors.white;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    animationController.forward();
  }

  Color _getBgColor(int index) => currentIndex == index
      ? selectedBackGroundColor
      : unselectedBackGroundColor;

  Color _getItemColor(int index) =>
      currentIndex == index ? selectedItemColor : unSelectedItemColor;

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget buildIcon(IconData iconData, String text, int index) => Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Material(
          color: _getBgColor(index),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(iconData),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    color: _getItemColor(index),
                  ),
                ),
              ],
            ),
            onTap: () => _onItemTapped(index),
          ),
        ),
      );
  @override
  void dispose() {
    _tabController?.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150.0), child: appBarWidget()),
      body: listOfSchools(),
      bottomNavigationBar: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey[
              200], // Set the background color for the bottom navigation bar
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(
                  16.0)), // Set rounded corners for the bottom navigation bar
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.blue,
              primaryColor: Colors.pink,
              hoverColor: Colors.amber,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: const TextStyle(color: Colors.yellow))),
          child: bottomNavigationBarWidget(),
        ),
      ),
    );
  }

  Widget bottomNavigationBarWidget() {
    return BottomNavigationBar(
      selectedFontSize: 0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: buildIcon(
            Icons.list_alt,
            'List',
            0,
          ),
          label: "",
        ),
        BottomNavigationBarItem(
            icon: buildIcon(
              Icons.add_a_photo_outlined,
              'add',
              1,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: buildIcon(
              Icons.image_aspect_ratio_sharp,
              'image',
              2,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: buildIcon(
              Icons.check,
              'check',
              3,
            ),
            label: ""),
      ],
      currentIndex: currentIndex,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unSelectedItemColor,
    );
  }

  Widget appBarWidget() {
    return Hero(
      tag: "blueButton",
      child: CircularRevealAnimation(
        minRadius: 0,
        maxRadius: 500,
        centerOffset: Offset(MediaQuery.of(context).size.width / 2, 100),
        animation:
            animation, // Replace 'animation' with your AnimationController
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Content"),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.cloud_download),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(48.0), // Adjust the height as needed
            child: Align(
              alignment: Alignment.centerLeft,
              child: buildTabBar(),
            ),
          ),
        ),
      ),
    );
  }

  Widget listOfSchools() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search Concept',
            suffixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onChanged: (value) {
            // Handle search text changes
          },
        ),
        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: Schools.length,
                itemBuilder: (BuildContext context, int index) {
                  return schoolList(Schools[index], index);
                })),
      ],
    );
  }

  schoolList(SchoolLectures schoolLectures, int index) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 0.1)),
      child: ExpansionTile(
        onExpansionChanged: (value) {
          setState(() {
            state[index] = value;
          });
        },
        leading: const Icon(
          Icons.copyright,
          size: 35,
          color: Colors.black,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                schoolLectures.schoolName,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Flexible(
                  child: LinearProgressIndicator(
                    value: 1,
                    color: Colors.white38,
                    minHeight: 3,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                FittedBox(child: Text("0.0%"))
              ],
            ),
          ],
        ),
        trailing: Container(
            padding: const EdgeInsets.all(2),
            child: state[index] ?? false
                ? const Icon(Icons.keyboard_arrow_up,
                    color: Colors.black, size: 20)
                : const Icon(Icons.keyboard_arrow_down,
                    color: Colors.black, size: 20)),
        children: [schoolContent(schoolLectures)],
      ),
    );
  }

  Widget buildTabBar() {
    return DefaultTabController(
      length: tabBar.length,
      child: FittedBox(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.47,
          child: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            // indicatorSize: TabBarIndicatorSize.label,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 5.0, color: Colors.yellow),
            ),
            onTap: (index) {
              setState(() {
                selectedTab = index;
              });
            },
            tabs: List.generate(
              tabBar.length,
              (index) => tabBarItem(tabBar[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabBarContent() {
    return TabBarView(
      controller: _tabController,
      children: const [
        Center(
          child: Text('Tab 1 content'),
        ),
      ],
    );
  }

  Widget schoolContent(SchoolLectures schoolLectures) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 10),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FittedBox(child: Icon(Icons.smart_display)),
          Flexible(
            child: Text(
              schoolLectures.schoolRobomateTalks,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget tabBarItem(String title) {
    return SizedBox(
      width: 100,
      child: Tab(
          child: FittedBox(
        fit: BoxFit.none,
        child: Text(title,
            style: const TextStyle(
                //  fontFamily: fontLight,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF))),
      )),
    );
  }
}

List<String> tabBar = [
  'Robomate',
];

class SchoolLectures {
  String schoolName;
  String schoolRobomateTalks;
  SchoolLectures({required this.schoolName, required this.schoolRobomateTalks});
}

final List<SchoolLectures> Schools = [
  SchoolLectures(
      schoolName: "Bombay Scottish School",
      schoolRobomateTalks: "Bombay Scottish Robomate Talks"),
  SchoolLectures(
      schoolName: "Jamanabai school",
      schoolRobomateTalks: "Jamanabai Robomate Talks"),
  SchoolLectures(
      schoolName: "JBCN School", schoolRobomateTalks: "JBCN Robomate Talks"),
  SchoolLectures(
      schoolName: "SLN Foundation",
      schoolRobomateTalks: "SLN Foundation Robomate Talks"),
  SchoolLectures(
      schoolName: "Smt Sulochanadevi Singhania School",
      schoolRobomateTalks: "Smt Sulochanadevi Singhania Robomate Talks"),
  SchoolLectures(
      schoolName: "St Peter's School",
      schoolRobomateTalks: "St Peter's Robomate Talks"),
];
