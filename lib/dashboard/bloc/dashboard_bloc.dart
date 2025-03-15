import 'dart:developer';

import 'package:bloc_structure/routes/generate_routes.dart';
import 'package:bloc_structure/app_utils/app_logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_bloc/app_bloc.dart';
import '../../common_widget/logout_dialog.dart';
import '../../app_utils/common_util_methods.dart';
import '../../app_utils/notification_handling.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import '../model/drawer_model.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<DrawerModel> menuItems = [];

  DashboardBloc() : super(DashboardState()) {
    on<InitEvent>(_init);
    on<ExpandCollapseEvent>(_expandCollapse);
    on<DrawerSelectItemEvent>(_drawerSelectItem);
    on<SetDropDownValueEvent>(_setDropDownValue);
  }

  void _init(InitEvent event, Emitter<DashboardState> emit) {
   AppLogs.showInfoLogs(AppBloc().state.sprint.toString());
    emit(state.copyWith(selectedItem: 0, menuItems: menuItems));
  }
  void _expandCollapse(ExpandCollapseEvent event, Emitter<DashboardState> emit) {
    emit(state.copyWith(isExpanded: event.isExpanded));
  }

  Future<void> _drawerSelectItem(DrawerSelectItemEvent event, Emitter<DashboardState> emit) async {
    if(event.menuIndex == 0) {
      LogoutDialog.show();
    }else if(event.menuIndex==1) {
    }else if(event.menuIndex==2) {
      AppRouter.goPush(AppRouter.listpage);
    } else if(event.menuIndex==3) {
      AppRouter.goPush(AppRouter.listpage);
    } else if(event.menuIndex==4) {
    }else if(event.menuIndex==5) {
      LogoutDialog.show();
    }
  }

  void _setDropDownValue(SetDropDownValueEvent event, Emitter<DashboardState> emit) {
    emit(state.copyWith(dropDownValue: event.value));
    log(event.value);
  }

  Future<void> loadDrawerItem(List<DrawerModel> menuItems) async {
    menuItems.clear();
    menuItems.add(DrawerModel(title: "Preference",
        route: "/home"));
    menuItems.add(DrawerModel(title: "Settings",
        route: "/profile"));
    menuItems.add(DrawerModel(title: "Events & Activities",
        route: "notification"));
    menuItems.add(DrawerModel(title: "Events History",
        route: "/more_view"));
    menuItems.add(DrawerModel(title: "FAQ",
        route: "/logout"));
    menuItems.add(DrawerModel(title: "Contact Us",
        route: "/logout"));
    scaffoldKey.currentState?.openDrawer();
  }

  Future<void> enableDisableNotification() async {
    NotificationService().shouldSendNotification(
        isNotificationEnabled: await NotificationService().getNotificationStatus()==false?true:false);
  }

  Future<void> showNotification() async {
    if(await NotificationService().getNotificationStatus()){
        NotificationService().showNotification(
          0, 'Simple Notification', 'This is a simple notification', 'test_payload');
    }else{
      CommonUtilMethods.showSnackBar(message: "Notification is disabled");
    }
  }




}
