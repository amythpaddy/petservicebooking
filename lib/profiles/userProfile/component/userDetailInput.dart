import 'package:flutter/material.dart';
import 'package:the_pet_nest/profiles/petProfile/component/heading.dart';

class UserDetailInput extends StatelessWidget {
  final String heading;
  final String hint;
  final bool required;
  final TextInputType inputType;
  final Function onDataFilled;
  final String value;

  const UserDetailInput({
    required this.heading,
    this.hint = '',
    this.required = false,
    this.inputType = TextInputType.text,
    required this.onDataFilled,
    this.value = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController()..text = value;
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
              border: Border.all(color: Color(0x331A202E))),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: TextField(
            controller: _controller,
            onChanged: (data) => onDataFilled,
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
