import 'package:flutter/material.dart';
import 'package:the_pet_nest/profiles/petProfile/component/heading.dart';

class UserDetailInput extends StatelessWidget {
  final String heading;
  final String hint;
  final bool required;
  final TextInputType inputType;
  final Function onDataFilled;
  final String value;
  final bool disabled;
  late FocusNode _focusNode;
  TextEditingController _controller = TextEditingController();

  UserDetailInput({
    required this.heading,
    this.hint = '',
    this.required = false,
    this.inputType = TextInputType.text,
    required this.onDataFilled,
    this.value = '',
    this.disabled = false,
    Key? key,
  }) : super(key: key) {
    // _controller.text = value;
    // _controller.selection = TextSelection.fromPosition(
    //     TextPosition(offset: _controller.text.length));
    // _controller.addListener(() {
    //   onDataFilled(_controller.text);
    //   _controller.
    // });

    // _focusNode = FocusNode();
    // // _focusNode.addListener(() {
    // //   if (!_focusNode.hasFocus) {
    // //     print('focus lost');
    // //     onDataFilled(_controller.text);
    // //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(
          heading: heading,
          required: required,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0x331A202E)),
              color: disabled ? Colors.grey[300] : Colors.white),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: TextFormField(
            readOnly: disabled,
            initialValue: value,
            // controller: TextEditingController()..text = value,
            // focusNode: _focusNode,
            // initialValue: value,

            onChanged: (data) => onDataFilled(data),
            style: TextStyle(height: .75),
            decoration: InputDecoration(
                focusColor: Color(0x331A202E),
                hintText: hint,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none
                // focusedBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Color(0x331A202E)),
                //     borderRadius: BorderRadius.all(Radius.circular(12))),
                // border: OutlineInputBorder(
                //     borderSide: BorderSide(color: Color(0x331A202E)),
                //     borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
          ),
        ),
      ],
    );
  }
}

class DisabledFocus extends FocusNode {
  @override
  bool get hasFocus => false;
}
