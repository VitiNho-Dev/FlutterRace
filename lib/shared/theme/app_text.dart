import 'package:flutter/material.dart';

import 'app_theme.dart';

export 'app_text.dart';

extension TextExt on Text {
  Text get label => Text(data!, style: AppTheme.textStyles.label);
}
