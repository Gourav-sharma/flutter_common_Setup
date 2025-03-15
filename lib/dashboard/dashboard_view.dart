import 'package:bloc_structure/style_theme/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common_widget/body_widget.dart';
import '../common_widget/side_drawer.dart';
import 'bloc/dashboard_bloc.dart';
import 'package:bloc_structure/dashboard/bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          DashboardBloc()..add(InitEvent()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return _buildPage(context,state);
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context, DashboardState state) {
    final bloc = BlocProvider.of<DashboardBloc>(context);

    return CustomBodyWidget(
      scaffoldKey: bloc.scaffoldKey,
      showAppBar: true,
      extendBodyBehindAppBar: false,
      menuIcon: true,
      statusBarColor: Colors.transparent,
      drawerWidget: SideDrawer(
      menuItems: state.menuItems,
      onItemClick: (index) {
          bloc.add(DrawerSelectItemEvent(menuIndex: index));
      },
      onCloseClick:() {
        bloc.scaffoldKey.currentState?.closeDrawer();
      },
      ),
      menuIconTap: () {
        bloc.loadDrawerItem(state.menuItems);
      },
      child: SingleChildScrollView(
        child: Container(
          width: 100.sw,
          padding: EdgeInsets.only(left: 20.dp, right: 20.dp,top: 20.dp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            ],
          ),
        ),
      ),
    );
  }
}