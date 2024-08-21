// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Branches/Ui/edit_branch_screen.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/branch_model.dart';
import 'package:tayar_admin_panel/features/Branches/data/repos/branch_repo_impl.dart';
import 'package:tayar_admin_panel/features/Branches/logic/cubit/branch_cubit.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class BranchTable extends StatefulWidget {
  const BranchTable({super.key});

  @override
  BranchTableState createState() => BranchTableState();
}

class BranchTableState extends State<BranchTable> {
  int _sortColumnIndex = 0;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    final List<BranchModel> branches = BranchCubit.get(context).branches;

    // Sort the branches list based on the current sort column and order
    branches.sort((a, b) {
      int result;
      switch (_sortColumnIndex) {
        case 0:
          result = a.name!.compareTo(b.name!);
          break;
        case 1:
          result = a.address!.compareTo(b.address!);
          break;
        case 2:
          result = a.hubName!.compareTo(b.hubName!);
          break;
        case 3:
          result = a.franchiseName!.compareTo(b.franchiseName!);
          break;
        case 4:
          result = a.createdAt!.compareTo(b.createdAt!);
          break;
        case 5:
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
            S.of(context).columnName,
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
            S.of(context).columnAddress,
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
            S.of(context).columnHub,
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
            S.of(context).columnFranchise,
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
            S.of(context).columnCreatedAt,
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
            S.of(context).columnUpdatedAt,
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
            S.of(context).columnActions,
            style: TextStyles.tableHeadings,
          ),
        ),
      ],
      rows: branches.asMap().entries.map((entry) {
        BranchModel branch = entry.value;
        final DateTime createdAt = branch.createdAt!;
        final String formattedDate =
            '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
        final String formattedTime =
            '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';
        final String formattedDateTime = '$formattedDate   $formattedTime';
        final DateTime updatedAt = branch.updatedAt!;
        final String formattedUpDate =
            '${updatedAt.year}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}';
        final String formattedUpTime =
            '${updatedAt.hour.toString().padLeft(2, '0')}:${updatedAt.minute.toString().padLeft(2, '0')}';
        final String formattedDateUpTime =
            '$formattedUpDate   $formattedUpTime';

        return DataRow(
          color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return entry.key % 2 == 0
                  ? Colors.white
                  : const Color.fromRGBO(247, 250, 252, 1);
            },
          ),
          cells: [
            DataCell(Text(branch.name!, style: TextStyles.tableRow)),
            DataCell(Text(branch.address!, style: TextStyles.tableRow)),
            DataCell(Text(branch.hubName!, style: TextStyles.tableRow)),
            DataCell(Text(branch.franchiseName!, style: TextStyles.tableRow)),
            DataCell(Text(formattedDateTime, style: TextStyles.tableRow)),
            DataCell(Text(formattedDateUpTime, style: TextStyles.tableRow)),
            DataCell(Row(
              children: [
                IconButton(
                  onPressed: () {
                    navigateTo(
                        context,
                        UpdateBranchScreen(
                          branch: branch,
                        ));
                  },
                  icon: const Icon(
                    Icons.edit_note,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return BlocProvider(
                              create: (context) =>
                                  BranchCubit(getIt<BranchRepoImpl>()),
                              child: BlocBuilder<BranchCubit, BranchState>(
                                builder: (context, state) => AlertDialog(
                                  title: Text(S.of(context).confirmDelete),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          BranchCubit.get(context).deleteBranch(
                                              context, branch.id!);
                                          navigateAndFinish(
                                              context, const HomeScreen());
                                        },
                                        child: Text(S.of(context).yes)),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(S.of(context).no)),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            )),
          ],
        );
      }).toList(),
    );
  }
}
