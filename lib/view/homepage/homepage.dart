import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:weight_traker/utils/constants/colors.dart';
import 'package:weight_traker/utils/constants/helpers.dart';
import 'package:weight_traker/utils/constants/screensize.dart';
import 'package:weight_traker/utils/constants/textstyle.dart';
import 'package:weight_traker/view/sideNav/sideNav.dart';
import 'package:weight_traker/view/widget/generalButton.dart';
import 'package:weight_traker/view/widget/text_form.dart';

import 'homepage_vm.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final formKey = GlobalKey<FormState>();
  String weight;
  TextEditingController weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomepageVm>.withConsumer(
        viewModelBuilder: () => HomepageVm(),
        onModelReady: (v) {
          v.setName();
        },
        builder: (context, model, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: AppColors.white,
              key: _scaffoldKey,
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                leading: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    size: 25,
                    color: AppColors.primaryColor,
                  ),
                ),
                title: Text('WEIGHT TRACKER',
                    style: titletextStyle, textAlign: TextAlign.center),
                centerTitle: true,
                elevation: 0.9,
              ),
              resizeToAvoidBottomInset: false,
              drawer: SideNavpage(),
              body: Container(
                height: Responsive.height(1, context),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            children: [
                              Text('welcome,',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              customXMargin(10),
                              Text(model.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor)),
                            ],
                          ),
                        ),
                        customYMargin(Responsive.height(0.2, context)),
                        Form(
                          key: formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Enter New Weight',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                ),
                                customYMargin(15),
                                CustomTextFormField(
                                  label: 'Weight',
                                  borderStyle: BorderStyle.solid,
                                  textInputType:
                                      TextInputType.numberWithOptions(),
                                  controller: weightController,
                                  onChanged: (value) {
                                    setState(() {
                                      weight = value;
                                    });
                                  },
                                  validator: (_) {
                                    if (_.isEmpty) {
                                      return '  Enter weight';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                customYMargin(20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: CustomButton(
                                    child: Text('Submit',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white)),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      if (formKey.currentState.validate()) {
                                        if (weight != null) {
                                          print(weight);
                                          model.submitForm(weight);
                                          weightController.clear();
                                        } else {
                                          showFlushBar(
                                              title: "error",
                                              message: 'fill empty fields',
                                              context: context);
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => model.navigateToWeight(),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: Responsive.width(1, context),
                        height: Responsive.height(0.11, context),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue[300],
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: Text(
                          'View Weight Entries',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
