import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plie/core/constants/fonts_constants.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPasswordField;
  final Function() onTextChange;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.isPasswordField = false,
    required this.controller,
    required this.onTextChange,
    this.inputFormatter,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // 👀 Trigger validation when field loses focus (on blur)
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.onTextChange();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.robotoRegular.copyWith(
            fontSize: 16,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.isPasswordField ? _obscureText : false,

            textInputAction: TextInputAction.done,
            onEditingComplete: widget.onTextChange,

            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
              widget.onTextChange(); // keep your callback
            },

            inputFormatters: widget.inputFormatter,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.robotoRegular.copyWith(
                color: const Color(0xFF828282),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
                  : null,
            ),
            keyboardType: widget.isPasswordField
                ? TextInputType.visiblePassword
                : TextInputType.emailAddress,
          ),
        ),
      ],
    );
  }
}
