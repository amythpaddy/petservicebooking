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
  final bool showError;
  final String errorMessage;
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
    this.showError = false,
    this.errorMessage = "This field is required",
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
    // //     onDataFilled(_controller.text);
    // //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: showError ? 0 : 12),
      child: Column(
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
                border: Border.all(
                    color: showError ? Colors.redAccent : Color(0x331A202E)),
                color: disabled ? Colors.grey[300] : Colors.white),
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 4, bottom: 2, left: 10, right: 10),
            child: TextFormField(
              readOnly: disabled,
              initialValue: value,
              // cursorHeight: 20,
              // controller: TextEditingController()..text = value,
              // focusNode: _focusNode,
              // initialValue: value,

              onChanged: (data) => onDataFilled(data),
              style: TextStyle(height: 1),
              decoration: InputDecoration(
                focusColor: Color(0x331A202E),
                hintText: hint,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                // focusedBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Color(0x331A202E)),
                //     borderRadius: BorderRadius.all(Radius.circular(12))),
                // border: OutlineInputBorder(
                //     borderSide: BorderSide(color: Color(0x331A202E)),
                //     borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
            ),
          ),
          Visibility(
            child: Text(
              errorMessage,
              style:
                  TextStyle(color: Colors.redAccent, fontSize: 12, height: 1),
            ),
            visible: showError,
          )
        ],
      ),
    );
  }
}

class DisabledFocus extends FocusNode {
  @override
  bool get hasFocus => false;
}
