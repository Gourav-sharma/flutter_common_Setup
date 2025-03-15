import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/change_password_bloc.dart';
import '../bloc/change_password_state.dart';

class ChangepasswordView extends StatelessWidget {
  const ChangepasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ChangepasswordBloc, ChangepasswordState>(
          listener: (context, state) {
            // TODO: implement listener}
          },
          child: Column(
            children: [
              BlocBuilder<ChangepasswordBloc, ChangepasswordState>(
                builder: (context, state) {
                  return Container();
                },
              ),
              BlocSelector<ChangepasswordBloc, ChangepasswordState, dynamic>(
                // TODO: change dynamic type
                selector: (state) {
                  // TODO: return selected state based on the provided state.
                  return state.name;
                },
                builder: (context, state) {
                  // TODO: return widget here based on the selected state.
                  return Text(state.toString());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
