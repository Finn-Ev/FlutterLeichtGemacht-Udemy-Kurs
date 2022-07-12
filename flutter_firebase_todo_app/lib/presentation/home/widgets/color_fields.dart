import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_app/application/todos/detail_form/todo_detail_form_bloc.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo_color.dart';

class ColorFields extends StatelessWidget {
  final TodoColor todoColor;
  const ColorFields({Key? key, required this.todoColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: TodoColor.predefinedColors.length,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final itemColor = TodoColor.predefinedColors[index];
          return InkWell(
            onTap: () => BlocProvider.of<TodoDetailFormBloc>(context).add(
              ColorChanged(color: itemColor),
            ),
            child: Material(
              color: itemColor,
              shape: CircleBorder(
                side: BorderSide(
                  color: todoColor.color == itemColor ? Colors.white : Colors.black,
                  width: 3,
                ),
              ),
              child: const SizedBox(
                width: 60,
                height: 60,
              ),
            ),
          );
        },
      ),
    );
  }
}
