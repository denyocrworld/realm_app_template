import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String _CLOUDINARY_CLOUD_NAME = "dotz74j1p";
const String _CLOUDINARY_API_KEY = "983354314759691";
const String _CLOUDINARY_UPLOAD_PRESET = "yogjjkoh";

class QFilePicker extends StatefulWidget {
  final String label;
  final String? value;
  final String? hint;
  final String? helper;
  final String? Function(String?)? validator;
  final bool obscure;
  final Function(String) onChanged;
  final List<String> extensions;
  final bool enabled;

  QFilePicker({
    Key? key,
    required this.label,
    this.value,
    this.validator,
    this.hint,
    this.helper,
    required this.onChanged,
    this.obscure = false,
    this.extensions = const ["csv", "pdf", "txt"],
    this.enabled = true,
  }) : super(key: key);

  @override
  State<QFilePicker> createState() => _QFilePickerState();
}

class _QFilePickerState extends State<QFilePicker> {
  String? fileUrl;
  bool loading = false;
  late TextEditingController controller;
  @override
  void initState() {
    fileUrl = widget.value;
    controller = TextEditingController(
      text: widget.value ?? "-",
    );
    super.initState();
  }

  Future<String?> getFileMultiplePlatform() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.extensions,
      allowMultiple: false,
    );
    if (result == null) return null;
    return result.files.first.path;
  }

  Future<String> uploadToCloudinary(String filePath) async {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        File(filePath).readAsBytesSync(),
        filename: "upload.${filePath.split(".").last}",
      ),
      'upload_preset': _CLOUDINARY_UPLOAD_PRESET,
      'api_key': _CLOUDINARY_API_KEY,
    });

    var res = await Dio().post(
      'https://api.cloudinary.com/v1_1/$_CLOUDINARY_CLOUD_NAME/raw/upload',
      data: formData,
    );

    String url = res.data["secure_url"];
    return url;
  }

  browseFile() async {
    if (loading) return;
    String? filePath;

    filePath = await getFileMultiplePlatform();
    if (filePath == null) return;

    loading = true;
    setState(() {});

    fileUrl = await uploadToCloudinary(filePath);

    loading = false;
    setState(() {});

    if (fileUrl != null) {
      widget.onChanged(fileUrl!);
      controller.text = fileUrl!;
    }
    setState(() {});
  }

  viewFile() async {
    String url = fileUrl!; // Replace with your URL
    print(url);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  String? get currentValue {
    return fileUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      margin: EdgeInsets.only(
        bottom: 12.0,
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: FormField(
                    initialValue: false,
                    validator: (value) {
                      return widget.validator!(fileUrl);
                    },
                    enabled: true,
                    builder: (FormFieldState<bool> field) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller,
                              obscureText: widget.obscure,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: widget.label,
                                labelStyle: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                                helperText: widget.helper,
                                hintText: widget.hint,
                                errorText: field.errorText,
                              ),
                              onChanged: (value) {
                                widget.onChanged(value);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 6.0,
                          ),
                          if (widget.enabled)
                            Container(
                              width: 50.0,
                              height: 46.0,
                              margin: const EdgeInsets.only(
                                right: 4.0,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(0.0),
                                  backgroundColor: Colors.grey[500],
                                ),
                                onPressed: () => browseFile(),
                                child: Icon(
                                  Icons.file_upload,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          if (fileUrl != null)
                            Container(
                              width: 50.0,
                              height: 46.0,
                              margin: const EdgeInsets.only(
                                right: 4.0,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(0.0),
                                  backgroundColor: Colors.grey[500],
                                ),
                                onPressed: () => viewFile(),
                                child: Icon(
                                  Icons.remove_red_eye,
                                  size: 24.0,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
              ),
            ],
          ),
          if (loading)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8.0,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Uploading...",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
