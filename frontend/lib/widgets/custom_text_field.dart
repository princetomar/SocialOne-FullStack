import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool isObscure;

  const CustomTextField({
    Key? key,
    required this.title,
    required this.controller,
    this.isObscure = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: widget.controller,
        style: TextStyle(
          color: ColorConstants.lightWhiteColor,
        ),
        obscureText: _isObscure && widget.isObscure,
        decoration: InputDecoration(
          fillColor: Color.fromRGBO(29, 29, 29, 1),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.lightWhiteColor),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: widget.title,
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: ColorConstants.greyColor,
          ),
          suffixIcon: widget.isObscure
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
