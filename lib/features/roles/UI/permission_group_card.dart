import 'package:flutter/material.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/roles/data/models/permission_group_model/permission.dart';
import 'package:tayar_admin_panel/features/roles/data/models/permission_group_model/permission_group_model.dart';

class PermissionGroupCard extends StatefulWidget {
  final PermissionGroupModel group;
  final Function(Permission, bool) onSelectionChanged;
  final Map<int, bool> initialPermissionStates; // Track initial states

  const PermissionGroupCard({
    required this.group,
    required this.onSelectionChanged,
    required this.initialPermissionStates,
    super.key,
  });

  @override
  PermissionGroupCardState createState() => PermissionGroupCardState();
}

class PermissionGroupCardState extends State<PermissionGroupCard> {
  bool isExpanded = false;
  bool groupSwitchValue = false;
  late List<bool> permissionSwitchValues;

  @override
  void initState() {
    super.initState();
    permissionSwitchValues = widget.group.permissions!.map((permission) {
      return widget.initialPermissionStates[permission.id!] ?? false;
    }).toList();
    groupSwitchValue = permissionSwitchValues.every((v) => v);
  }

  void toggleGroupSwitch(bool value) {
    setState(() {
      groupSwitchValue = value;
      for (int i = 0; i < permissionSwitchValues.length; i++) {
        permissionSwitchValues[i] = value;
        widget.onSelectionChanged(
            widget.group.permissions![i], value); // Update each permission
      }
    });
  }

  void togglePermissionSwitch(int index, bool value) {
    setState(() {
      permissionSwitchValues[index] = value;
      groupSwitchValue = permissionSwitchValues.every((v) => v);
      widget.onSelectionChanged(widget.group.permissions![index],
          value); // Update individual permission
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(241, 243, 249, 1),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.group.name!,
                      style: TextStyles.headings.copyWith(
                        color: AppColors.prussianBlue,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.prussianBlue,
                  ),
                  Switch(
                    value: groupSwitchValue,
                    onChanged: toggleGroupSwitch,
                    activeColor: const Color.fromARGB(255, 9, 175, 15),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            const Divider(
              color: AppColors.prussianBlue,
              thickness: 2,
              height: 2,
            ),
          if (isExpanded)
            Column(
              children: [
                for (int index = 0;
                    index < widget.group.permissions!.length;
                    index++) ...[
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.group.permissions![index].name!,
                              style: TextStyles.headings.copyWith(
                                color: AppColors.prussianBlue,
                              ),
                            ),
                          ),
                          Switch(
                            value: permissionSwitchValues[index],
                            onChanged: (value) {
                              togglePermissionSwitch(index, value);
                            },
                            activeColor: const Color.fromARGB(255, 9, 175, 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}
