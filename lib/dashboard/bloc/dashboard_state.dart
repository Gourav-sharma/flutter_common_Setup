import '../model/drawer_model.dart';

class DashboardState {

  int? selectedItem;
  bool isExpanded = false;
  bool showSubtitles = false;
  String dropDownValue = "Item 1";
  List<DrawerModel> menuItems ;

  DashboardState({
    this.selectedItem,
    this.isExpanded = false,
    this.showSubtitles = false,
    this.dropDownValue = "Item 1",
    this.menuItems = const [],
  });

  DashboardState copyWith({
    int? selectedItem,
    bool? isExpanded,
    bool? showSubtitles,
    String? dropDownValue,
    List<DrawerModel>? menuItems,
  }) {
    return DashboardState(
      selectedItem: selectedItem ?? this.selectedItem,
      isExpanded: isExpanded ?? this.isExpanded,
      showSubtitles: showSubtitles ?? this.showSubtitles,
      dropDownValue: dropDownValue ?? this.dropDownValue,
      menuItems: menuItems ?? this.menuItems,
    );
  }


  DashboardState clone() {
    return DashboardState(
      selectedItem: selectedItem,
      isExpanded: isExpanded,
      showSubtitles: showSubtitles,
      dropDownValue: dropDownValue,
      menuItems: List<DrawerModel>.from(menuItems),
    );
  }

}
