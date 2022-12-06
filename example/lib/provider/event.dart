import 'package:flutter/cupertino.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_application.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_group_change_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_group_member_change_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_group_member_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message_receipt.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_topic_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_full_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_status.dart';

class Event with ChangeNotifier {
  List<Map<String, dynamic>> events = List.empty(growable: true);
  void addEvents(Map<String, dynamic> event) {
    events.add(event);
    notifyListeners();
  }

  void clearEvents() {
    events.clear();
    notifyListeners();
  }

  // initListenr
  void onConnectFailed(int code, String error) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onConnectFailed",
          "code": code,
          "error": error,
        },
      ),
    );
  }

  void onConnectSuccess() {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onConnectSuccess",
        },
      ),
    );
  }

  void onConnecting() {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onConnecting",
        },
      ),
    );
  }

  void onKickedOffline() {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onKickedOffline",
        },
      ),
    );
  }

  void onSelfInfoUpdated(V2TimUserFullInfo info) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onSelfInfoUpdated",
          "info": info.toJson(),
        },
      ),
    );
  }

  void onUserSigExpired() {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onUserSigExpired",
        },
      ),
    );
  }

  // V2TimSimpleMsgListener
  void onRecvC2CCustomMessage(
    String msgID,
    V2TimUserInfo sender,
    String customData,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onRecvC2CCustomMessage",
          "msgID": msgID,
          "sender": sender.toJson(),
          "customData": customData,
        },
      ),
    );
  }

  void onRecvC2CTextMessage(
    String msgID,
    V2TimUserInfo userInfo,
    String text,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onRecvC2CTextMessage",
          "msgID": msgID,
          "userInfo": userInfo.toJson(),
          "text": text,
        },
      ),
    );
  }

  void onRecvGroupCustomMessage(
    String msgID,
    String groupID,
    V2TimGroupMemberInfo sender,
    String customData,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onRecvGroupCustomMessage",
          "msgID": msgID,
          "groupID": groupID,
          "sender": sender.toJson(),
          "customData": customData,
        },
      ),
    );
  }

  void onRecvGroupTextMessage(
    String msgID,
    String groupID,
    V2TimGroupMemberInfo sender,
    String text,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onRecvGroupTextMessage",
          "msgID": msgID,
          "groupID": groupID,
          "sender": sender.toJson(),
          "text": text,
        },
      ),
    );
  }

