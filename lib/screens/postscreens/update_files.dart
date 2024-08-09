import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lcpl_admin/provider/upload_provider.dart';
import 'package:lcpl_admin/reusablewidgets/reusable_button.dart';
import 'package:lcpl_admin/reusablewidgets/reusable_text_field.dart';
import 'package:lcpl_admin/utils/utils.dart';
import 'package:provider/provider.dart';

class UpdateFile extends StatefulWidget {
  final String appBartitle, collection, docId, title, fileName;
  final FileType fileType;
  const UpdateFile(
      {super.key,
      required this.appBartitle,
      required this.collection,
      required this.fileType,
      required this.docId,
      required this.title,
      required this.fileName});

  @override
  State<UpdateFile> createState() => _UpdateFileState();
}

class _UpdateFileState extends State<UpdateFile> {
  final TextEditingController titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<UploadProvider>(
            builder:
                (BuildContext context, UploadProvider value, Widget? child) {
              return GestureDetector(
                onTap: () {
                  if (titleController.text.isEmpty) {
                    Utils.toastMessage(message: 'Please enter title');
                  } else {
                    value.updateFileAndData(
                      collectionPath: widget.collection,
                      title: titleController.text.toString(),
                      context: context,
                      docId: widget.docId,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: value.uploadLoading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.done),
                ),
              );
            },
          )
        ],
        title: Text(widget.appBartitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReusableTextField(
            hintText: 'Title',
            controller: titleController,
            keyboardType: TextInputType.text,
            prefix: const Icon(Icons.title_rounded),
          ),
          const SizedBox(
            height: 20,
          ),
          Consumer<UploadProvider>(
            builder:
                (BuildContext context, UploadProvider value, Widget? child) {
              return Column(
                children: [
                  value.file == null
                      ? Text(
                          textAlign: TextAlign.center,
                          widget.fileName,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      : Text(
                          textAlign: TextAlign.center,
                          value.file!.path.split('/').last,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  ReusableButton(
                      title: 'Pick File',
                      onTap: () {
                        value.pickFile(
                            fileType: widget.fileType,
                           );
                      },
                      loading: value.pickerLoading),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
