import 'package:flutter/material.dart';

InputDecoration TextFormFieldInputDecoration(String hintText, String labelText,
        [Widget? prefixIcon]) =>
    InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        labelText: labelText,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green)),
        fillColor: Colors.white70,
        filled: true,
        alignLabelWithHint: true);

InputDecoration passwordTextFormFieldInputDecoration(
        String hintText, String labelText, Widget prefixIcon,  Widget suffixIcon) =>
    InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green)),
        fillColor: Colors.white70,
        filled: true,
        alignLabelWithHint: true);
