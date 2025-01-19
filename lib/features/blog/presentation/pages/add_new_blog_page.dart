import 'dart:io';

import 'package:blogapp/core/theme/app_color.dart';
import 'package:blogapp/core/utils/image_picker.dart';
import 'package:blogapp/features/blog/presentation/widgets/blog_textfiled_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];

  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: selectImage,
                        child: SizedBox(
                          height: 150,
                          // width: double.infinity,
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: DottedBorder(
                        dashPattern: const [10, 4],
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        color: AppPallete.borderColor,
                        child: const SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Select your image',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology',
                    'Business',
                    'Programming',
                    'Entertainment',
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedTopics.contains(e)) {
                                selectedTopics.remove(e);
                              } else {
                                selectedTopics.add(e);
                              }
                              setState(() {});
                            },
                            child: Chip(
                              color: selectedTopics.contains(e)
                                  ? const WidgetStatePropertyAll(
                                      AppPallete.gradient1)
                                  : null,
                              label: Text(e),
                              side: selectedTopics.contains(e)
                                  ? null
                                  : const BorderSide(
                                      color: AppPallete.borderColor,
                                    ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomBlogTextField(
                controller: titleController,
                hintText: 'Blog Title',
              ),
              const SizedBox(
                height: 15,
              ),
              CustomBlogTextField(
                controller: contentController,
                hintText: 'Blog content',
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
