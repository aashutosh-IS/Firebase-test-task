import 'package:demo_app/const/helper.dart';
import 'package:demo_app/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/basic_widgets/custom_text.dart';
import '../widgets/basic_widgets/custom_textfield.dart';

class DetailScreen extends StatefulWidget {
  final SubcategoryModel subCategory;
  const DetailScreen({super.key, required this.subCategory});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  SubcategoryModel get subCategory => widget.subCategory;
  final FocusNode _textFieldFocusNode = FocusNode();
  final TextEditingController _editingController = TextEditingController();
  int i = 1;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              size: 32.0,
            ),
          ),
          actions: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(
                  Icons.star_border,
                  size: 32.0,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          bottom: true,
          child: Form(
            key: formGlobalKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: InkWell(
                      onTap: () {
                        _textFieldFocusNode.unfocus();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              color: Colors.white12,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Colors.white12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0)
                                      .copyWith(bottom: 20.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Image.asset(
                                    HelperClass.fetchAssetsFromSubCategoryName(
                                        subCategory.name),
                                    scale: 2,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  CustomTextWidget(
                                    title: subCategory.name,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  CustomTextWidget(
                                    title: subCategory.description,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white38,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            const CustomTextWidget(
                                title: "What is your paragraph about?*"),
                            const SizedBox(
                              height: 10.0,
                            ),
                            CustomTextField(
                              enabled: true,
                              maxline: 5,
                              textEditingController: _editingController,
                              focusNode: _textFieldFocusNode,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            const Row(
                              children: [
                                CustomTextWidget(title: "Tone of Voice"),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: Colors.white54,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const CustomTextField(
                              enabled: false,
                              maxline: 1,
                              hintText: "Funny",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                ///Bottom section
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 6.0),
                  child: Row(
                    children: [
                      bottomWidget(
                          iconData: Icons.remove,
                          onTap: () {
                            setState(() {
                              i--;
                            });
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "$i",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      bottomWidget(
                          iconData: Icons.add,
                          onTap: () {
                            setState(() {
                              i++;
                            });
                          }),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          if (formGlobalKey.currentState!.validate()) {
                            const snackBar = SnackBar(
                              content: Text('Success '),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {}
                        },
                        child: Container(
                            width: 200,
                            margin: const EdgeInsets.only(left: 20.0),
                            padding: const EdgeInsets.all(14.0),
                            decoration: BoxDecoration(
                                color: Colors.tealAccent,
                                borderRadius: BorderRadius.circular(31.0)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Generate"),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(Icons.arrow_forward_outlined)
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  InkWell bottomWidget(
      {required IconData iconData, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: Center(child: Icon(iconData)),
      ),
    );
  }
}
