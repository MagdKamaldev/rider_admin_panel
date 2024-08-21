// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/franchise_model/franchise_model.dart';
import 'package:tayar_admin_panel/features/Franchises/UI/edit_franchise_screen.dart';
import 'package:tayar_admin_panel/features/Franchises/data/repos/franchise_repo_impl.dart';
import 'package:tayar_admin_panel/features/Franchises/logic/cubit/franchise_cubit.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class FranchiseTable extends StatefulWidget {
  const FranchiseTable({super.key});

  @override
  FranchiseTableState createState() => FranchiseTableState();
}

class FranchiseTableState extends State<FranchiseTable> {
  int _sortColumnIndex = 0;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    final List<FranchiseModel> franchises =
        FranchiseCubit.get(context).franchises;

    // Sort the franchises list based on the current sort column and order
    franchises.sort((a, b) {
      int result;
      switch (_sortColumnIndex) {
        case 0:
          result = a.name!.compareTo(b.name!);
          break;
        case 1:
          String aBranches =
              a.shopBranches != null && a.shopBranches!.isNotEmpty
                  ? a.shopBranches!.map((e) => e.name).join(", ")
                  : "N/A";
          String bBranches =
              b.shopBranches != null && b.shopBranches!.isNotEmpty
                  ? b.shopBranches!.map((e) => e.name).join(", ")
                  : "N/A";
          result = aBranches.compareTo(bBranches);
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
      headingRowColor: WidgetStateProperty.resolveWith<Color>(
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
            S.of(context).branches,
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
      rows: franchises.asMap().entries.map((entry) {
        FranchiseModel franchise = entry.value;
        final DateTime createdAt = franchise.createdAt!;
        final String formattedDate =
            '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
        final String formattedTime =
            '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';
        final String formattedDateTime = '$formattedDate   $formattedTime';
        final DateTime updatedAt = franchise.updatedAt!;
        final String formattedUpDate =
            '${updatedAt.year}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}';
        final String formattedUpTime =
            '${updatedAt.hour.toString().padLeft(2, '0')}:${updatedAt.minute.toString().padLeft(2, '0')}';
        final String formattedDateUpTime =
            '$formattedUpDate   $formattedUpTime';

        return DataRow(
          color: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              return entry.key % 2 == 0
                  ? Colors.white
                  : const Color.fromRGBO(247, 250, 252, 1);
            },
          ),
          cells: [
            DataCell(Text(franchise.name!)),
            DataCell(
              Text(
                franchise.shopBranches != null
                    ? franchise.shopBranches!.isEmpty
                        ? S.of(context).nA
                        : '[${franchise.shopBranches!.map((e) => e.name).join(", ")}]'
                    : S.of(context).nA,
              ),
            ),
            DataCell(Text(formattedDateTime)),
            DataCell(Text(formattedDateUpTime)),
            DataCell(Row(
              children: [
                IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      UpdateFranchiseScreen(
                        id: franchise.id!,
                        name: franchise.name!,
                      ),
                    );
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
                              FranchiseCubit(getIt<FranchiseRepoImpl>()),
                          child: BlocBuilder<FranchiseCubit, FranchiseState>(
                            builder: (context, state) => AlertDialog(
                              title: Text(S.of(context).confirmDelete),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    FranchiseCubit.get(context).deleteFranchise(
                                        context, franchise.id!);
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
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            )),
          ],
        );
      }).toList(),
    );
  }
}
