part of arcgis_maps_flutter;

class CompassController extends ChangeNotifier
    implements ViewpointChangedListener {
  final ArcgisMapController? _mapController;
  double _rotation = 0;

  CompassController._(this._rotation, this._mapController) {
    if (_mapController != null) {
      _mapController!.addViewpointChangedListener(this);
    }
  }

  CompassController({double rotation = 0})
      : _rotation = rotation,
        _mapController = null;

  factory CompassController.fromMapController(
      ArcgisMapController mapController) {
    return CompassController._(0, mapController);
  }

  double get rotation => _rotation;

  set rotation(double newValue) {
    if (_rotation == newValue) return;
    _rotation = newValue;
    notifyListeners();
  }

  @override
  void viewpointChanged() async {
    rotation = await _mapController!.getMapRotation();
  }

  @override
  void dispose() {
    _mapController?.removeViewpointChangedListener(this);
    super.dispose();
  }
}

class Compass extends StatefulWidget {
  const Compass({
    Key? key,
    required this.controller,
    this.width = 50,
    this.height = 50,
    this.autohide = true,
    this.child,
  }) : super(key: key);

  final double width;
  final double height;

  final bool autohide;

  final CompassController controller;

  final Widget? child;

  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(
      milliseconds: 250,
    ),
    vsync: this,
  );

  late final CompassController _compassController = widget.controller
    ..addListener(_handleRotationChange);

  late double _rotation = _degreesToRadians(_compassController.rotation);

  @override
  void dispose() {
    _animationController.dispose();
    _compassController.removeListener(_handleRotationChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child ??
        Image.asset(
          'assets/ic_compass.png',
          package: 'arcgis_maps_flutter',
        );

    child = SizedBox(
      width: widget.width,
      height: widget.height,
      child: Transform.rotate(
        angle: _rotation,
        child: child,
      ),
    );

    if (_compassController._mapController != null) {
      child = GestureDetector(
        onTap: () async {
          await _compassController._mapController?.setViewpointRotation(0);
        },
        child: child,
      );
    }

    return child;
  }

  void _handleRotationChange() {
    _rotation = _degreesToRadians(_compassController.rotation);
    if (mounted) {
      setState(() {});
    }
  }

  double _degreesToRadians(double degrees) {
    return (math.pi * (360 - degrees) / 180);
  }
}