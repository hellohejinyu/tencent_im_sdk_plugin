import 'package:example/i18n/i18n_utils.dart';
import 'package:example/im/conversationSelector.dart';
import 'package:example/im/messageSelector.dart';
import 'package:example/utils/sdkResponse.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:tencent_im_sdk_plugin_platform_interface/enum/get_group_message_read_member_list_filter.dart';
import 'package:tencent_im_sdk_plugin_platform_interface/models/v2_tim_group_message_read_member_list.dart';
import 'package:tencent_im_sdk_plugin_platform_interface/models/v2_tim_value_callback.dart';

class GetGroupMessageReadMemberList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GetGroupMessageReadMemberListState();
}

class GetGroupMessageReadMemberListState
    extends State<GetGroupMessageReadMemberList> {
  Map<String, dynamic>? resData;

  List<String> conversaions = List.empty(growable: true);
  List<String> msgIDs = List.empty(growable: true);
  GetGroupMessageReadMemberListFilter filter =
      GetGroupMessageReadMemberListFilter
          .V2TIM_GROUP_MESSAGE_READ_MEMBERS_FILTER_UNREAD;
  getGroupMessageReadMemberList() async {
    V2TimValueCallback<V2TimGroupMessageReadMemberList> res =
        await TencentImSDKPlugin.v2TIMManager
            .getMessageManager()
            .getGroupMessageReadMemberList(
                filter: filter, messageID: msgIDs.first, count: 1);
    setState(() {
      resData = res.toJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ConversationSelector(
              onSelect: (data) {
                setState(() {
                  conversaions = data;
                });
              },
              switchSelectType: true,
              value: conversaions,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  conversaions.isNotEmpty
                      ? conversaions.toString()
                      : imt("未选择,这里只能选群消息，且非自己发的消息"),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            MessageSelector(
              conversaions.isNotEmpty ? conversaions.first : "",
              msgIDs,
              (data) {
                setState(() {
                  msgIDs = data;
                });
              },
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: 12),
              child: Text(msgIDs.toString()),
            ))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: getGroupMessageReadMemberList,
                child: Text(imt("获取群消息已读（未读）成员列表")),
              ),
            )
          ],
        ),
        Row(
          children: const [
            Text("群已读回执需要先到控制台开通"),
          ],
        ),
        SDKResponse(resData),
      ],
    );
  }
}
