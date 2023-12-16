//#TEMPLATE reuseable_location_picker
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:realm_app/core.dart';
import 'package:permission_handler/permission_handler.dart';

class QLocationPicker extends StatefulWidget {
  final String id;
  final String? label;
  final String? hint;
  final String? helper;
  final double? latitude;
  final double? longitude;
  final String? Function(double? latitude, double? longitude)? validator;
  final Function(double latitude, double longitude) onChanged;
  final bool enableEdit;

  QLocationPicker({
    Key? key,
    required this.id,
    this.label,
    this.hint,
    this.helper,
    this.latitude,
    this.longitude,
    this.validator,
    required this.onChanged,
    this.enableEdit = true,
  }) : super(key: key);

  @override
  _QLocationPickerState createState() => _QLocationPickerState();
}

class _QLocationPickerState extends State<QLocationPicker> {
  double? latitude;
  double? longitude;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    if (widget.latitude == null || widget.longitude == null) {
      getLocation();
    } else {
      latitude = widget.latitude;
      longitude = widget.longitude;
      loading = false;
    }
  }

  getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;
    loading = false;
    setState(() {});

    widget.onChanged(latitude!, longitude!);
  }

  bool isLocationPicked() {
    if (latitude != null && longitude != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 12.0,
      ),
      child: FormField(
        initialValue: false,
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(latitude, longitude);
          }
          return null;
        },
        enabled: true,
        builder: (FormFieldState<bool> field) {
          return InputDecorator(
            decoration: InputDecoration(
              labelText: widget.label,
              errorText: field.errorText,
              border: InputBorder.none,
              helperText: widget.helper,
              hintText: widget.hint,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      child: loading
                          ? Container(
                              child: Center(
                                child: Text("No location selected"),
                              ),
                            )
                          : AbsorbPointer(
                              absorbing: true,
                              child: MapViewer(
                                latitude: latitude,
                                longitude: longitude,
                              ),
                            ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isLocationPicked())
                        QButton(
                          label: "Select",
                          icon: Icons.location_on,
                          size: sm,
                          onPressed: () async {
                            if (!kIsWeb &&
                                (Platform.isAndroid || Platform.isIOS)) {
                              if (!await Permission.location
                                  .request()
                                  .isGranted) {
                                return;
                              }
                              return;
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExLocationPickerMapView(
                                  id: widget.id,
                                  latitude: latitude,
                                  longitude: longitude,
                                  enableEdit: widget.enableEdit,
                                  onChanged: widget.onChanged,
                                ),
                              ),
                            );

                            setState(() {});
                          },
                        ),
                      SizedBox(
                        height: 12.0,
                      ),
                      if (isLocationPicked())
                        QButton(
                          label: "Change",
                          icon: Icons.location_on,
                          size: sm,
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExLocationPickerMapView(
                                  id: widget.id,
                                  latitude: latitude,
                                  longitude: longitude,
                                  enableEdit: widget.enableEdit,
                                  onChanged: widget.onChanged,
                                ),
                              ),
                            );

                            loading = true;
                            setState(() {});

                            await Future.delayed(Duration(milliseconds: 200));

                            loading = false;
                            setState(() {});
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//#END
