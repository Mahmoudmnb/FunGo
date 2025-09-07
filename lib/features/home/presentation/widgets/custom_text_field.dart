import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final int maxLength;
  final double width;
  final double height;
  final int maxLine;
  final String? hintText;
  final String? suffixText;
  final bool readOnly;
  final Widget? prefIcon;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(PointerDownEvent)? onTapOutSide;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final MouseCursor? mouseCursor;
  final Function()? onEditingCompleted;
  final Color backgroundColor;
  final FocusNode? focusNode;
  final BorderRadius borderRadius;
  final bool obscureText;
  final List<BoxShadow>? boxShadow;
  final TextInputType? textInputType;
  const CustomTextField(
      {super.key,
      this.boxShadow,
      this.obscureText = false,
      this.focusNode,
      this.textInputType,
      this.backgroundColor = Colors.white,
      this.onEditingCompleted,
      this.hintText,
      this.suffixText,
      this.onTap,
      this.onChanged,
      this.onTapOutSide,
      this.prefIcon,
      this.inputFormatters,
      this.mouseCursor,
      this.validator,
      this.readOnly = false,
      this.maxLine = 1,
      this.borderRadius = const BorderRadius.all(Radius.circular(10)),
      required this.controller,
      required this.maxLength,
      required this.height,
      required this.width});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late AutovalidateMode val;
  @override
  void initState() {
    val = AutovalidateMode.disabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
      ),
      child: Builder(builder: (context) {
        return Container(
          margin: const EdgeInsets.only(bottom: 5),
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: widget.borderRadius,
              boxShadow: widget.boxShadow),
          child: Row(
            children: [
              widget.prefIcon ?? const SizedBox.shrink(),
              Expanded(
                child: TextFormField(
                  obscureText: widget.obscureText,
                  keyboardType: widget.textInputType,
                  onSaved: (newValue) {
                    val = AutovalidateMode.disabled;
                    setState(() {});
                  },
                  focusNode: widget.focusNode,
                  onEditingComplete: widget.onEditingCompleted,
                  validator: widget.validator,
                  mouseCursor: widget.mouseCursor,
                  inputFormatters: widget.inputFormatters,
                  onTapOutside: widget.onTapOutSide,
                  onChanged: widget.onChanged,
                  onTap: () {
                    if (widget.onTap != null) {
                      widget.onTap!();
                    }
                    if (val == AutovalidateMode.disabled) {
                      val = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: widget.readOnly,
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLine,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontFamily: 'Almarai', fontSize: 16),
                  controller: widget.controller,
                  autovalidateMode: val,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    counterText: '',
                    hintStyle: const TextStyle(
                      fontFamily: 'Almarai',
                      color: Color(0xffA0A0A0),
                    ),
                    hintText: widget.hintText,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: widget.borderRadius,
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: widget.borderRadius,
                        borderSide: const BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              widget.suffixText != null
                  ? Row(
                      children: [
                        Text(
                          '${widget.suffixText}',
                          style: const TextStyle(
                              color: Color(0xff30727C), fontSize: 20),
                        ),
                        const SizedBox(width: 20),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
      }),
    );
  }
}
