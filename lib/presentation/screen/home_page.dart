import 'package:demo_app/const/enums.dart';
import 'package:demo_app/model/category_model.dart';
import 'package:demo_app/presentation/fetch_categories/fetch_categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/home_page_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FetchCategoriesCubit _categoriesCubit;
  @override
  void initState() {
    super.initState();
    _categoriesCubit = context.read<FetchCategoriesCubit>()..fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: StreamBuilder(
        stream: _categoriesCubit.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            FetchCategoriesState state = snapshot.data!;
            if (state.stateStatus == StateStatus.loading) {
              return const Center(
                  child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              ));
            } else if (state.stateStatus == StateStatus.success) {
              return const HomePageBody();
            } else if (state.stateStatus == StateStatus.failure) {
              return Text(
                'Error: ${state.error}',
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
