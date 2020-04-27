import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    Key key,
    this.backgroundColor,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
  }) : super(key: key);

  final Color backgroundColor;
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;
    if (backgroundColor != null)
      decoration = BoxDecoration(color: backgroundColor);

    final EdgeInsetsDirectional padding = EdgeInsetsDirectional.only(
      start: leading != null ? 8.0 : 16.0,
      end: trailing != null ? 8.0 : 16.0,
    );

    final ThemeData theme = Theme.of(context);
    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      accentColor: theme.accentColor,
      accentColorBrightness: theme.accentColorBrightness,
    );
    return Container(
      padding: padding,
      decoration: decoration,
      height: (title != null && subtitle != null) ? 68.0 : 48.0,
      child: Theme(
        data: darkTheme,
        child: IconTheme.merge(
          data: const IconThemeData(color: Colors.white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (leading != null)
                Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: leading),
              if (title != null && subtitle != null)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DefaultTextStyle(
                        style: darkTheme.textTheme.subtitle,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        child: title,
                      ),
                      DefaultTextStyle(
                        style: darkTheme.textTheme.caption,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        child: subtitle,
                      ),
                    ],
                  ),
                )
              else if (title != null || subtitle != null)
                Expanded(
                  child: DefaultTextStyle(
                    style: darkTheme.textTheme.subtitle,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    child: title ?? subtitle,
                  ),
                ),
              if (trailing != null)
                Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8.0),
                    child: trailing),
            ],
          ),
        ),
      ),
    );
  }
}
