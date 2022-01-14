import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_traker/utils/constants/colors.dart';
import 'package:weight_traker/utils/constants/helpers.dart';
import 'package:weight_traker/view/edit_entries/edit_weight.dart';

// ignore: must_be_immutable

class CustomHistoryTile extends StatelessWidget {
  final String weight;
  final String dateTime;
  final String id;
  final Function onPressed;
  CustomHistoryTile({this.dateTime, this.id, this.weight, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26)]),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Icon(Icons.info_outline,
                    color: AppColors.deepGreen, size: 16),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditWeightForm(
                              id: id,
                              weight: weight,
                            ))),
              ),
              customYMargin(20),
              Text(
                'Weight',
                style: TextStyle(color: AppColors.grey_light, fontSize: 13),
              ),
              Text(
                weight,
                style: TextStyle(color: AppColors.black, fontSize: 16),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                child: Icon(Icons.delete, color: AppColors.red, size: 16),
                onTap: onPressed,
              ),
              customYMargin(20),
              Text(
                'Date',
                style: TextStyle(color: AppColors.grey_light, fontSize: 13),
              ),
              Text(
                dateTime,
                style: TextStyle(color: AppColors.black, fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }
}
