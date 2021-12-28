import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'text.dart';

///THIS WIDGET IS USED TO CREATE A TEXT FIELD WITH A LABEL AND A VALIDATION INDICATOR
class TxtForm extends StatelessWidget {
  const TxtForm(
      {Key? key,
      required this.textFieldName,
      required this.editingController,
      this.textFieldNameColor = Colors.grey,
      this.textFieldHint = " ",
      this.inputAction = TextInputAction.next,
      this.obscure = false,
      this.validator,
      this.autofillHints,
      this.keyboardType,
      this.fillColor = Colors.white,
      this.inputFormatters,
      this.validateMode = AutovalidateMode.always})
      : super(key: key);

  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final TextEditingController editingController;
  final Color fillColor;
  final TextInputAction inputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool obscure;
  final String textFieldHint;
  final String textFieldName;
  final Color textFieldNameColor;
  final AutovalidateMode validateMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Txt(
            textFieldName,
            textAlign: TextAlign.left,
            color: textFieldNameColor,
          ),
        ),
        TextFormField(
          enableSuggestions: true,
          textInputAction: inputAction,
          obscureText: obscure,
          autofillHints: autofillHints,
          autovalidateMode: validateMode,
          controller: editingController,
          keyboardType: keyboardType,
          validator: validator,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
              hintText: textFieldHint,
              //    labelText: "your name".tr,
              focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.green)),
              fillColor: fillColor,
              filled: true,
              border:
                  UnderlineInputBorder(borderRadius: BorderRadius.circular(6))),
        ),
      ],
    );
  }
}
