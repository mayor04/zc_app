import 'package:flutter/material.dart';
import 'package:hng/ui/shared/shared.dart';
import 'package:hng/ui/shared/text_styles.dart';
import 'package:hng/ui/shared/zuri_appbar.dart';
import 'package:hng/ui/view/organization/invite_to_organization/invite_viewmodel.dart';
import 'package:stacked/stacked.dart';

class InviteViaEmailAdmin extends StatelessWidget {
  const InviteViaEmailAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InviteViewModel>.reactive(
      viewModelBuilder: () => InviteViewModel(),
      builder: (BuildContext context, InviteViewModel model, Widget? children) {
        return Scaffold(
          appBar: ZuriAppBar(
            leading: Icons.close,
            leadingPress: () {
              model.navigateBack();
            },
            whiteBackground: true,
            orgTitle: Text(
              'Invite',
              style: AppTextStyle.darkGreySize18Bold,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 20.0, 0.0),
                child: InkWell(
                    child: Text(
                      "Send",
                      style: AppTextStyle.greenSize14,
                    ),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {}),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Know any coworkers who should join zuri chat?",
                    style: AppTextStyle.darkGreySize14,
                  ),
                ),
                UIHelper.verticalSpaceLarge,
                Container(
                  color: AppColors.whiteColor,
                  child: TextField(
                    cursorColor: AppColors.zuriPrimaryColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),
                      labelText: "Add an Email Address",
                      border: border(),
                      focusedBorder: border(),
                      enabledBorder: border(),
                    ),
                  ),
                ),
                UIHelper.verticalSpaceLarge,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.whiteColor,
                  ),
                  onPressed: () {
                    model.navigateToContacts();
                  },
                  child: const ListTile(
                    leading: Icon(Icons.person_sharp),
                    title: Text("Invite from contacts"),
                  ),
                ),
                UIHelper.verticalSpaceLarge,
                SizedBox(
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(
                          Icons.link_sharp,
                        ),
                        title: Text("Share your invite link"),
                      ),
                      UIHelper.horizontalSpaceSmall,
                      const Text(
                          "To change the expiry date, deactivate your link and \n choose a new duration."),
                      const Divider(),
                      GestureDetector(
                          onTap: () {}, child: const Text("Deactivate link")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

OutlineInputBorder border({Color? color}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey[300] ?? AppColors.greyColor,
    ),
    borderRadius: BorderRadius.circular(4),
  );
}
