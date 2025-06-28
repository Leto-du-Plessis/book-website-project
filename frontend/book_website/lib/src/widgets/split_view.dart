import 'package:flutter/material.dart';

/// A SplitView [Widget] takes two [Widget] arguments and draws them in either a vertical or horizontal orientation.
/// The two [Widget] arguments are separated by a divider. The relative size of either [Widget] can be resized by
/// dragging the divider into the desired location. 
/// There is support for window weightings - which determines the initial distribution of space between the two 
/// windows. There is also support for window squashing, where windows can be automatically squashed by clicking 
/// on the divider. This behaviour can be tailored using the boolean arguments to the SplitView constructor. 
/// Note that by default, SplitView will adapt to the screen size and display in either a vertical or horizontal
/// orientation for a tall or wide aspect ratio respectively. This behaviour can be changed by setting [forceAlignment] 
/// to true and tailoring [alignmentIsVertical] to either true or false for vertical or horizontal orientation respectively.
class SplitView extends StatefulWidget { 

  final Widget leftWidget;
  final Widget rightWidget;
  final bool canSquashRight;
  final bool canSquashLeft;
  final bool forceAlignment;
  final bool alignmentIsVertical;
  final double leftWeight;
  final double rightWeight;

  const SplitView({
    super.key, 
    required this.leftWidget, 
    required this.rightWidget,
    this.canSquashLeft = true,
    this.canSquashRight = true,
    this.forceAlignment = false,
    this.alignmentIsVertical = false,
    this.leftWeight = 0.5,
    this.rightWeight = 0.5,
  });

  @override
  State<SplitView> createState() => _SplitViewState();

}

class _SplitViewState extends State<SplitView> {

  late double _dividerPosition;
  late double _initialDividerPosition;
  final double gripWidth = 10;

  bool _isDragging = false;
  bool _isLeftSquashed = false;
  bool _isRightSquashed = false;

  Offset? _dragStartPosition;
  final double _dragThreshold = 2.0;

  @override
  void initState() {
    super.initState();
    final total = widget.leftWeight + widget.rightWeight;
    _initialDividerPosition = total == 0 ? 0.5 : widget.leftWeight / total;
    _dividerPosition = _initialDividerPosition;
  }

  /// Utility method harbouring logic for window squashing.
  void _toggleSquash(bool squashRight) {
    setState(() {
      if (squashRight) {
        if (_isRightSquashed) {
          _dividerPosition = _initialDividerPosition;
          _isRightSquashed = false;
        } else {
          _dividerPosition = 1.0;
          _isRightSquashed = true;
          _isLeftSquashed = false;
        }
      } else {
        if (_isLeftSquashed) {
          _dividerPosition = _initialDividerPosition;
          _isLeftSquashed = false;
        } else {
          _dividerPosition = 0.0;
          _isLeftSquashed = true;
          _isRightSquashed = false;
        }
      }
    });
  }

  /// Utility method harbouring logic for animation the window if squashed.
  Widget _buildWindow(double size, Widget child, {required bool vertical}) {
    final shouldAnimate = !_isDragging;
    return AnimatedContainer(
      duration: shouldAnimate ? const Duration(milliseconds: 300) : Duration.zero,
      curve: Curves.easeInOut,
      width: vertical ? null : size,
      height: vertical ? size : null,
      child: Center(child: child),
    );
  }

  /// Utility method harbouring the logic for constructing the horizontal orientation.
  Widget _buildHorizontalLayout(BoxConstraints constraints) {
    final totalWidth = constraints.maxWidth;
    final leftWidth = (_dividerPosition * totalWidth).clamp(0.0, totalWidth - gripWidth);
    final rightWidth = (totalWidth - leftWidth - gripWidth).clamp(0.0, totalWidth - gripWidth);

    return Row(
      children: [
        _buildWindow(leftWidth, widget.leftWidget, vertical: false),
        MouseRegion(
          cursor: _isDragging
              ? SystemMouseCursors.grabbing
              : SystemMouseCursors.click,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragStart: (details) {
              _dragStartPosition = details.globalPosition;
            },
            onHorizontalDragUpdate: (details) {
              final dx = details.globalPosition.dx;
              final dragDistance = (_dragStartPosition!.dx - dx).abs();

              if (!_isDragging && dragDistance > _dragThreshold) {
                setState(() => _isDragging = true);
              }

              setState(() {
                _dividerPosition += details.delta.dx / totalWidth;
                _dividerPosition = _dividerPosition.clamp(0.1, 0.9);
                _isLeftSquashed = false;
                _isRightSquashed = false;
              });
            },
            onHorizontalDragEnd: (_) => setState(() {
              _isDragging = false;
              _dragStartPosition = null;
            }),
            onTap: () {
              if (_isDragging) return;
              if ((widget.canSquashRight && !widget.canSquashLeft) || (_dividerPosition >= _initialDividerPosition && widget.canSquashRight)) {
                _toggleSquash(true);
              } else if ((widget.canSquashLeft && !widget.canSquashRight) || (_dividerPosition < _initialDividerPosition && widget.canSquashLeft)) {
                _toggleSquash(false);
              }
            },
            child: Container(
              width: gripWidth,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
        _buildWindow(rightWidth, widget.rightWidget, vertical: false),
      ],
    );
  }

  /// Utility method harbouring the logic for constructing the vertical orientation.
  Widget _buildVerticalLayout(BoxConstraints constraints) {
    final totalHeight = constraints.maxHeight;
    final topHeight = (_dividerPosition * totalHeight).clamp(0.0, totalHeight - gripWidth);
    final bottomHeight = (totalHeight - topHeight - gripWidth).clamp(0.0, totalHeight - gripWidth);

    return Column(
      children: [
        _buildWindow(topHeight, widget.leftWidget, vertical: true),
        MouseRegion(
          cursor: _isDragging
              ? SystemMouseCursors.grabbing
              : SystemMouseCursors.click,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onVerticalDragStart: (details) {
              _dragStartPosition = details.globalPosition;
            },
            onVerticalDragUpdate: (details) {
              final dy = details.globalPosition.dy;
              final dragDistance = (_dragStartPosition!.dy - dy).abs();

              if (!_isDragging && dragDistance > _dragThreshold) {
                setState(() => _isDragging = true);
              }

              setState(() {
                _dividerPosition += details.delta.dy / totalHeight;
                _dividerPosition = _dividerPosition.clamp(0.1, 0.9);
                _isLeftSquashed = false;
                _isRightSquashed = false;
              });
            },
            onVerticalDragEnd: (_) => setState(() {
              _isDragging = false;
              _dragStartPosition = null;
            }),
            onTap: () {
              if (_isDragging) return;
              if ((widget.canSquashRight && !widget.canSquashLeft) || (_dividerPosition >= _initialDividerPosition && widget.canSquashRight)) {
                _toggleSquash(true);
              } else if ((widget.canSquashLeft && !widget.canSquashRight) || (_dividerPosition < _initialDividerPosition && widget.canSquashLeft)) {
                _toggleSquash(false);
              }
            },
            child: Container(
              height: gripWidth,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
        _buildWindow(bottomHeight, widget.rightWidget, vertical: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTall = size.height / size.width > 1.1;

    final useVertical = widget.forceAlignment
        ? widget.alignmentIsVertical
        : isTall;

    return LayoutBuilder(
      builder: (context, constraints) {
        return useVertical
            ? _buildVerticalLayout(constraints)
            : _buildHorizontalLayout(constraints);
      },
    );
  }
}
