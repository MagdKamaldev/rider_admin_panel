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
import 'package:tayar_admin_panel/features/Managers/UI/managers_screen.dart';
import 'package:tayar_admin_panel/features/home/logic/cubit/home_cubit.dart';
import 'package:tayar_admin_panel/features/login/Ui/login_screen.dart';
import 'package:tayar_admin_panel/features/riders/Ui/riders_screen.dart';
import 'package:tayar_admin_panel/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
                return const RidersScreen();
              default:
                return const DashboardScreen();
            }
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              bool isWideScreen = constraints.maxWidth > 800;

              return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: () {
                        navigateAndFinish(context, const LoginScreen());
                        token = '';
                        kTokenBox.delete(kTokenBoxString);
                      },
                      icon: const Icon(Icons.logout),
                    )
                  ],
                  backgroundColor: AppColors.prussianBlue,
                  title: Text(
                    HomeCubit.get(context)
                        .titles[HomeCubit.get(context).selectedIndex],
                    style: TextStyles.headings,
                  ),
                ),
                backgroundColor: AppColors.alabster,
                drawer: isWideScreen
                    ? null
                    : Drawer(
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
                body: isWideScreen
                    ? Row(
                        children: [
                          NavigationRail(
                            selectedIndex: HomeCubit.get(context).selectedIndex,
                            onDestinationSelected: (int index) {
                              setState(() {
                                HomeCubit.get(context).selectedIndex = index;
                              });
                            },
                            labelType: NavigationRailLabelType.all,
                            destinations: List.generate(
                              HomeCubit.get(context).titles.length,
                              (index) => NavigationRailDestination(
                                icon: HomeCubit.get(context).screenIcons[index], // You can customize this icon
                                label: Text(HomeCubit.get(context).titles[index]),
                              ),
                            ),
                          ),
                          Expanded(child: buildBody()),
                        ],
                      )
                    : buildBody(),
              );
            },
          );
        },
      ),
    );
  }
}