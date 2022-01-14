import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:weight_traker/utils/constants/colors.dart';
import 'package:weight_traker/utils/constants/helpers.dart';
import 'package:weight_traker/utils/constants/textstyle.dart';
import 'package:weight_traker/view/widget/custom_history_Tile.dart';
import 'weight_history_vm.dart';

class WeightHistory extends StatefulWidget {
  @override
  _WeightHistoryState createState() => _WeightHistoryState();
}

class _WeightHistoryState extends State<WeightHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BookingHistoryVm>.withConsumer(
        viewModelBuilder: () => BookingHistoryVm(),
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    model.pop();
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                title: Text(
                  'Weight Entries',
                  textAlign: TextAlign.center,
                  style: newTitletextStyle,
                ),
                centerTitle: true,
              ),
              body: Container(
                child: StreamBuilder<dynamic>(
                    stream: model.getweight(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data.docs.isEmpty) {
                        print('it has error');
                        return Center(
                          child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'You have no weight entries',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              )),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data.docs.isNotEmpty) {
                        print('it has data');

                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          padding: EdgeInsets.only(top: 8),
                          itemBuilder: (context, i) {
                            var data = snapshot.data.docs[i].data();
                            var id = snapshot.data.docs[i].id;
                            // print(data["dateTime"].toString());
                            return new CustomHistoryTile(
                              weight: data["weight"],
                              id: id,
                              dateTime:
                                  formatDateTime(data["dateTime"].toString())
                                      .toString(),
                              onPressed: () => model.delete(id),
                            );
                          },
                        );
                      } else
                        return Align(
                            alignment: Alignment.center,
                            child: SpinKitFadingCircle(
                              color: AppColors.loadingColor200,
                              size: 50,
                              duration: Duration(seconds: 2),
                            ));
                    }),
              ));
        });
  }
}

class NavItem {
  String title;
  Color color;
  NavItem({this.color, this.title});
}
