import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/branch_model.dart';
import 'package:tayar_admin_panel/features/Branches/data/models/franchise_model/franchise_model.dart';
import 'package:tayar_admin_panel/features/Branches/data/repos/branch_repo_impl.dart';
import 'package:tayar_admin_panel/features/Branches/logic/cubit/branch_cubit.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/hub.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class UpdateBranchScreen extends StatefulWidget {
  final BranchModel branch;

  const UpdateBranchScreen({super.key, required this.branch});

  @override
  UpdateBranchScreenState createState() => UpdateBranchScreenState();
}

class UpdateBranchScreenState extends State<UpdateBranchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Hub? _selectedHub;
  FranchiseModel? _selectedFranchise;
  TextEditingController nameController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LatLng? _selectedLocation;
  final MapController _mapController = MapController();
  late final TextEditingController _latController;
  late final TextEditingController _lngController;

  void _updateLocationFromInput() {
    final double? lat = double.tryParse(_latController.text);
    final double? lng = double.tryParse(_lngController.text);
    if (lat != null && lng != null) {
      setState(() {
        _selectedLocation = LatLng(lat, lng);
      });
    }
  }

  void _moveCameraToLocation() {
    _updateLocationFromInput(); // Update location based on the latest input
    if (_selectedLocation != null) {
      _mapController.move(_selectedLocation!, _mapController.camera.zoom);
    }
  }

  @override
  void initState() {
    _latController = TextEditingController();
    _lngController = TextEditingController();
    _latController.text = widget.branch.lat.toString();
    _lngController.text = widget.branch.lng.toString();
    nameController.text = widget.branch.name!;
    adressController.text = widget.branch.address!;
    _selectedLocation = LatLng(
      double.parse(widget.branch.lat.toString()),
      double.parse(widget.branch.lng.toString()),
    );
    
    super.initState();
  }

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) =>
          BranchCubit(getIt<BranchRepoImpl>())..getBranchData(context),
      child: BlocConsumer<BranchCubit, BranchState>(
        listener: (context, state) {
          if (state is UpdateBranchSuccess) {
            navigateAndFinish(context, const HomeScreen());
          }
        },
        builder: (context, state) {
          if (state is GetBranchDataLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is GetBranchDataSuccess) {
            _selectedFranchise = context
                .read<BranchCubit>()
                .franchises
                .firstWhere(
                    (manager) => manager.id == widget.branch.franchiseId);

            _selectedHub = context
                .read<BranchCubit>()
                .hubs
                .firstWhere((element) => element.id == widget.branch.hubId);

            return Scaffold(
              appBar: AppBar(
                title:
                    Text(S.of(context).editBranch, style: TextStyles.headings),
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
                            SizedBox(height: size.height * 0.05),
                            SizedBox(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: defaultFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                onSubmit: () {},
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return S.of(context).pleaseEnterBranchName;
                                  }
                                  return null;
                                },
                                label: S.of(context).branchName,
                                prefix: Icons.store,
                                context: context,
                              ),
                            ),
                            SizedBox(height: size.height * 0.05),
                            SizedBox(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: defaultFormField(
                                controller: adressController,
                                type: TextInputType.name,
                                onSubmit: () {},
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return S
                                        .of(context)
                                        .pleaseEnterBranchAddress;
                                  }
                                  return null;
                                },
                                label: S.of(context).branchAddress,
                                prefix: Icons.location_on,
                                context: context,
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
                                onSubmit: () {},
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return S
                                        .of(context)
                                        .pleaseEnterBranchAddress;
                                  }
                                  return null;
                                },
                                label: S.of(context).password,
                                prefix: Icons.location_on,
                                context: context,
                              ),
                            ),
                            SizedBox(height: size.height * 0.05),
                            SizedBox(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: DropdownButtonFormField<Hub>(
                                value: _selectedHub,
                                hint: Text(S.of(context).selectBranchHub),
                                items:
                                    context.read<BranchCubit>().hubs.map((hub) {
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
                                    return S.of(context).pleaseSelectBranchHub;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: S.of(context).branchHub,
                                  prefixIcon: const Icon(Icons.business),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.05),
                            SizedBox(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: DropdownButtonFormField<FranchiseModel>(
                                value: _selectedFranchise,
                                hint: Text(S.of(context).selectBranchFranchise),
                                items: context
                                    .read<BranchCubit>()
                                    .franchises
                                    .map((franchise) {
                                  return DropdownMenuItem<FranchiseModel>(
                                    value: franchise,
                                    child: Text(franchise.name!),
                                  );
                                }).toList(),
                                onChanged: (FranchiseModel? value) {
                                  setState(() {
                                    _selectedFranchise = value;
                                  });
                                },
                                validator: (FranchiseModel? value) {
                                  if (value == null) {
                                    return S
                                        .of(context)
                                        .pleaseSelectBranchFranchise;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: S.of(context).branchFranchise,
                                  prefixIcon: const Icon(Icons.store),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.05),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.prussianBlue, width: 4),
                                  borderRadius: BorderRadius.circular(10)),
                              width:
                                  size.width < 1200 ? size.width * 0.9 : 1200,
                              height: 600, // Set a fixed height for the map
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FlutterMap(
                                  mapController: _mapController,
                                  options: MapOptions(
                                    onTap: (tapPosition, point) {
                                      setState(() {
                                        _selectedLocation = point;
                                        _latController.text =
                                            "${point.latitude}";
                                        _lngController.text =
                                            "${point.longitude}";
                                      });
                                    },
                                    initialCenter: LatLng(double.parse(widget.branch.lat.toString()), double.parse(widget.branch.lng.toString())),
                                    initialZoom: 14,
                                    maxZoom: 19,
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'com.example.app',
                                      maxNativeZoom: 19,
                                    ),
                                    if (_selectedLocation != null)
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            point: _selectedLocation!,
                                            width: 80,
                                            height: 80,
                                            child: const Icon(
                                              Icons.location_pin,
                                              size: 50,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: size.width * 0.2 > 400
                                      ? 400
                                      : size.width * 0.2,
                                  child: TextFormField(
                                    controller: _latController,
                                    decoration: InputDecoration(
                                      labelText: S.of(context).latitude,
                                      border: const OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) =>
                                        _updateLocationFromInput(),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                SizedBox(
                                  width: size.width * 0.2 > 400
                                      ? 400
                                      : size.width * 0.2,
                                  child: TextFormField(
                                    controller: _lngController,
                                    decoration: InputDecoration(
                                      labelText: S.of(context).longitude,
                                      border: const OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) =>
                                        _updateLocationFromInput(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                            defaultButton(
                              function: _moveCameraToLocation,
                              text: S.of(context).moveCamera,
                              context: context,
                              width: size.width * 0.2 > 300
                                  ? 300
                                  : size.width * 0.2,
                            ),
                            SizedBox(height: size.height * 0.05),
                            if (state is! UpdateBranchLoading)
                              defaultButton(
                                width: size.width * 0.8 < 700
                                    ? size.width * 0.8
                                    : 700,
                                function: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<BranchCubit>().updateBranch(
                                          context,
                                          nameController.text,
                                          adressController.text,
                                          _selectedHub!.id!,
                                          _selectedFranchise!.id!,
                                          widget.branch.id!,
                                          _selectedLocation!.latitude,
                                          _selectedLocation!.longitude,
                                          passwordController.text,
                                        );
                                  }
                                },
                                context: context,
                                text: S.of(context).editBranch,
                              ),
                            if (state is UpdateBranchLoading)
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
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
