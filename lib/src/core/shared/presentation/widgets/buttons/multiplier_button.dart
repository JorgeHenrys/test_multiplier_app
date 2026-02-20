import 'package:flutter/material.dart';
import 'package:test_multiplier_app/src/core/core.dart';

enum MultiplierButtonTypes {
  primary('primary'),
  secondary('secondary'),
  tertiary('tertiary');

  const MultiplierButtonTypes(this.type);

  final String type;
}

class MultiplierButton extends StatelessWidget {
  final String label;
  final RichText? composedLabel;
  final Widget? icon;
  final Color color;
  final Color bordercolor;
  final bool isFullWidth;
  final MultiplierButtonTypes type;
  final bool disabled;
  final VoidCallback onPressed;
  final bool loading;
  final double size;

  const MultiplierButton({
    super.key,
    required this.label,
    this.icon,
    this.color = Colors.deepOrangeAccent,
    this.isFullWidth = false,
    this.size = 50,
    this.type = MultiplierButtonTypes.primary,
    this.disabled = false,
    required this.onPressed,
    this.loading = false,
    this.bordercolor = Colors.deepOrangeAccent,
    this.composedLabel,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = type == MultiplierButtonTypes.primary
        ? Colors.white
        : color;
    var backgrounColors = {
      'primary': color,
      'secondary': Colors.transparent,
      'tertiary': Colors.transparent,
    };
    final backgroundColor = backgrounColors[type.type] ?? Colors.transparent;

    Widget loadingIcon() {
      return const SizedBox(
        width: 20,
        height: 20,
        child: Padding(
          padding: EdgeInsets.all(.1),
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        ),
      );
    }

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading) loadingIcon() else if (icon != null) icon!,
        if (icon != null) const SizedBox(width: 4),
        if (composedLabel != null)
          composedLabel!
        else
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Mulish',
              fontWeight: type == MultiplierButtonTypes.primary
                  ? FontWeight.w600
                  : FontWeight.w400,
              color: disabled ? lighten(textColor, .4) : textColor,
              fontSize: type == MultiplierButtonTypes.tertiary ? 14 : 16,
            ),
          ),
      ],
    );

    if (type == MultiplierButtonTypes.primary) {
      return SizedBox(
        height: size,
        width: isFullWidth ? double.infinity : null,
        child: FilledButton(
          onPressed: disabled ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: darken(color, .4),
            disabledBackgroundColor: lighten(backgroundColor, .3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: loading ? loadingIcon() : content,
        ),
      );
    } else if (type == MultiplierButtonTypes.secondary) {
      return SizedBox(
        height: size,
        width: isFullWidth ? double.infinity : null,
        child: OutlinedButton(
          onPressed: disabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.only(left: 24, right: 24),
            backgroundColor: backgroundColor,
            foregroundColor: darken(color, .4),
            side: BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: disabled ? lighten(bordercolor, .4) : bordercolor,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: loading ? loadingIcon() : content,
        ),
      );
    } else {
      return SizedBox(
        height: size,
        width: isFullWidth ? double.infinity : null,
        child: TextButton(
          onPressed: disabled ? null : onPressed,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: darken(color, .4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: loading ? loadingIcon() : content,
        ),
      );
    }
  }
}
