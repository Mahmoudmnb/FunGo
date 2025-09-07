import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../home/methods/place_methods.dart';
import '../../../home/presentation/widgets/custom_text_field.dart';
import '../../models/place_model.dart';

class StorySection extends StatefulWidget {
  final PlaceModel place;
  const StorySection({
    super.key,
    required this.place,
  });

  @override
  State<StorySection> createState() => _StorySectionState();
}

class _StorySectionState extends State<StorySection> {
  late PlaceModel place;
  @override
  void initState() {
    place = widget.place;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text("💬 القصص"),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                Stories? story = await showDialog(
                  context: context,
                  builder: (context) {
                    TextEditingController controller = TextEditingController();
                    TextEditingController imgCon = TextEditingController();
                    GlobalKey<FormState> formKey = GlobalKey<FormState>();
                    XFile? image;
                    bool isLoading = false;
                    return AlertDialog(
                      title: const Text(
                        'اضافة قصة',
                        textAlign: TextAlign.center,
                      ),
                      content: SizedBox(
                        height: 170,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              CustomTextField(
                                  validator: (p0) {
                                    if (p0!.trim().isEmpty) {
                                      return 'لا يمكن أن يكون الحقل فارغاً';
                                    }
                                    return null;
                                  },
                                  hintText: 'ادخل قصة',
                                  controller: controller,
                                  maxLength: 200,
                                  backgroundColor: Colors.white,
                                  height: 50,
                                  width: 250),
                              const SizedBox(height: 10),
                              CustomTextField(
                                  validator: (p0) {
                                    if (p0!.trim().isEmpty) {
                                      return 'لا يمكن أن يكون الحقل فارغاً';
                                    }
                                    return null;
                                  },
                                  prefIcon: IconButton(
                                    onPressed: () async {
                                      try {
                                        image = await ImagePicker().pickImage(
                                            source: ImageSource.gallery);
                                        if (image != null) {
                                          imgCon.text = image!.path;
                                        }
                                      } catch (e) {
                                        log(e.toString());
                                      }
                                    },
                                    icon: const Icon(Icons.image_outlined),
                                  ),
                                  readOnly: true,
                                  hintText: 'اختر صورة',
                                  controller: imgCon,
                                  maxLength: 200,
                                  backgroundColor: Colors.white,
                                  height: 50,
                                  width: 250)
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        StatefulBuilder(
                          builder: (context, setState) => TextButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  isLoading = true;
                                  setState(() {});
                                  Stories? stories = await uploadStory(
                                      controller.text.trim(),
                                      image!,
                                      place.id!,
                                      context);
                                  isLoading = false;
                                  setState(() {});
                                  if (context.mounted) {
                                    Navigator.of(context).pop(stories);
                                  }
                                }
                              },
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('موافق')),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('الغاء'))
                      ],
                    );
                  },
                );
                if (story != null) {
                  place.stories!.add(story);
                  setState(() {});
                }
                // if (_commentController.text.isNotEmpty) {
                //   notifier.addComment(_commentController.text);
                //   _commentController.clear();
                // }
              },
              child: const Text("إضافة قصة"),
            )
          ],
        ),
        ...place.stories!.map((c) => ListTile(
              leading: CircleAvatar(
                onBackgroundImageError: (exception, stackTrace) => const Text(
                  'error',
                  style: TextStyle(color: Colors.black),
                ),
                backgroundImage: NetworkImage(c.image!.first),
              ),
              title: Text(c.userName!),
              subtitle: Text(c.txt!),
            )),
      ],
    );
  }
}
