import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:weight_traker/utils/constants/colors.dart';
import 'package:weight_traker/utils/constants/helpers.dart';
import 'package:weight_traker/utils/constants/screensize.dart';
import 'package:weight_traker/utils/constants/textstyle.dart';
import 'package:weight_traker/view/widget/generalButton.dart';
import 'package:weight_traker/view/widget/text_form.dart';
import 'edit_weight_vm.dart';

class EditWeightForm extends StatefulWidget {
  final String id;
  final String weight;
  EditWeightForm({this.id, this.weight});
  @override
  _EditWeightFormState createState() => _EditWeightFormState();
}

class _EditWeightFormState extends State<EditWeightForm> {
  final formKey = GlobalKey<FormState>();
  String weight;
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    weightController.text = widget.weight;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<EditWeightVm>.withConsumer(
        viewModelBuilder: () => EditWeightVm(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
                  onPressed: () {
                    model.pop();
                  }),
              backgroundColor: AppColors.primaryColor,
              title: Text(
                'Update Weight',
                textAlign: TextAlign.center,
                style: newTitletextStyle,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: Responsive.sizeboxheight(context)),
                            // Align(
                            //   alignment: Alignment.topLeft,
                            //   child: Text('Edit Weight Details',
                            //       style: TextStyle(
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.w600,
                            //           color: Colors.black)),
                            // ),
                            customYMargin(20),
                            CustomTextFormField(
                              label: 'Weight',
                              borderStyle: BorderStyle.solid,
                              textInputType: TextInputType.numberWithOptions(),
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
                            )
                          ]),
                    ),
                  ),
                  customYMargin(50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                      child: Text('Submit',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState.validate()) {
                          if (weight != null) {
                            print(weight);
                            model.submitForm(weight, widget.id);
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
            ),
          );
        });
  }
}
