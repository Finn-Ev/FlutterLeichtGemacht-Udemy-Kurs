import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_app/application/todos/detail_form/todo_detail_form_bloc.dart';
import 'package:flutter_firebase_todo_app/presentation/home/widgets/color_fields.dart';

class TodoDetailForm extends StatelessWidget {
  TodoDetailForm({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title.';
    }
    _titleController.text = value;
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    _descriptionController.text = value;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoDetailFormBloc, TodoDetailFormState>(
      listenWhen: (previous, current) => previous.isEditing != current.isEditing,
      listener: ((context, state) {
        _titleController.text = state.todo.title;
        _descriptionController.text = state.todo.description;
      }),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            autovalidateMode: state.showErrorMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: ListView(
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  validator: _validateTitle,
                  cursorColor: Colors.white,
                  maxLength: 30,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  validator: _validateDescription,
                  cursorColor: Colors.white,
                  maxLength: 300,
                  minLines: 5,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ColorFields(todoColor: state.todo.color),
              ],
            ),
          ),
        );
      },
    );
  }
}
