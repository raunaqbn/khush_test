class ImageCardData {
  late final String imageUrl;
  final String foregroundText;
  final List<String> selectedLanguages; // Add selectedLanguages property

  ImageCardData({
    required this.imageUrl,
    required this.foregroundText,
    required this.selectedLanguages, // Add selectedLanguages to the constructor
  });

  factory ImageCardData.fromJson(Map<String, dynamic> json) {
    return ImageCardData(
      imageUrl: json['imageUrl'],
      foregroundText: json['foregroundText'],
      selectedLanguages: List<String>.from(
          json['selectedLanguages']), // Convert to a list of strings
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'foregroundText': foregroundText,
      'selectedLanguages': selectedLanguages,
    };
  }
}
