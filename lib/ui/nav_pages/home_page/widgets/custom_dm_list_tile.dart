import 'package:flutter/material.dart';
import 'package:hng/ui/nav_pages/home_page/home_page_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:hng/ui/direct_message/direct_message.dart';

import '../../../shared/colors.dart';

class CustomDMListTile extends ViewModelWidget<HomePageViewModel> {
  final imagelink;
  final userName;
  const CustomDMListTile({
    Key? key,
    this.imagelink,
    this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, HomePageViewModel model) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DirectMessage(username: userName))),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagelink),
            radius: 20.0,
          ),
          const SizedBox(width: 8),
          Text(
            userName,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.greyishColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
      onTap: () {
        model.navigateToDmUser();
      },
    );
  }
}