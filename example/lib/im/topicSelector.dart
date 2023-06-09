import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:example/utils/toast.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_topic_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_topic_info_result.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:example/i18n/i18n_utils.dart';

typedef OnSelect = Function(List<String> data);
typedef OnSelectItemChange = Function(String groupID);

class TopicSelector extends StatefulWidget {
  final OnSelect onSelect;
  final bool switchSelectType;
  final List<String> value;
  final String groupID;
  const TopicSelector(
      {required this.onSelect,
      this.switchSelectType = true,
      required this.value,
      required this.groupID});

  @override
  State<StatefulWidget> createState() => GroupSelectorState();
}

class GroupItem extends StatefulWidget {
  final bool switchSelectType;
  final OnSelectItemChange onSelectItemChange;
  final V2TimTopicInfo info;
  final List<String> selected;
  const GroupItem(
    this.switchSelectType,
    this.info,
    this.selected, {
    required this.onSelectItemChange,
  });

  @override
  State<StatefulWidget> createState() => GroupItemState();
}

class GroupItemState extends State<GroupItem> {
  bool itemSelect = false;
  List<String> selected = List.empty(growable: true);
  @override
  void initState() {
    super.initState();
    setState(() {
      selected = widget.selected;
      itemSelect = widget.selected.contains(widget.info.topicID);
    });
  }

  onItemTap(String groupID, [bool? data]) {
    if (widget.switchSelectType) {
      // 单选
      if (widget.selected.isNotEmpty) {
        String selectedGroupID = widget.selected.first;
        if (selectedGroupID != groupID) {
          Utils.toast(imt("单选只能选一个呀"));
          return;
        }
      }
    }
    if (data != null) {
      setState(() {
        itemSelect = data;
      });
    } else {
      setState(() {
        itemSelect = !itemSelect;
      });
    }
    widget.onSelectItemChange(groupID);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: InkWell(
        onTap: () {
          onItemTap(widget.info.topicID!);
        },
        child: Row(
          children: [
            Checkbox(
              value: itemSelect,
              onChanged: (data) {
                onItemTap(widget.info.topicID!, data);
              },
            ),
            Expanded(
              child: Text("TopicID${widget.info.topicID}"),
            )
          ],
        ),
      ),
    );
  }
}

class GroupList extends StatefulWidget {
  final bool switchSelectType;
  final List<V2TimTopicInfoResult> users;
  final OnSelect onSelect;
  final List<String> value;
  const GroupList(this.switchSelectType, this.users, this.onSelect, this.value);
  @override
  State<StatefulWidget> createState() => GroupListState();
}

class GroupListState extends State<GroupList> {
  @override
  void initState() {
    super.initState();
    setState(() {
      selected = widget.value;
    });
  }

  List<String> selected = List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ListView.builder(
        primary: true,
        shrinkWrap: true,
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          return GroupItem(
            widget.switchSelectType,
            widget.users[index].topicInfo!,
            selected,
            onSelectItemChange: (groupID) {
              if (selected.contains(groupID)) {
                selected.remove(groupID);
              } else {
                selected.add(groupID);
              }
              widget.onSelect(selected);
            },
          );
        },
      ),
    );
  }
}

class GroupSelectorState extends State<TopicSelector> {
  @override
  void initState() {
    super.initState();
    setState(() {
      selected = widget.value;
    });
  }

  List<String> selected = List.empty(growable: true);
  List<V2TimTopicInfoResult> groupList = List.empty();

  Future<List<V2TimTopicInfoResult>?> getTopicInfoList() async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    final res = await TencentImSDKPlugin.v2TIMManager
        .getGroupManager()
        .getTopicInfoList(groupID: widget.groupID, topicIDList: []);
    EasyLoading.dismiss();
    if (res.code != 0) {
      Utils.toastError(res.code, res.desc);
    } else {
      setState(() {
        groupList = res.data!;
      });
      return res.data;
    }
    return null;
  }

  AlertDialog dialogShow(context) {
    String chooseType =
        (widget.switchSelectType ? imt(imt("单选")) : imt(imt("多选")));
    AlertDialog dialog = AlertDialog(
      title: Text("群组选择（$chooseType）"),
      contentPadding: EdgeInsets.zero,
      content: GroupList(widget.switchSelectType, groupList, (data) {
        setState(() {
          selected = data;
        });
      }, selected),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onSelect(selected);
            Navigator.pop(context);
          },
          child: Text(imt(imt("确认"))),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(imt(imt("取消"))),
        ),
      ],
    );
    return dialog;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        List<V2TimTopicInfoResult>? fl = await getTopicInfoList();
        if (fl != null) {
          if (fl.isNotEmpty) {
            showDialog<void>(
              context: context,
              builder: (context) => dialogShow(context),
            );
          } else {
            Utils.toast(imt("请先加入群组"));
          }
        }
      },
      child: Text(imt("选择话题")),
    );
  }
}
