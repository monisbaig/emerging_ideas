import 'package:emerging_ideas/model/ideas_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/ideas_cubit.dart';
import 'custom_textfield.dart';

class EditDialog extends StatefulWidget {
  final IdeasModel ideasModel;

  const EditDialog({super.key, required this.ideasModel});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController.text = widget.ideasModel.title!;
    descriptionController.text = widget.ideasModel.description!;
    imageController.text = widget.ideasModel.imgLink!;
    emailController.text = widget.ideasModel.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Create Post'),
      content: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Title',
              controller: titleController,
              maxLines: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            CustomTextField(
              labelText: 'Description',
              controller: descriptionController,
              maxLines: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            CustomTextField(
              labelText: 'Email',
              controller: emailController,
              maxLines: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a email';
                }
                return null;
              },
            ),
            CustomTextField(
              labelText: 'Image Link',
              controller: imageController,
              maxLines: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a image link';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            final isValid = formKey.currentState!.validate();
            if (isValid) {
              BlocProvider.of<IdeasCubit>(context).editIdea(
                id: widget.ideasModel.id!,
                title: titleController.text,
                description: descriptionController.text,
                email: emailController.text,
                image: imageController.text,
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
