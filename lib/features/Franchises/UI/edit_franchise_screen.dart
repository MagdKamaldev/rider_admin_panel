import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Franchises/data/repos/franchise_repo_impl.dart';
import 'package:tayar_admin_panel/features/Franchises/logic/cubit/franchise_cubit.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class UpdateFranchiseScreen extends StatefulWidget {
  final int id;
  final String name;
  const UpdateFranchiseScreen(
      {super.key, required this.id, required this.name});

  @override
  UpdateFranchiseScreenState createState() => UpdateFranchiseScreenState();
}

class UpdateFranchiseScreenState extends State<UpdateFranchiseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameController.text = widget.name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (context) => FranchiseCubit(getIt<FranchiseRepoImpl>()),
        child: BlocConsumer<FranchiseCubit, FranchiseState>(
            listener: (context, state) {
          if (state is UpdateFranchiseSuccess) {
            navigateAndFinish(context, const HomeScreen());
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).updateFranchise,
                  style: TextStyles.headings),
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
                          SizedBox(height: size.height * 0.2),
                          Text(
                            S.of(context).updateFranchise,
                            style: TextStyles.normal,
                          ),
                          SizedBox(height: size.height * 0.1),
                          SizedBox(
                            width:
                                size.width * 0.8 < 700 ? size.width * 0.8 : 700,
                            child: defaultFormField(
                              controller: _nameController,
                              type: TextInputType.name,
                              onSubmit: () {},
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return S.of(context).pleaseEnterFranchiseName;
                                }
                                return null;
                              },
                              label: S.of(context).franchiseName,
                              prefix: Icons.person,
                              context: context,
                            ),
                          ),
                          SizedBox(height: size.height * 0.1),
                          if (state is! UpdateFranchiseLoading)
                            defaultButton(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<FranchiseCubit>()
                                      .updateFranchise(
                                        context,
                                        _nameController.text,
                                        widget.id,
                                      );
                                }
                              },
                              context: context,
                              text: S.of(context).updateFranchise,
                            ),
                          if (state is UpdateFranchiseLoading)
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
        }));
  }
}
