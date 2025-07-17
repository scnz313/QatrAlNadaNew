import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/airbnb_theme.dart';

// Airbnb-style Animated Button
class AirbnbButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final double? width;
  
  const AirbnbButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.width,
  }) : super(key: key);
  
  @override
  State<AirbnbButton> createState() => _AirbnbButtonState();
}

class _AirbnbButtonState extends State<AirbnbButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.width ?? double.infinity,
        transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: widget.isOutlined ? Colors.transparent : AirbnbTheme.primaryRed,
            borderRadius: BorderRadius.circular(AirbnbTheme.radiusSmall),
            border: widget.isOutlined
                ? Border.all(color: AirbnbTheme.gray300, width: 1)
                : null,
            boxShadow: !widget.isOutlined && !_isPressed
                ? AirbnbTheme.lightShadow
                : null,
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.isOutlined ? AirbnbTheme.primaryDark : AirbnbTheme.primaryWhite,
                      ),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          size: 20,
                          color: widget.isOutlined
                              ? AirbnbTheme.primaryDark
                              : AirbnbTheme.primaryWhite,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: widget.isOutlined
                              ? AirbnbTheme.primaryDark
                              : AirbnbTheme.primaryWhite,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0);
  }
}

// Airbnb-style Card with hover effect
class AirbnbCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool showShadow;
  final double? borderRadius;
  final double borderWidth;
  
  const AirbnbCard({
    Key? key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.showShadow = true,
    this.borderRadius,
    this.borderWidth = 1.0,
  }) : super(key: key);
  
  @override
  State<AirbnbCard> createState() => _AirbnbCardState();
}

class _AirbnbCardState extends State<AirbnbCard> {
  bool _isHovered = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..scale(_isHovered ? 0.98 : 1.0),
        margin: widget.margin,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? AirbnbTheme.radiusLarge,
          ),
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: widget.borderWidth,
          ),
          boxShadow: widget.showShadow
              ? (_isHovered ? AirbnbTheme.mediumShadow : AirbnbTheme.lightShadow)
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            widget.borderRadius ?? AirbnbTheme.radiusLarge,
          ),
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.all(16),
            child: widget.child,
          ),
        ),
      ),
    ).animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.05, end: 0, curve: Curves.easeOutCubic);
  }
}

// Airbnb-style Icon Button
class AirbnbIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double size;
  final bool showBackground;
  
  const AirbnbIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size = 24,
    this.showBackground = true,
  }) : super(key: key);
  
  @override
  State<AirbnbIconButton> createState() => _AirbnbIconButtonState();
}

class _AirbnbIconButtonState extends State<AirbnbIconButton> {
  bool _isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_isPressed ? 0.9 : 1.0),
        width: 48,
        height: 48,
        decoration: widget.showBackground
            ? BoxDecoration(
                color: AirbnbTheme.surfaceWhite,
                shape: BoxShape.circle,
                border: Border.all(color: AirbnbTheme.gray200),
                boxShadow: _isPressed ? null : AirbnbTheme.lightShadow,
              )
            : null,
        child: Center(
          child: Icon(
            widget.icon,
            size: widget.size,
            color: widget.color ?? AirbnbTheme.primaryDark,
          ),
        ),
      ),
    );
  }
}

// Shimmer Loading Effect
class AirbnbShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double? borderRadius;
  
  const AirbnbShimmer({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AirbnbTheme.gray200,
      highlightColor: AirbnbTheme.gray100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AirbnbTheme.gray200,
          borderRadius: BorderRadius.circular(borderRadius ?? AirbnbTheme.radiusSmall),
        ),
      ),
    );
  }
}

// Animated Tab Bar
class AirbnbTabBar extends StatefulWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;
  
  const AirbnbTabBar({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);
  
  @override
  State<AirbnbTabBar> createState() => _AirbnbTabBarState();
}

class _AirbnbTabBarState extends State<AirbnbTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AirbnbTheme.gray100,
        borderRadius: BorderRadius.circular(AirbnbTheme.radiusRound),
      ),
      child: Row(
        children: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == widget.selectedIndex;
          
          return Expanded(
            child: GestureDetector(
              onTap: () => widget.onTabSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AirbnbTheme.surfaceWhite : Colors.transparent,
                  borderRadius: BorderRadius.circular(AirbnbTheme.radiusRound),
                  boxShadow: isSelected ? AirbnbTheme.lightShadow : null,
                ),
                child: Center(
                  child: Text(
                    tab,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? AirbnbTheme.primaryDark
                          : AirbnbTheme.gray600,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Floating Action Menu
class AirbnbFloatingMenu extends StatefulWidget {
  final List<AirbnbFloatingMenuItem> items;
  final IconData mainIcon;
  
  const AirbnbFloatingMenu({
    Key? key,
    required this.items,
    this.mainIcon = Icons.add,
  }) : super(key: key);
  
  @override
  State<AirbnbFloatingMenu> createState() => _AirbnbFloatingMenuState();
}

class _AirbnbFloatingMenuState extends State<AirbnbFloatingMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isOpen = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ...widget.items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  (1 - _controller.value) * 100 * (index + 1),
                ),
                child: Opacity(
                  opacity: _controller.value,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (item.label != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onSurface,
                              borderRadius: BorderRadius.circular(
                                AirbnbTheme.radiusSmall,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.onSurface.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Text(
                              item.label!,
                              style: TextStyle(
                                color: theme.colorScheme.surface,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        if (item.label != null) const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            _toggle();
                            item.onTap();
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.colorScheme.onSurface.withOpacity(0.1),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.onSurface.withOpacity(0.15),
                                  offset: const Offset(0, 4),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: Icon(
                              item.icon,
                              size: 20,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
        GestureDetector(
          onTap: _toggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _isOpen 
                  ? theme.colorScheme.onSurface 
                  : theme.colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.onSurface.withOpacity(0.25),
                  offset: const Offset(0, 8),
                  blurRadius: 20,
                ),
              ],
            ),
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: _isOpen ? 0.125 : 0,
              child: Icon(
                widget.mainIcon,
                color: _isOpen 
                    ? theme.colorScheme.surface 
                    : theme.colorScheme.onPrimary,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AirbnbFloatingMenuItem {
  final IconData icon;
  final String? label;
  final VoidCallback onTap;
  
  AirbnbFloatingMenuItem({
    required this.icon,
    this.label,
    required this.onTap,
  });
}