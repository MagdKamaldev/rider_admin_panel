// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/features/riders/data/repos/riders_repo_impl.dart';
import 'package:tayar_admin_panel/features/riders/logic/cubit/rider_cubit.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class AddRiderScreen extends StatefulWidget {
  const AddRiderScreen({super.key});

  @override
  AddRiderScreenState createState() => AddRiderScreenState();
}

class AddRiderScreenState extends State<AddRiderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<String> hubs = []; // Replace with actual hub data source

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (context) => RiderCubit(getIt<RiderRepoImpl>()),
        child: BlocConsumer<RiderCubit, RiderState>(listener: (context, state) {
          if (state is AddRiderSuccess) {
            navigateAndFinish(context, const HomeScreen());
          }
        }, builder: (context, state) {
          if (state is FetchHubsLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            hubs = context
                .read<RiderCubit>()
                .hubs
                .map((hub) => hub.name!)
                .toList();
            return Scaffold(
              appBar: AppBar(
                title: Text(S.of(context).addRider, style: TextStyles.headings),
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
                              child: defaultFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return S.of(context).pleaseEnterRiderName;
                                  }
                                  return null;
                                },
                                label: S.of(context).riderName,
                                prefix: Icons.person,
                                context: context,
                                onSubmit: () {},
                              ),
                            ),
                            SizedBox(height: size.height * 0.05),
                            SizedBox(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: defaultFormField(
                                controller: nationalIdController,
                                type: TextInputType.number,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return S
                                        .of(context)
                                        .pleaseEnterRiderNationalId;
                                  }
                                  return null;
                                },
                                label: S.of(context).riderNationalId,
                                prefix: Icons.credit_card,
                                context: context,
                                onSubmit: () {},
                              ),
                            ),
                            SizedBox(height: size.height * 0.05),
                            SizedBox(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: defaultFormField(
                                controller: mobileNumberController,
                                type: TextInputType.phone,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return S
                                        .of(context)
                                        .pleaseEnterRiderPhoneNumber;
                                  }
                                  return null;
                                },
                                label: S.of(context).riderPhoneNumber,
                                prefix: Icons.phone,
                                context: context,
                                onSubmit: () {},
                              ),
                            ),
                            SizedBox(height: size.height * 0.05),
                            SizedBox(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: defaultFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return S
                                        .of(context)
                                        .pleaseEnterRiderPassword;
                                  }
                                  return null;
                                },
                                label: S.of(context).riderPassword,
                                prefix: Icons.lock,
                                context: context,
                                onSubmit: () {},
                              ),
                            ),
                            SizedBox(height: size.height * 0.1),
                            if (state is! AddRiderLoading)
                              defaultButton(
                                width: size.width * 0.8 < 700
                                    ? size.width * 0.8
                                    : 700,
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<RiderCubit>().addRider(
                                          nameController.text,
                                          nationalIdController.text,
                                          mobileNumberController.text,
                                          passwordController.text,
                                        );
                                  }
                                },
                                context: context,
                                text: S.of(context).addRider,
                              ),
                            if (state is AddRiderLoading)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                            SizedBox(height: size.height * 0.1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }));
  }
}
