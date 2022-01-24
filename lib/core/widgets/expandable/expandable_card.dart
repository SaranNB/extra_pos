import 'package:extra_pos/core/utils/debounce.dart';
import 'package:extra_pos/core/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class AppExpandableCard extends StatefulWidget {
  AppExpandableCard({
    Key? key,
    this.leading,
    @required this.title,
    this.subtitle,
    this.headerBackgroundColor,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.tilePadding,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
    this.childrenPadding,
    this.actionType = ExpandableCardAction.NO_ACTION,
  })  : assert(initiallyExpanded != null),
        assert(maintainState != null),
        assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
        ),
        super(key: key);
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget>? children;
  final Color? headerBackgroundColor;
  final Color? backgroundColor;
  final Widget? trailing;
  final bool? initiallyExpanded;
  final bool? maintainState;
  final EdgeInsetsGeometry? tilePadding;
  final Alignment? expandedAlignment;
  final CrossAxisAlignment? expandedCrossAxisAlignment;
  final EdgeInsetsGeometry? childrenPadding;
  ExpandableCardAction? actionType;

  @override
  _ExpansionTileState createState() => _ExpansionTileState();
}

class _ExpansionTileState extends State<AppExpandableCard>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  AnimationController? _controller;
  Animation<double>? _iconTurns;
  Animation<double>? _heightFactor;
  Animation<Color>? _borderColor;
  Animation<Color>? _headerColor;
  Animation<Color>? _iconColor;
  Animation<Color>? _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller!.drive(_easeInTween);
    _iconTurns = _controller!.drive(_halfTween.chain(_easeInTween));
    // _borderColor = _controller!.drive(_borderColorTween.chain(_easeOutTween));
    // _headerColor = _controller!.drive(_headerColorTween.chain(_easeInTween));
    // _iconColor = _controller!.drive(_iconColorTween.chain(_easeInTween));
    // _backgroundColor =
    //     _controller!.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = (PageStorage.of(context)?.readState(context) as bool);
    if (_isExpanded) _controller!.value = 1.0;
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  collapse() {
    setState(() {
      _isExpanded = false;
      if (_isExpanded) {
        _controller!.forward();
      } else {
        _controller!.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged!(_isExpanded);
  }

  expand() {
    setState(() {
      _isExpanded = true;
      if (_isExpanded) {
        _controller!.forward();
      } else {
        _controller!.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged!(_isExpanded);
  }

  void _handleTap() {
    if (_isExpanded)
      collapse();
    else
      expand();
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Container(
      decoration: BoxDecoration(color: _backgroundColor!.value),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme.merge(
            data: IconThemeData(color: _iconColor!.value),
            child: Container(
              color: widget.headerBackgroundColor,
              child: ListTile(
                onTap: _handleTap,
                contentPadding: null,
                leading: widget.leading,
                title: widget.title,
                subtitle: widget.subtitle,
                trailing: RotationTransition(
                  turns: _iconTurns!,
                  child: const Icon(Icons.expand_more),
                ),
              ),
            ),
          ),
          ClipRect(
            child: Align(
              alignment: widget.expandedAlignment ?? Alignment.center,
              heightFactor: _heightFactor!.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween.end = theme.dividerColor;
    _headerColorTween
      ..begin = theme.textTheme.subtitle1!.color
      ..end = theme.accentColor;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;
    _backgroundColorTween.end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  ExpandableCardAction? previousAction;

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller!.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState!;

    final Widget result = Offstage(
        child: TickerMode(
          child: Padding(
            padding: widget.childrenPadding ?? EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: widget.expandedCrossAxisAlignment ??
                  CrossAxisAlignment.center,
              children: widget.children!,
            ),
          ),
          enabled: !closed,
        ),
        offstage: closed);

    Debouncer(milliseconds: 0).run(() {
      if (widget.actionType == ExpandableCardAction.COLLAPSE) {
        collapse();
        previousAction = ExpandableCardAction.COLLAPSE;
        widget.actionType = null;
      }
      if (widget.actionType == ExpandableCardAction.EXPAND) {
        expand();
        previousAction = ExpandableCardAction.EXPAND;
        widget.actionType = null;
      }
    });

    return AnimatedBuilder(
      animation: _controller!.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}

enum ExpandableCardAction { NO_ACTION, EXPAND, COLLAPSE }
