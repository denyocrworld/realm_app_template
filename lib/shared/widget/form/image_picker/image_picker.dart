//#TEMPLATE reuseable_image_picker
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const String _CLOUDINARY_CLOUD_NAME = "dotz74j1p";
const String _CLOUDINARY_API_KEY = "983354314759691";
const String _CLOUDINARY_UPLOAD_PRESET = "yogjjkoh";

class QImagePicker extends StatefulWidget {
  final String label;
  final String? value;
  final String? hint;
  final String? helper;
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final List<String> extensions;
  final bool enabled;

  QImagePicker({
    Key? key,
    required this.label,
    this.value,
    this.validator,
    this.hint,
    this.helper,
    required this.onChanged,
    this.extensions = const ["jpg", "png"],
    this.enabled = true,
  }) : super(key: key);

  @override
  State<QImagePicker> createState() => _QImagePickerState();
}

class _QImagePickerState extends State<QImagePicker> {
  String? imageUrl;
  bool loading = false;
  late TextEditingController controller;
  @override
  void initState() {
    imageUrl = widget.value;
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

  Future<String?> getFileAndroidIosAndWeb() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    String? filePath = image?.path;
    if (filePath == null) return null;
    return filePath;
  }

  Future<String> uploadToCloudinary(String filePath) async {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        File(filePath).readAsBytesSync(),
        filename: "upload.jpg",
      ),
      'upload_preset': _CLOUDINARY_UPLOAD_PRESET,
      'api_key': _CLOUDINARY_API_KEY,
    });

    var res = await Dio().post(
      'https://api.cloudinary.com/v1_1/$_CLOUDINARY_CLOUD_NAME/image/upload',
      data: formData,
    );

    String url = res.data["secure_url"];
    return url;
  }

  browseFile() async {
    if (loading) return;

    String? filePath;

    if (!kIsWeb && Platform.isWindows) {
      filePath = await getFileMultiplePlatform();
    } else {
      filePath = await getFileAndroidIosAndWeb();
    }
    if (filePath == null) return;

    loading = true;
    setState(() {});

    imageUrl = await uploadToCloudinary(filePath);

    loading = false;
    setState(() {});

    if (imageUrl != null) {
      widget.onChanged(imageUrl!);
      controller.text = imageUrl!;
    }
    setState(() {});
  }

  String? get currentValue {
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      margin: EdgeInsets.only(
        bottom: 12.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 96.0,
            width: 96.0,
            margin: EdgeInsets.only(
              top: 8.0,
            ),
            decoration: BoxDecoration(
              color: loading ? Colors.blueGrey[400] : null,
              image: loading
                  ? null
                  : DecorationImage(
                      image: NetworkImage(
                        imageUrl == null
                            ? "https://i.ibb.co/S32HNjD/no-image.jpg"
                            : imageUrl!,
                      ),
                      fit: BoxFit.cover,
                    ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16.0,
                ),
              ),
            ),
            child: Visibility(
              visible: loading == true,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Uploading...",
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: FormField(
                initialValue: false,
                validator: (value) {
                  return widget.validator!(imageUrl);
                },
                enabled: true,
                builder: (FormFieldState<bool> field) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
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
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

//#END
