import 'app_colors.dart';
import 'app_text_style.dart';

class AppTheme {
  static final instance = AppTheme();

  final _colors = AppColors();
  static IAppColors get colors => instance._colors;

  final _textStyles = AppTextStyle();
  static IAppTextStyle get textStyles => instance._textStyles;
}
