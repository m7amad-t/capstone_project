// ignore_for_file: file_names

abstract class AppFeature {
  final String _name;
  final String _imageUrl;
  final String _path;

  String get imagePath => _imageUrl;

  String get name => _name;

  String get path => _path;
  AppFeature(this._name, this._imageUrl, this._path);
}

class AppSection extends AppFeature {
  AppSection({
    required String name,
    required String imagePath,
    required String path,
  }) : super(name, imagePath, path);

  
}
