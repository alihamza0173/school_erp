import 'package:flutter/material.dart';
import 'package:school_erp/src/styles/app_color.dart';
import 'package:school_erp/src/styles/app_text_style.dart';

class FormHelper {

static InputDecoration formFieldDecoration(String hinText) {
    return InputDecoration(
      hintText: hinText,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(0.8)),
      ),
      labelStyle: AppTextStyle.style(
        color: Colors.black.withOpacity(0.8),
      ),
    );
  }
  
  static Widget inputbButton({required String text}){
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.primary, AppColor.primary.withOpacity(0.7)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(5, 5),
            blurRadius: 10,
          )
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: AppTextStyle.style(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}