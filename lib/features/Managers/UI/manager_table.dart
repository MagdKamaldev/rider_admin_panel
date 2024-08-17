// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Managers/UI/edit_manager_screen.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/manager_model.dart';
import 'package:tayar_admin_panel/features/Managers/data/repos/managers_repo_impl.dart';
import 'package:tayar_admin_panel/features/Managers/logic/cubit/managers_cubit.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';

class ManagersTable extends StatefulWidget {
  const ManagersTable({super.key});

  @override
  ManagersTableState createState() => ManagersTableState();
}

class ManagersTableState extends State<ManagersTable> {
  int _sortColumnIndex = 0;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    final List<ManagerModel> managers = ManagersCubit.get(context).managers;

    // Sort the managers list based on the current sort column and order
    managers.sort((a, b) {
      int result;
      switch (_sortColumnIndex) {
        case 0:
          result = a.name!.compareTo(b.name!);
          break;
        case 1:
          result = a.hubs!.length.compareTo(b.hubs!.length);
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
        (Set<WidgetState> states) {
          return const Color.fromRGBO(241, 243, 249, 1); // Header background color
        },
      ),
      headingRowHeight: 45,
      dataRowHeight: 60,
      columnSpacing: MediaQuery.of(context).size.width / 10,
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            'Name',
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
            'Hubs',
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
            'Created At',
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
            'Updated At',
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
            'Actions',
            style: TextStyles.tableHeadings,
          ),
        ),
      ],
      rows: managers.asMap().entries.map((entry) {
        ManagerModel manager = entry.value;
        final DateTime createdAt = manager.createdAt!;
        final String formattedDate =
            '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
        final String formattedTime =
            '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';
        final String formattedDateTime = '$formattedDate   $formattedTime';

        final DateTime updatedAt = manager.updatedAt!;
        final String formattedUpDate =
            '${updatedAt.year}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}';
        final String formattedUpTime =
            '${updatedAt.hour.toString().padLeft(2, '0')}:${updatedAt.minute.toString().padLeft(2, '0')}';
        final String formattedDateUpTime = '$formattedUpDate   $formattedUpTime';

        return DataRow(
          color: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              return entry.key % 2 == 0
                  ? Colors.white
                  : const Color.fromRGBO(247, 250, 252, 1);
            },
          ),
          cells: [
            DataCell(Text(manager.name!, style: TextStyles.tableRow)),
            DataCell(
              Text(
                manager.hubs!.isEmpty
                    ? "N/A"
                    : '[${manager.hubs!.map((e) => e.name).join(", ")}]',
                style: TextStyles.tableRow,
              ),
            ),
            DataCell(Text(formattedDateTime, style: TextStyles.tableRow)),
            DataCell(Text(formattedDateUpTime, style: TextStyles.tableRow)),
            DataCell(Row(children: [IconButton(onPressed: (){
              navigateTo(context, EditManagerScreen(managerId: manager.id!,));
            }, icon: const Icon(Icons.edit_note,color: Colors.grey,),), const   SizedBox(width: 30,), IconButton(onPressed: (){
              showDialog(context: context, builder: (context){
                return BlocProvider(
                  create: (context)=>ManagersCubit(getIt<ManagersRepoImpl>()),
                  child: BlocBuilder<ManagersCubit,ManagersState>(
                    builder:(context,state)=> AlertDialog(
                      title: const Text("Are you sure you want to delete this manager ?"),
                      actions: [
                        TextButton(onPressed: (){
                          ManagersCubit.get(context).deleteManager(context,manager.id!);
                          navigateAndFinish(context, const HomeScreen());
                        }, child: const Text("Yes")),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: const Text("No")),
                      ],
                    ),
                  ),
                );
              });
            }, icon: const Icon(Icons.delete,color: Colors.red,))],)),
          ],
        );
      }).toList(),
    );
  }
}