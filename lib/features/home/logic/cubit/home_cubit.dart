import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  List<String> titles = [
    'Dashboard',
    'Branches',
    'Hubs',
    'Managers',
    'Franchises',
    "Riders"
  ];

  List<Widget> screenIcons = const[
  Icon(Icons.dashboard),       // Dashboard
  Icon(Icons.location_city),   // Branches (using city icon as an example)
  Icon(Icons.store),           // Hubs (using store icon as an example)
  Icon(Icons.person),          // Managers (using person icon as an example)
  Icon(Icons.business),        // Franchises (using business icon as an example)
  Icon(Icons.directions_bike), // Riders (using bike icon as an example)
];
}
