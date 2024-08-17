// ignore_for_file: library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/constants.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Branches/Ui/branches_screen.dart';
import 'package:tayar_admin_panel/features/Dashboard/UI/dashboard_screen.dart';
import 'package:tayar_admin_panel/features/Franchises/UI/franchises_screen.dart';
import 'package:tayar_admin_panel/features/Hubs/UI/hubs_screen.dart';
import 'package:tayar_admin_panel/features/Hubs/data/models/rider_model.dart';
import 'package:tayar_admin_panel/features/Managers/UI/managers_screen.dart';
import 'package:tayar_admin_panel/features/home/logic/cubit/home_cubit.dart';
import 'package:tayar_admin_panel/features/login/Ui/login_screen.dart';
import 'package:tayar_admin_panel/features/riders/Ui/riders_screen.dart';
import 'package:tayar_admin_panel/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          Widget buildBody() {
            switch (HomeCubit.get(context).selectedIndex) {
              case 0:
                return const DashboardScreen();
              case 1:
                return const BranchesScreen();
              case 2:
                return const HubsScreen();
              case 3:
                return const ManagersScreen();
              case 4:
                return const FranchiseScreen();
                case 5:
                return  RidersScreen(riders: [
                  RiderModel(
          id: 1,
          name: 'John Doe',
          userId: 123,
          nationalId: 'NID123456',
          mobileNumber: '123-456-7890',
          hubId: 101,
          isAvailable: true,
          isInShift: false,
          isListening: true,
          queueNo: 5,
          currentOrderId: 2501,
         // imageUrl: 'https://example.com/images/john_doe.jpg',
        ),
        RiderModel(
          id: 2,
          name: 'Jane Smith',
          userId: 124,
          nationalId: 'NID654321',
          mobileNumber: '098-765-4321',
          hubId: 102,
          isAvailable: false,
          isInShift: true,
          isListening: false,
          queueNo: 3,
          currentOrderId: 2502,
        //  imageUrl: 'https://example.com/images/jane_smith.jpg',
        ),
        RiderModel(
          id: 3,
          name: 'Michael Johnson',
          userId: 125,
          nationalId: 'NID789012',
          mobileNumber: '567-890-1234',
          hubId: 103,
          isAvailable: true,
          isInShift: true,
          isListening: true,
          queueNo: 7,
          currentOrderId: 2503,
        //  imageUrl: 'https://example.com/images/michael_johnson.jpg',
        ),
        RiderModel(
          id: 4,
          name: 'Emily Davis',
          userId: 126,
          nationalId: 'NID345678',
          mobileNumber: '234-567-8901',
          hubId: 104,
          isAvailable: true,
          isInShift: false,
          isListening: false,
          queueNo: 1,
          currentOrderId: 2504,
        //  imageUrl: 'https://example.com/images/emily_davis.jpg',
        ),
                ],);
              default:
                return const DashboardScreen();
            }
          }

          return Scaffold(
            appBar: AppBar(
              actions: [IconButton(onPressed: (){
                navigateAndFinish(context, const LoginScreen());
                token = '';
                kTokenBox.delete(kTokenBoxString);
              }, icon: const Icon(Icons.logout))],
              backgroundColor: AppColors.prussianBlue,
              title: Text(
                HomeCubit.get(context)
                    .titles[HomeCubit.get(context).selectedIndex],
                style: TextStyles.headings,
              ),
            ),
            backgroundColor: AppColors.alabster,
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: AppColors.prussianBlue,
                    ),
                    child: Text(
                      'Navigation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  for (int i = 0; i < HomeCubit.get(context).titles.length; i++)
                    ListTile(
                      title: Text(HomeCubit.get(context).titles[i]),
                      selected: i == HomeCubit.get(context).selectedIndex,
                      onTap: () {
                        setState(() {
                          HomeCubit.get(context).selectedIndex = i;
                        });
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ),
            body: buildBody(),
          );
        },
      ),
    );
  }
}
