import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/api.dart';
import '../constants.dart' as Constants;

class TopNavigation extends StatefulWidget implements PreferredSizeWidget {
  @override
  _TopNavigationState createState() => _TopNavigationState();

  @override
  Size get preferredSize => Size.fromHeight(40);
}

class _TopNavigationState extends State<TopNavigation> {
  Map<String, bool> tabSelected = {
    'new': true,
    'top': false,
    'job': false,
  };

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        color: Constants.tAppBarButtonNavColor,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Constants.tPopupMenu.entries
                .map((tab) => FlatButton(
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Constants.tIcons[tab.key],
                            color: tabSelected[tab.key]
                                ? Colors.white
                                : Colors.black,
                          ),
                          Text(
                            tab.value,
                            style: TextStyle(
                              color: tabSelected[tab.key]
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          tabSelected.forEach((key, value) {
                            tabSelected[key] = false;
                          });
                          tabSelected[tab.key] = true;
                        });
                        Provider.of<ApiProvider>(context, listen: false)
                            .fetchStoriesIds(Constants.endPoints[tab.key]);
                      },
                    ))
                .toList()),
      ),
      preferredSize: Size.fromHeight(50),
    );
  }
}
