import 'package:flutter/material.dart';

class DateFormField extends FormField<DateTime> {
  DateFormField({
    super.key,
    required super.initialValue,
    required String label,
    AutovalidateMode super.autovalidateMode =
        AutovalidateMode.onUserInteraction,
    super.validator,
    required ValueChanged<DateTime> onChanged,
  }) : super(
         builder: (field) {
           final state = field as _DateFormFieldState;
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               InkWell(
                 onTap: () async {
                   final picked = await showDatePicker(
                     context: state.context,
                     initialDate: field.value ?? DateTime.now(),
                     firstDate: DateTime(2000),
                     lastDate: DateTime(2100),
                   );
                   if (picked != null) {
                     field.didChange(picked);
                     onChanged(picked);
                   }
                 },
                 child: InputDecorator(
                   decoration: InputDecoration(
                     labelText: label,
                     border: const OutlineInputBorder(),
                     errorText: field.errorText,
                     suffixIcon: const Icon(Icons.calendar_today),
                   ),
                   child: Text(
                     field.value != null
                         ? '${field.value!.day}/${field.value!.month}/${field.value!.year}'
                         : 'Not set',
                   ),
                 ),
               ),
             ],
           );
         },
       );

  @override
  FormFieldState<DateTime> createState() => _DateFormFieldState();
}

class _DateFormFieldState extends FormFieldState<DateTime> {}