// V2TimGroupListener
  void onApplicationProcessed(
    String groupID,
    V2TimGroupMemberInfo opUser,
    bool isAgreeJoin,
    String opReason,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onApplicationProcessed",
          "groupID": groupID,
          "opUser": opUser.toJson(),
          "isAgreeJoin": isAgreeJoin,
          "opReason": opReason,
        },
      ),
    );
  }

  void onGrantAdministrator(
    String groupID,
    V2TimGroupMemberInfo opUser,
    List<V2TimGroupMemberInfo> memberList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in memberList) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onGrantAdministrator",
          "groupID": groupID,
          "opUser": opUser.toJson(),
          "memberList": ml,
        },
      ),
    );
  }

  void onGroupAttributeChanged(
    String groupID,
    Map<String, String> groupAttributeMap,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onGroupAttributeChanged",
          "groupID": groupID,
          "groupAttributeMap": groupAttributeMap,
        },
      ),
    );
  }

  void onGroupCreated(groupID) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onGroupCreated",
          "groupID": groupID,
        },
      ),
    );
  }

  void onGroupDismissed(
    String groupID,
    V2TimGroupMemberInfo opUser,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onGroupDismissed",
          "groupID": groupID,
          "opUser": opUser.toJson(),
        },
      ),
    );
  }

  void onGroupInfoChanged(
    String groupID,
    List<V2TimGroupChangeInfo> changeInfos,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in changeInfos) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onGroupInfoChanged",
          "groupID": groupID,
          "changeInfos": ml,
        },
      ),
    );
  }

  void onGroupRecycled(
    String groupID,
    V2TimGroupMemberInfo opUser,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onGroupRecycled",
          "groupID": groupID,
          "opUser": opUser.toJson(),
        },
      ),
    );
  }

  void onMemberEnter(
    String groupID,
    List<V2TimGroupMemberInfo> memberList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in memberList) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onMemberEnter",
          "groupID": groupID,
          "memberList": ml,
        },
      ),
    );
  }

  void onMemberInfoChanged(
    String groupID,
    List<V2TimGroupMemberChangeInfo> v2TIMGroupMemberChangeInfoList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in v2TIMGroupMemberChangeInfoList) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onMemberInfoChanged",
          "groupID": groupID,
          "v2TIMGroupMemberChangeInfoList": ml,
        },
      ),
    );
  }

  void onMemberInvited(
    String groupID,
    V2TimGroupMemberInfo opUser,
    List<V2TimGroupMemberInfo> memberList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in memberList) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onMemberInvited",
          "groupID": groupID,
          "opUser": opUser.toJson(),
          "memberList": ml,
        },
      ),
    );
  }

  void onMemberKicked(
    String groupID,
    V2TimGroupMemberInfo opUser,
    List<V2TimGroupMemberInfo> memberList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in memberList) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onMemberKicked",
          "groupID": groupID,
          "opUser": opUser.toJson(),
          "memberList": ml,
        },
      ),
    );
  }

  void onMemberLeave(
    String groupID,
    V2TimGroupMemberInfo member,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onMemberLeave",
          "groupID": groupID,
          "member": member.toJson(),
        },
      ),
    );
  }

  void onQuitFromGroup(String groupID) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onQuitFromGroup",
          "groupID": groupID,
        },
      ),
    );
  }

  void onReceiveJoinApplication(
    String groupID,
    V2TimGroupMemberInfo member,
    String opReason,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onReceiveJoinApplication",
          "groupID": groupID,
          "member": member.toJson(),
          "opReason": opReason
        },
      ),
    );
  }

  void onReceiveRESTCustomData(
    String groupID,
    String customData,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onReceiveRESTCustomData",
          "groupID": groupID,
          "customData": customData
        },
      ),
    );
  }

  void onRevokeAdministrator(
    String groupID,
    V2TimGroupMemberInfo opUser,
    List<V2TimGroupMemberInfo> memberList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in memberList) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onRevokeAdministrator",
          "groupID": groupID,
          "opUser": opUser.toJson(),
          "memberList": ml,
        },
      ),
    );
  }

  // V2TimAdvancedMsgListener
  void onRecvC2CReadReceipt(
    List<V2TimMessageReceipt> receiptList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in receiptList) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onRecvC2CReadReceipt",
          "receiptList": ml,
        },
      ),
    );
  }

  void onRecvMessageRevoked(String msgID) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onRecvMessageRevoked",
          "msgID": msgID,
        },
      ),
    );
  }

  void onRecvNewMessage(V2TimMessage msg) {
    print("收到消息");
    print(msg.toJson());
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onRecvNewMessage",
          "msg": msg.toJson(),
        },
      ),
    );
  }

  void onSendMessageProgress(
    V2TimMessage message,
    int progress,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onSendMessageProgress",
          "message": message.toJson(),
          "progress": progress,
        },
      ),
    );
  }

  void onRecvMessageReadReceipts(List<V2TimMessageReceipt> data) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in data) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onRecvMessageReadReceipts",
          "data": ml,
        },
      ),
    );
  }

  void onRecvMessageModified(V2TimMessage msg) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onRecvMessageModified",
          "data": msg.toJson(),
        },
      ),
    );
  }

