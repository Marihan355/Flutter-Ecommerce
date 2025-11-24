import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/presentation/cubit/localization_cubit.dart';

class CustomText extends StatelessWidget {
final String data;
final TextAlign? textAlign;
final int? maxLines;
final TextStyle? style;
final TextOverflow? overflow;

const CustomText(
this.data, {
super.key,
this.textAlign,
this.maxLines,
this.style,
this.overflow,
});

@override
Widget build(BuildContext context) {
return BlocBuilder<LocalizationCubit, Locale>(
builder: (context, state) {
final fontFamily =state.languageCode == 'en'
    ? 'PlayfairDisplay' : 'NotoSans';

return Text(
  data,
  style: style?.copyWith(fontFamily: fontFamily)??
      TextStyle(fontFamily: fontFamily),
  overflow: overflow,
 maxLines: maxLines,
  textAlign: textAlign,
  textScaler: const TextScaler.linear(1.0), //textScaler controls how much the text size scales (multiply the font size byy ex:1)
 );},
);
 }
}
