import 'package:flutter/material.dart';
import 'package:hng/constants/app_strings.dart';
import 'package:hng/ui/shared/text_styles.dart';
import 'package:hng/ui/shared/zuri_appbar.dart';
import '../../../utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'direct_message_text_field_hook.dart';
import 'direct_message_viewmodel.dart';

class DirectMessage extends StatelessWidget {
  final String? username;

  const DirectMessage({Key? key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<DirectMessageViewModel>.reactive(
        viewModelBuilder: () => DirectMessageViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: ZuriAppBar(
                leading: Icons.arrow_back_ios,
                leadingPress: () => model.navigateBack(),
                title: username,
                subtitle: ViewDetails,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {},
                  ),
                ],
                onlineIndicator: true,
                whiteBackground: true),
            body: Padding(
              padding: EdgeInsets.all(size.height * 0.02),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: size.height * 0.15,
                              width: size.height * 0.15,
                              decoration:
                                  const BoxDecoration(color: Colors.grey),
                              child: Image.asset(
                                dummyUserImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      username.toString(),
                                      style: AppTextStyle.darkGreySize16,
                                    ),
                                  ],
                                ),
                                Text(
                                  SoftwareDev,
                                  style: AppTextStyle.darkGreySize16,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '''This is the very beginning of your'''
                                  ''' direct message history with @${username.toString()}. '''
                                  '''Only the two of you are in this conversation, and no one else can join it.''',
                                  style: AppTextStyle.darkGreySize14,
                                ),
                                const SizedBox(height: 10),
                                for (var i = 0; i < 7; i++)
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.08,
                                            width: size.height * 0.08,
                                            child: Image.asset(
                                              dummyUserImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    username.toString(),
                                                    style: AppTextStyle
                                                        .darkGreySize16,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    DateFormat('hh:mm').format(
                                                      DateTime.now(),
                                                    ),
                                                    style: AppTextStyle
                                                        .darkGreySize16,
                                                  )
                                                ],
                                              ),
                                              Text(
                                                PromotedPlaceholder,
                                                style:
                                                    AppTextStyle.darkGreySize16,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: size.height * 0.05,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          const Expanded(
                            child: TextFieldHook(),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera, color: Colors.black),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.file_upload,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
