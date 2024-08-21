// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Hubs/UI/edit_hub_screen.dart';
import 'package:tayar_admin_panel/features/Hubs/UI/hub_details_screen.dart';
import 'package:tayar_admin_panel/features/Hubs/data/repos/hubs_repo_impl.dart';
import 'package:tayar_admin_panel/features/Hubs/logic/cubit/hub_cubit.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class HubTable extends StatefulWidget {
  const HubTable({super.key});

  @override
  HubTableState createState() => HubTableState();
}

class HubTableState extends State<HubTable> {
  int _sortColumnIndex = 0;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    final List<Hub> hubs = HubCubit.get(context).hubs;

    // Sort the hubs list based on the current sort column and order
    hubs.sort((a, b) {
      int result;
      switch (_sortColumnIndex) {
        case 0:
          result = a.name!.compareTo(b.name!);
          break;
        case 1:
          result = a.managerName!.compareTo(b.managerName!);
          break;
        case 2:
          result = a.createdAt!.compareTo(b.createdAt!);
          break;
        case 3:
          result = a.updatedAt!.compareTo(b.updatedAt!);
          break;
        default:
          result = 0;
      }
      return _isAscending ? result : -result;
    });

    return DataTable(
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _isAscending,
      dividerThickness: 0.0,
      headingRowColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return const Color.fromRGBO(
              241, 243, 249, 1); // Header background color
        },
      ),
      headingRowHeight: 45,
      dataRowHeight: 60,
      columnSpacing: MediaQuery.of(context).size.width / 10,
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            S.of(context).name,
            style: TextStyles.tableHeadings,
          ),
          onSort: (int columnIndex, bool ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _isAscending = ascending;
            });
          },
        ),
        DataColumn(
          label: Text(
            S.of(context).managerName,
            style: TextStyles.tableHeadings,
          ),
          onSort: (int columnIndex, bool ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _isAscending = ascending;
            });
          },
        ),
        DataColumn(
          label: Text(
            S.of(context).createdAt,
            style: TextStyles.tableHeadings,
          ),
          onSort: (int columnIndex, bool ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _isAscending = ascending;
            });
          },
        ),
        DataColumn(
          label: Text(
            S.of(context).updatedAt,
            style: TextStyles.tableHeadings,
          ),
          onSort: (int columnIndex, bool ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _isAscending = ascending;
            });
          },
        ),
        DataColumn(
          label: Text(
            S.of(context).actions,
            style: TextStyles.tableHeadings,
          ),
        ),
      ],
      rows: hubs.asMap().entries.map((entry) {
        Hub hub = entry.value;
        final DateTime createdAt = hub.createdAt!;
        final String formattedDateTime =
            '${createdAt.toLocal().toIso8601String().split('T').first} ${createdAt.toLocal().toIso8601String().split('T').last.split('.')[0]}';
        final DateTime updatedAt = hub.updatedAt!;
        final String formattedUpdateTime =
            '${updatedAt.toLocal().toIso8601String().split('T').first} ${updatedAt.toLocal().toIso8601String().split('T').last.split('.')[0]}';

        return DataRow(
          color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return entry.key % 2 == 0
                  ? Colors.white
                  : const Color.fromRGBO(247, 250, 252, 1);
            },
          ),
          onLongPress: () {
            navigateTo(context, HubDetails(id: hub.id!));
          },
          cells: [
            DataCell(Text(hub.name!, style: TextStyles.tableRow)),
            DataCell(Text(hub.managerName!, style: TextStyles.tableRow)),
            DataCell(Text(formattedDateTime, style: TextStyles.tableRow)),
            DataCell(Text(formattedUpdateTime, style: TextStyles.tableRow)),
            DataCell(Row(
              children: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, EditHubScreen(hub: hub));
                  },
                  icon: const Icon(Icons.edit_note, color: Colors.grey),
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BlocProvider(
                          create: (context) => HubCubit(getIt<HubsRepoImpl>()),
                          child: BlocBuilder<HubCubit, HubState>(
                            builder: (context, state) => AlertDialog(
                              title: Text(S.of(context).hubDeleteConfirmation),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    HubCubit.get(context)
                                        .deleteHub(context, hub.id!);
                                    navigateAndFinish(
                                        context, const HomeScreen());
                                  },
                                  child: Text(S.of(context).yes),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(S.of(context).no),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            )),
          ],
        );
      }).toList(),
    );
  }
}
