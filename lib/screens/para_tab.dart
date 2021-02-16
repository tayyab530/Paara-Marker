import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/presentation/app_icons.dart';
import 'package:flutter_firebase_practice/widgets/dropDown.dart';
import 'package:flutter_firebase_practice/widgets/list_para.dart';
import '../services/Db_firestore.dart';

class TabsBar extends StatefulWidget {
  @override
  _TabsBarState createState() => _TabsBarState();
}

class _TabsBarState extends State<TabsBar> with SingleTickerProviderStateMixin {
  TabController _tabController;
  BuildContext scaffoldContext;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('${Platform.operatingSystem}');
    return WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          backgroundColor: Colors.grey[800],
          automaticallyImplyLeading: false,
          title: new Text("Qur'an"),
          actions: [
            FutureBuilder(
              future: db.checkAdmin(),
              initialData: false,
              builder: (ctx, AsyncSnapshot<bool> snapshot) {
                if(snapshot.data == null)
                  return Container();
                return DropDown(snapshot.data,ctx);
              },
            ),
          ],
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.amber,
            tabs: [
              new Tab(
                child: Text("Qur'an 1"),
                icon: new Icon(
                  AppIcons.quran,
                  color: Colors.brown[200],
                ),
              ),
              new Tab(
                child: Text("Qur'an 2"),
                icon: new Icon(
                  AppIcons.quran,
                  color: Colors.brown[200],
                ),
              ),
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          bottomOpacity: 1,
        ),
        body: TabBarView(
          children: [
            new ListOfPara('Quran1'),
            new ListOfPara('Quran2'),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
