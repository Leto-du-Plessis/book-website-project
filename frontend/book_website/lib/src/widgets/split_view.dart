import 'package:flutter/material.dart';

class SplitView extends StatefulWidget { 

  final Widget leftWidget;
  final Widget rightWidget;
  final bool canSquashRight;
  final bool canSquashLeft;
  final bool forceAlignment;
  final bool alignmentIsVertical;

  const SplitView({
    super.key, 
    required this.leftWidget, 
    required this.rightWidget,
    this.canSquashLeft = true,
    this.canSquashRight = true,
    this.forceAlignment = false,
    this.alignmentIsVertical = false
  });

  @override
  State<SplitView> createState() => _SplitViewState();

}

class _SplitViewState extends State<SplitView> {

  double _dividerPosition = 0.5;
  final double gripWidth = 10;

  bool _isDragging = false;
  bool _isLeftSquashed = false;
  bool _isRightSquashed = false;

  final double squashPosition = 0.0;
  final double unSquashPosition = 0.5;

  void _toggleSquash(bool squashRight) {
    setState(() {
      if (squashRight) {
        if (_isRightSquashed) {
          _dividerPosition = unSquashPosition;
          _isRightSquashed = false;
        } else {
          _dividerPosition = 1.0;
          _isRightSquashed = true;
          _isLeftSquashed = false;
        }
      } else {
        if (_isLeftSquashed) {
          _dividerPosition = unSquashPosition;
          _isLeftSquashed = false;
        } else {
          _dividerPosition = 0.0;
          _isLeftSquashed = true;
          _isRightSquashed = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        final totalWidth = constraints.maxWidth;
        final leftWidth = (_dividerPosition * totalWidth).clamp(0.0, totalWidth - gripWidth);
        final rightWidth = (totalWidth - leftWidth - gripWidth).clamp(0.0, totalWidth - gripWidth);

        return Row(  
          children: [
            SizedBox(  
              width: leftWidth,
              child: Center(child: widget.leftWidget),
            ),
            MouseRegion(
              cursor: _isDragging 
                ? SystemMouseCursors.grabbing
                : SystemMouseCursors.click,
              child: GestureDetector(  
                behavior: HitTestBehavior.translucent,
                onHorizontalDragStart: (details) {
                  setState(() {
                    _isDragging = true;
                  });
                },
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    final total = constraints.maxWidth;
                    _dividerPosition += details.delta.dx / total;
                    _dividerPosition = _dividerPosition.clamp(0.1, 0.9);
                    _isLeftSquashed = false;
                    _isRightSquashed = false;
                  });
                },
                onHorizontalDragEnd: (_) {
                  setState(() {
                    _isDragging = false;
                  });
                },
                onTap: () {
                  if (_isDragging) return;
                  if ((widget.canSquashRight && !widget.canSquashLeft) || (_dividerPosition >= 0.5 && widget.canSquashRight)) {
                    _toggleSquash(true);
                  } else if ((widget.canSquashLeft && !widget.canSquashRight) || (_dividerPosition < 0.5 && widget.canSquashLeft)) {
                    _toggleSquash(false);
                  }
                },
                child: Container(  
                  width: gripWidth,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
            SizedBox(  
              width: rightWidth,
              child: Center(child: widget.rightWidget),
            )
          ]
        );
      }
    );
  }
}