// 信令
  void onInvitationCancelled(
    String inviteID,
    String inviter,
    String data,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onInvitationCancelled",
          "inviteID": inviteID,
          "inviter": inviter,
          "data": data,
        },
      ),
    );
  }

  void onInvitationTimeout(String inviteID, List<String> inviteeList) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onInvitationTimeout",
          "inviteID": inviteID,
          "inviteeList": inviteeList,
        },
      ),
    );
  }

  void onUserStatusChanged(List<V2TimUserStatus> statusList) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in statusList) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {"type": "onUserStatusChanged", "data": ml},
      ),
    );
  }

  void onTopicCreated(String groupID, String topicID) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onTopicCreated",
          "data": Map.from({"groupID": groupID, "topicID": topicID})
        },
      ),
    );
  }

  void onTopicDeleted(String groupID, List<String> topicIDList) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onTopicCronTopicDeletedeated",
          "data": Map.from({"groupID": groupID, "topicIDList": topicIDList})
        },
      ),
    );
  }

  void onTopicInfoChanged(String groupID, V2TimTopicInfo topicInfo) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onTopicInfoChanged",
          "data":
              Map.from({"groupID": groupID, "topicInfo": topicInfo.toJson()})
        },
      ),
    );
  }

  void onConversationGroupCreated(
      String groupName, List<V2TimConversation> conversationList) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onConversationGroupCreated",
          "data": Map.from({
            "groupName": groupName,
            "conversationList": conversationList.map((e) => e.toJson()).toList()
          })
        },
      ),
    );
  }

  void onConversationGroupDeleted(String groupName) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onConversationGroupDeleted",
          "data": Map.from({
            "groupName": groupName,
          })
        },
      ),
    );
  }

  void onConversationGroupNameChanged(String oldName, String newName) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onConversationGroupNameChanged",
          "data": Map.from({
            "oldName": oldName,
            "newName": newName,
          })
        },
      ),
    );
  }

  void onConversationsAddedToGroup(
      String groupName, List<V2TimConversation> conversationList) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onConversationsAddedToGroup",
          "data": Map.from({
            "groupName": groupName,
            "conversationList": conversationList.map((e) => e.toJson()).toList()
          })
        },
      ),
    );
  }

  void onConversationsDeletedFromGroup(
      String groupName, List<V2TimConversation> conversationList) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onConversationsDeletedFromGroup",
          "data": Map.from({
            "groupName": groupName,
            "conversationList": conversationList.map((e) => e.toJson()).toList()
          })
        },
      ),
    );
  }

  void onInviteeAccepted(
    String inviteID,
    String invitee,
    String data,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onInviteeAccepted",
          "inviteID": inviteID,
          "invitee": invitee,
          "data": data,
        },
      ),
    );
  }

  void onInviteeRejected(
    String inviteID,
    String invitee,
    String data,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onInviteeRejected",
          "inviteID": inviteID,
          "invitee": invitee,
          "data": data,
        },
      ),
    );
  }

  void onReceiveNewInvitation(
    String inviteID,
    String inviter,
    String groupID,
    List<String> inviteeList,
    String data,
  ) {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onReceiveNewInvitation",
          "inviteID": inviteID,
          "groupID": groupID,
          "inviter": inviter,
          "inviteeList": inviteeList,
          "data": data,
        },
      ),
    );
  }

  // 会话
  void onConversationChanged(
    List<V2TimConversation> conversationList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in conversationList) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onConversationChanged",
          "conversationList": ml,
        },
      ),
    );
  }

  void onNewConversation(
    List<V2TimConversation> conversationList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in conversationList) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onNewConversation",
          "conversationList": ml,
        },
      ),
    );
  }

  void onFriendApplicationListAdded(
    List<V2TimFriendApplication> friendApplicationList,
  ) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in friendApplicationList) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onFriendApplicationListAdded",
          "friendApplicationList": ml,
        },
      ),
    );
  }

  void onFriendInfoChanged(List<V2TimFriendInfo> data) {
    List<Map<String, dynamic>> ml = List.empty(growable: true);
    for (var element in data) {
      ml.add(element.toJson());
    }
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onFriendInfoChanged",
          "V2TimFriendInfoList": ml,
        },
      ),
    );
  }

  void onSyncServerFailed() {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onSyncServerFailed",
        },
      ),
    );
  }

  void onSyncServerFinish() {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onSyncServerFinish",
        },
      ),
    );
  }

  void onSyncServerStart() {
    addEvents(
      Map<String, dynamic>.from(
        {
          "type": "onSyncServerStart",
        },
      ),
    );
  }
}
