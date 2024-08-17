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
}
