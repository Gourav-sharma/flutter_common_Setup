import 'package:bloc_structure/routes/generate_routes.dart';
import 'package:bloc_structure/style_theme/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common_widget/body_widget.dart';
import '../common_widget/custom_container.dart';
import '../common_widget/custom_list_widget.dart';
import '../common_widget/text_widget.dart';
import '../style_theme/color_resource.dart';
import 'bloc/list_page_bloc.dart';
import '../list_page/bloc/list_page_event.dart';
import '../list_page/bloc/list_page_state.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ListPageBloc()..add(InitEvent()),
      child: BlocBuilder<ListPageBloc, ListPageState>(
        builder: (context, state) => _buildPage(context),
      )
    );
  }

  Widget _buildPage(BuildContext context) {

    return CustomBodyWidget(
      showAppBar: true,
      title: "List Page",
      backIcon: true,
      backIconTap: () {
        AppRouter.goBack();
      },
      child: SizedBox(
        width: 100.sw,
       // height: 100.sh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomListWidget(
                  itemCount: 10,
                  separator: true,
                  itemBuilder: (context, index) {
                    return CustomContainer(
                      width: 85.sw,
                      height: 50.dp,
                      margin: EdgeInsets.only(top: 10.dp, bottom: 10.dp, left: 10.dp, right: 10.dp),
                      borderRadius: 10.dp,
                      color: ColorResource.appThemeColor,
                      child: CustomTextWidget(text: "List Item $index", textColor: Colors.white, fontSize: 16.sp,),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

