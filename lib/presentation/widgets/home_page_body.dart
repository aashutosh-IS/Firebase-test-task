import 'package:flutter/material.dart';

import 'package:demo_app/presentation/widgets/category_section.dart';

import 'content_section.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({
    super.key,
  });

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            /// Top section to display and swipe between all categories
            CategorySection(),

            ///Bottom section to display the data
            Expanded(
              child: ContentSection(),
            )
          ],
        ),
      ),
    );
  }
}
