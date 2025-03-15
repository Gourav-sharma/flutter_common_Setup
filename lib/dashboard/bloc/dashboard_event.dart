import 'package:flutter/material.dart';

abstract class DashboardEvent {}

class InitEvent extends DashboardEvent {}

class SelectItemEvent extends DashboardEvent {
  final int itemId;
  final BuildContext context;

  SelectItemEvent(this.itemId, this.context);
}

class DrawerSelectItemEvent extends DashboardEvent {
  final int menuIndex;
  DrawerSelectItemEvent({required this.menuIndex});
}

class SetDropDownValueEvent extends DashboardEvent {
  final String value;
  SetDropDownValueEvent(this.value);
}

class ExpandCollapseEvent extends DashboardEvent {

  final bool isExpanded;
  ExpandCollapseEvent(this.isExpanded);

}