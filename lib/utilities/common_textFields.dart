import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../constans/color_constants.dart';
import 'google_fonts_textStyles.dart';

class EntryField extends StatelessWidget {
  EntryField(
      {Key? key,
        this.hintText,
        this.isPassword = false,
        this.obscureText = false,
        this.isShowPrefix = false,
        this.isEnable = true,
        this.readOnly = false,
        this.onTap,
        this.isCapitalize = false,
        this.prefixIcon,
        required this.title,
        required this.validator,
        this.textDirection,
        this.textInputAction,
        this.focusNode,
        required this.errortext, // Initially password is obscure
        required this.controller,
        this.textInputType,
        this.maxLines = 1,
        this.onChange,
        this.maxLength,
        this.widget,
        this.onShowHide})
      : super(key: key);
  String? hintText;
  bool isPassword;
  bool obscureText;
  Widget? widget;
  int? maxLength;
  bool isShowPrefix;
  TextEditingController controller;
  TextInputType? textInputType;
  String errortext;
  Function(String)? onChange;
  TextDirection? textDirection;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  String title;
  Function()? onShowHide;
  Function()? onTap;
  bool isEnable = true;
  bool isCapitalize = false;
  Widget? prefixIcon;
  int maxLines = 1;
  bool readOnly = false;

  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: Get.width*.2),
      decoration: BoxDecoration(
        color: Colors.transparent,
        // boxShadow: [BoxShadow(color: Colors.grey.shade600,blurRadius: 10)]
      ),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        keyboardType: textInputType ?? TextInputType.text,
        textDirection: textDirection ?? TextDirection.ltr,
        textInputAction: textInputAction ?? TextInputAction.next,
        focusNode: focusNode ?? FocusNode(),
        enabled: isEnable,
        maxLines: maxLines,
        onTap: onTap ?? () {},
        cursorColor: Colors.black,
        style: LatoStyles.latonormalTextStyle(color: Colors.black),
        onChanged: onChange,
        obscureText: obscureText,
        // cursorHeight: 20,
        maxLength: maxLength,
        validator: validator,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        textCapitalization: isCapitalize
            ? TextCapitalization.characters
            : TextCapitalization.sentences,
        decoration: InputDecoration(
            errorStyle: LatoStyles.latonormalTextStyle(color: Colors.black),
            fillColor: Colors.white,
            counterText: "",
            filled: true,
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(100))),
            contentPadding: EdgeInsets.symmetric(
                vertical: 20, horizontal: !isShowPrefix ? 0 : 0),
            // contentPadding: const EdgeInsets.all(0),
            hintText: title,
            hintStyle: LatoStyles.latonormalTextStyle(color: Colors.black),
            prefixIcon: prefixIcon??SizedBox(),
            suffixIcon: widget ?? null),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  FocusNode? focusNode;
  String? hintText;

  int? maxLines = 1;
  bool? obsecureText = false;

  String? Function(String?)? validator;
  TextInputAction? textInputAction = TextInputAction.next;
  TextInputType? textInputType = TextInputType.text;
  TextCapitalization? textCapitalization;
  Widget? prefix;
  Widget? suffix;
  List<TextInputFormatter>? inputFormatters;
  ValueChanged<String>? onFieldSubmitted;
  bool? readOnly;
  GestureTapCallback? onTap;
  Color? borderColor;
  Color? textColor;
  int? maxLength;
  String? labletext;
  var corRadious;
  CustomTextField(
      {Key? key,
        this.controller,
        this.focusNode,
        this.hintText,
        this.maxLines,
        this.obsecureText,
        this.validator,
        this.readOnly,
        this.onTap,
        this.borderColor,
        this.prefix,
        this.suffix,
        this.corRadious,
        this.textColor,
        this.labletext,
        this.textInputAction,
        this.textCapitalization,
        this.inputFormatters,
        this.textInputType,
        this.onFieldSubmitted,
        this.maxLength, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labletext ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ).paddingOnly(left: 2, bottom: 5),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          onTap: onTap,
          readOnly: readOnly ?? false,
          validator: validator,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          obscureText: obsecureText ?? false,
          // obscuringCharacter: "*",
          maxLength: maxLength,
          // onChanged: onChangee,
          inputFormatters: inputFormatters,
          textAlignVertical: TextAlignVertical.center,
          autovalidateMode: AutovalidateMode.disabled,
          style: MontserratStyles.montserratBoldTextStyle(color:textColor?? Colors.black),
          decoration: InputDecoration(
              alignLabelWithHint: true,
              isDense: true,

              hintText: hintText,
              // contentPadding: EdgeInsets.only(top: 10),
              // constraints: BoxConstraints(maxHeight: 50),
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              helperStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              errorMaxLines: 3,
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              prefixStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              fillColor: Colors.grey.shade100,
              prefixIcon: prefix,
              suffixIcon: suffix,
              filled: true,
              focusedBorder:
              outlineBorder(width: 2, color: borderColor ?? appColor,radi: corRadious),
              errorBorder: outlineBorder(color: borderColor ?? Colors.red,radi: corRadious),
              enabledBorder:
              outlineBorder(color: borderColor ?? Colors.grey.shade300,radi: corRadious),
              border: outlineBorder(color: borderColor ?? Colors.grey.shade300),
              focusedErrorBorder:
              outlineBorder(color: borderColor ?? Colors.red, width: 2,radi: corRadious)),
        ),
      ],
    );
  }

  OutlineInputBorder outlineBorder({double? width, Color? color,radi}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radi??30),
      borderSide:
      BorderSide(color: color ?? Colors.grey.shade300, width: width ?? 1.0),
    );
  }
}
