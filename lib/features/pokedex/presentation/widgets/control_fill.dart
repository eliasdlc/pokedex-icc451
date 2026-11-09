import 'package:flutter/material.dart';

import '../../../../app/theme/app_tokens.dart';

Color controlFill(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? context.tokens.sf2
    : const Color(0xFF242424);

Color onControlFill(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? context.tokens.ink
    : context.tokens.on;
