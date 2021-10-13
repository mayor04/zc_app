import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hng/ui/shared/long_button.dart';
import 'package:hng/ui/shared/shared.dart';
import 'package:hng/ui/shared/ui_helpers.dart';
import 'package:hng/ui/shared/zuri_appbar.dart';
import 'package:hng/ui/view/organization/invite_to_organization/invite_via_email/invite_viewmodel.dart';
import 'package:stacked/stacked.dart';

class InvitationSent extends StatelessWidget {
  const InvitationSent({Key? key}) : super(key: key);

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
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/svg_icons/invite.svg',
                  width: 64,
                  height: 64,
                ),
                UIHelper.verticalSpaceLarge,
                Text(
                  "Invitation sent",
                  style: AppTextStyles.body1Bold.copyWith(fontSize: 20),
                ),
                UIHelper.verticalSpaceLarge,
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.email_outlined,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        model.getInvitedMail() ?? '',
                        style: AppTextStyles.body2Bold,
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceLarge,
                Center(
                  child: Text(
                      "Has been invited as a member of zuri chat. They’ll be able to receive and reply in messages by email until they join.",
                      style: AppTextStyles.descriptionStyle
                          .copyWith(color: AppColors.zuriDarkGrey)),
                  // textAlign: TextAlign.center,
                ),
                const Spacer(),
                LongButton(
                  onPressed: () {
                    model.navigateToHome();
                  },
                  label: "Done",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}