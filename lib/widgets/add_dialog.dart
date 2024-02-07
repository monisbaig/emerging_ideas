import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/ideas_cubit.dart';
import '../model/ideas_model.dart';
import 'custom_textfield.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AddDialog({super.key});

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
              final newIdea = IdeasModel(
                title: titleController.text,
                description: descriptionController.text,
                imgLink: imageController.text,
                email: emailController.text,
              );
              BlocProvider.of<IdeasCubit>(context).postIdea(newIdea);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
