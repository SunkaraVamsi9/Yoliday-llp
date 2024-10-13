import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> tabs = ["Project", "Saved", "Shared", "Achievement"];
  TextEditingController search = TextEditingController();
  bool searchOperation = false;
  String searchData = '';
  int selectedBar = 0;
  List<String> tabItems = ["Home", "Portfolio", "Input", "Profile"];
  List<String> images = [
    "assests/a.jpg",
    "assests/b.jpg",
    "assests/c.jpg",
    "assests/d.jpg",
    "assests/e.jpg",
    "assests/f.jpg"
  ];
  List<String> titles = ["Python Project", "Java Project", "Flutter Project", "SQL Project", "C Project", "Oracle Project"];
  List<IconData> bar_icons = [Icons.home, Icons.padding, Icons.input_rounded, Icons.person];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: selectedBar == 1
            ? AppBar(
                title: Text("Portfolio",style:TextStyle(fontFamily:"VariableFont",
                )),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications, color: Colors.red),
                  )
                ],
                bottom: TabBar(labelColor:Colors.red,indicatorColor:Colors.red,
                    labelPadding: EdgeInsets.all(2.w),
                    tabs: [for (String i in tabs) Text(i,style:TextStyle(fontFamily:"italic",fontSize:13.5.sp),)]),
              )
            : AppBar(),
        body: selectedBar != 1
            ? Container()
            : TabBarView(children: [body(), Container(), Container(), Container()]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedBar,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (value) => setState(() {
            selectedBar = value;
          }),
          items: [for (int i = 0; i < 4; i++) BottomNavigationBarItem(label: tabItems[i], icon: Icon(bar_icons[i]))],
        ),
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          TextFormField(
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'^[\s]'))],
            onChanged: (value) {
              setState(() {
                searchOperation = value.trim().isNotEmpty;
                searchData = value.trim().toLowerCase();
              });
            },
            controller: search,
            decoration: InputDecoration(
              hintText:"Search a project",
              hintStyle:TextStyle(fontSize:16.sp,color:Colors.grey[500]),
              suffixIcon: Padding(
                padding: EdgeInsets.all(8.w),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.search),
                ),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    if (searchOperation) {
                      if (titles[index].toLowerCase().startsWith(searchData)) {
                        return cardItem(index);
                      } else {
                        return Container();
                      }
                    } else {
                      return cardItem(index);
                    }
                  },
                ),
                Positioned(
                  bottom: 10.h,
                  left: 120.w,
                  child: SizedBox(
                    width: 85.w,
                    height: 40.h,
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.w),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [Icon(Icons.filter_list,color:Colors.white,)
                          ,SizedBox(width:4.w,), Text("Filter",style:TextStyle(color:Colors.white),)],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget cardItem(int index) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8.w, 8.w, 15.w, 8.w),
            child: Container(
              height: 80.h,
              width: 80.w,
              child: Image.asset(images[index]),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titles[index], style: TextStyle(fontFamily:"italic",fontSize: 20.sp)),
              Text("BHASA SUNDA", style: TextStyle(fontFamily:"VariableFont",fontSize: 12.sp)),
              Text("Oleh AI-Baiqi Samaan", style: TextStyle(fontFamily:"VariableFont",fontSize: 12.sp, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
