import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_manager/app/core/ui/styles/text_app.dart';

class InsertDay extends StatelessWidget {
  final DateTime daySelect;
  final Function(DateTime) onDateChanged;

  const InsertDay({
    super.key,
    required this.daySelect,
    required this.onDateChanged,
  });

  _addDay(BuildContext  context){
    // função responsável pela seleção da data
    showDatePicker(
      // retorna algo no futuro
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
    ).then((pickedDate) {
      // função que será chamada na seleção da data
      if (pickedDate == null) {
        return;
      }

      onDateChanged(pickedDate);
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        Expanded(

          child: Text(
            'Data Selecionada: ${DateFormat('dd/MM/y').format(daySelect)}',
            style: context.textApp.textPrimaryLight,
          ),
        ),

        TextButton(
          onPressed: () => _addDay(context), 
          child: Text(
            "Selecionar Data",
            style: context.textApp.textPrimaryLight,
          ))
      ],
    );
  }
}