import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tayar_admin_panel/core/networks/error_snackbar.dart';
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Hubs/data/repos/hubs_repo_impl.dart';
import 'package:tayar_admin_panel/features/Hubs/logic/cubit/hub_cubit.dart';
import 'package:tayar_admin_panel/features/Managers/data/models/manager_model/manager_model.dart';
import 'package:tayar_admin_panel/features/home/Ui/home_screen.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class AddHubScreen extends StatefulWidget {
  const AddHubScreen({super.key});

  @override
  AddHubScreenState createState() => AddHubScreenState();
}

class AddHubScreenState extends State<AddHubScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _latController;
  late final TextEditingController _lngController;
  ManagerModel? _selectedManager;
  LatLng? _selectedLocation;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _latController = TextEditingController();
    _lngController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final S s = S.of(context);

    return BlocProvider(
      create: (context) =>
          HubCubit(getIt<HubsRepoImpl>())..fetchManagers(context),
      child: BlocConsumer<HubCubit, HubState>(
        listener: (context, state) {
          if (state is CreateHubSuccess) {
            navigateAndFinish(context, const HomeScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(s.addHub, style: TextStyles.headings),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * 0.05),
                          SizedBox(
                            width: size.width < 700 ? size.width * 0.9 : 700,
                            child: defaultFormField(
                              controller: _nameController,
                              type: TextInputType.name,
                              onSubmit: () {},
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return s.pleaseEnterHubName;
                                }
                                return null;
                              },
                              label: s.hubName,
                              prefix: Icons.person,
                              context: context,
                            ),
                          ),
                          SizedBox(height: size.height * 0.05),
                          SizedBox(
                            width: size.width < 700 ? size.width * 0.9 : 700,
                            child: DropdownButtonFormField<ManagerModel>(
                              value: _selectedManager,
                              hint: Text(s.selectHubManager),
                              items: context
                                  .read<HubCubit>()
                                  .managers
                                  .map((manager) {
                                return DropdownMenuItem<ManagerModel>(
                                  value: manager,
                                  child: Text(manager.name!),
                                );
                              }).toList(),
                              onChanged: (ManagerModel? value) {
                                setState(() {
                                  _selectedManager = value;
                                });
                              },
                              validator: (ManagerModel? value) {
                                if (value == null) {
                                  return s.selectHubManagerValidation;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: s.hubManager,
                                prefixIcon: const Icon(Icons.work),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.05),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.prussianBlue, width: 4),
                                borderRadius: BorderRadius.circular(10)),
                            width: size.width < 1200 ? size.width * 0.9 : 1200,
                            height: 600, // Set a fixed height for the map
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FlutterMap(
                                mapController: _mapController,
                                options: MapOptions(
                                  onTap: (tapPosition, point) {
                                    setState(() {
                                      _selectedLocation = point;
                                      _latController.text = "${point.latitude}";
                                      _lngController.text =
                                          "${point.longitude}";
                                    });
                                  },
                                  initialCenter: const LatLng(
                                      30.059770120241655, 31.246124613945796),
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
                                    labelText: s.latitude,
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
                                    labelText: s.longitude,
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
                            text: s.moveCamera,
                            context: context,
                            width:
                                size.width * 0.2 > 300 ? 300 : size.width * 0.2,
                          ),
                          SizedBox(height: size.height * 0.05),
                          if (state is! CreateHubLoading)
                            defaultButton(
                              width: size.width < 700 ? size.width * 0.9 : 700,
                              function: () {
                                if (_formKey.currentState!.validate() &&
                                    _selectedManager != null &&
                                    _selectedLocation != null) {
                                  context.read<HubCubit>().createHub(
                                        context,
                                        _nameController.text,
                                        _selectedManager!.id!,
                                        _selectedLocation!.latitude,
                                        _selectedLocation!.longitude,
                                      );
                                } else if (_selectedLocation == null) {
                                  showErrorSnackbar(
                                      context, s.selectHubLocation);
                                }
                              },
                              context: context,
                              text: s.addHub,
                            ),
                          if (state is CreateHubLoading)
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          SizedBox(height: size.height * 0.05),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
