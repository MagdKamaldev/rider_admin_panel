// ignore_for_file: file_names
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
import 'package:tayar_admin_panel/features/roles/UI/roles_screen.dart';
import 'package:tayar_admin_panel/features/settings/Ui/settings_screen.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';
import 'package:tayar_admin_panel/main.dart'; // Import your localization file

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  double railWidth = 72.0; // Default width of the NavigationRail
  final double expandedRailWidth =
      200.0; // Expanded width of the NavigationRail

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      S.of(context).dashboard,
      S.of(context).branches,
      S.of(context).hubs,
      S.of(context).managers,
      S.of(context).franchises,
      S.of(context).riders,
      S.of(context).rolesAndPermissions,
      S.of(context).settings,
    ];
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
              case 6:
                return const RolesAndPermissionsScreen();
              case 7:
                return const SettingsScreen();
              default:
                return const DashboardScreen();
            }
          }

          Size size = MediaQuery.of(context).size;

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
                  toolbarHeight:
                      size.height * 0.2 > 120 ? 120 : size.height * 0.2,
                  backgroundColor: AppColors.prussianBlue,
                  title: Text(
                    titles[HomeCubit.get(context)
                        .selectedIndex], // Use localization
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
                            DrawerHeader(
                              decoration: const BoxDecoration(
                                color: AppColors.prussianBlue,
                              ),
                              child: Text(
                                S.of(context).navigation, // Use localization
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            for (int i = 0; i < titles.length; i++)
                              ListTile(
                                leading: HomeCubit.get(context).screenIcons[i],
                                title: Text(titles[i]), // Use localization
                                selected:
                                    i == HomeCubit.get(context).selectedIndex,
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
                          MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                railWidth = expandedRailWidth;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                railWidth = 72.0;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: railWidth,
                              child: NavigationRail(
                                selectedIndex:
                                    HomeCubit.get(context).selectedIndex,
                                onDestinationSelected: (int index) {
                                  setState(() {
                                    HomeCubit.get(context).selectedIndex =
                                        index;
                                  });
                                },
                                labelType: railWidth > 72.0
                                    ? NavigationRailLabelType.all
                                    : NavigationRailLabelType.none,
                                destinations: List.generate(
                                  titles.length,
                                  (index) => NavigationRailDestination(
                                    icon: HomeCubit.get(context)
                                        .screenIcons[index],
                                    label: railWidth > 72.0
                                        ? Text(
                                            titles[index]) // Use localization
                                        : const Text(""),
                                  ),
                                ),
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
