import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/change_password_bloc.dart';
import 'changepassword_view.dart';

class ChangepasswordPage extends StatelessWidget {
  const ChangepasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => ChangepasswordBloc(), child: const ChangepasswordView());

  }
}
