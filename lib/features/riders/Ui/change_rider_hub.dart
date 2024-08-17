// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/features/riders/data/repos/riders_repo_impl.dart';
import 'package:tayar_admin_panel/features/riders/logic/cubit/rider_cubit.dart';

//make an add rider screen that takes a hub which is selected and name and national id and mobile number and make it like :
class ChangeRiderHubScreen extends StatefulWidget {
  final int riderId;
  const ChangeRiderHubScreen({super.key, required this.riderId});

  @override
  ChangeRiderHubScreenState createState() => ChangeRiderHubScreenState();
}

class ChangeRiderHubScreenState extends State<ChangeRiderHubScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Hub? _selectedHub;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => RiderCubit(getIt<RiderRepoImpl>())..fetchHubs(),
      child: BlocConsumer<RiderCubit, RiderState>(
        listener: (context, state) {
          if (state is ChangeRiderHubSuccess) {
            navigateAndFinish(context, const HomeScreen());
          }
        },
        builder: (context, state) {
          if (state is FetchHubsLoading) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text("Add Rider", style: TextStyles.headings),
              ),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Form(
                      key: _formKey,
                      child: SizedBox(
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height * 0.1),
                            SizedBox(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: DropdownButtonFormField<Hub>(
                                value: _selectedHub,
                                hint: const Text("Select Rider Hub"),
                                items:
                                    context.read<RiderCubit>().hubs.map((hub) {
                                  return DropdownMenuItem<Hub>(
                                    value: hub,
                                    child: Text(hub.name!),
                                  );
                                }).toList(),
                                onChanged: (Hub? value) {
                                  setState(() {
                                    _selectedHub = value;
                                  });
                                },
                                validator: (Hub? value) {
                                  if (value == null) {
                                    return "Please select a Rider hub!";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: "Rider Hub",
                                  prefixIcon: Icon(Icons.business),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.1),
                            if (state is! ChangeRiderHubLoading)
                              defaultButton(
                                width: size.width * 0.8 < 700
                                    ? size.width * 0.8
                                    : 700,
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<RiderCubit>().changeRiderHub(widget.riderId, _selectedHub!.id!
                                        );
                                  }
                                },
                                context: context,
                                text: "Add Rider",
                              ),
                            if (state is ChangeRiderHubLoading)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
