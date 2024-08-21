import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;


  List<Widget> screenIcons = const [
    Icon(Icons.dashboard),
    Icon(Icons.location_city),
    Icon(Icons.store),
    Icon(Icons.person),
    Icon(Icons.business),
    Icon(Icons.directions_bike),
  ];
}
