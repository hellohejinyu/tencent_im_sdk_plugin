import 'package:example/i18n/i18n_utils.dart';
import 'package:example/utils/sdkResponse.dart';
import 'package:flutter/material.dart';

class MarkAllMessageAsRead extends StatefulWidget {
  const MarkAllMessageAsRead({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MarkAllMessageAsReadState();
}

class MarkAllMessageAsReadState extends State<MarkAllMessageAsRead> {
  Map<String, dynamic>? resData;
  markAllMessageAsRead() async {
    // V2TimCallback res = await TencentImSDKPlugin.v2TIMManager
    //     .getMessageManager()
    //     .markAllMessageAsRead();
    // setState(() {
    //   resData = res.toJson();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: markAllMessageAsRead,
                  child: Text(imt("标记所有消息为已读")),
                ),
              )
            ],
          ),
          SDKResponse(resData),
        ],
      ),
    );
  }
}
