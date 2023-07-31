// import 'package:flutter/material.dart';
// import 'ViewProjectPage.dart';

// class ViewProjectPageWrapper extends StatefulWidget {
//   final String projectTitle;
//   final String selectedLanguage;

//   ViewProjectPageWrapper({
//     required this.projectTitle,
//     required this.selectedLanguage,
//   });

//   @override
//   State<ViewProjectPageWrapper> createState() => _ViewProjectPageWrapperState();
// }

// class _ViewProjectPageWrapperState extends State<ViewProjectPageWrapper> {
//   List<String> selectedLanguages = [];

//   @override
//   void initState() {
//     super.initState();
//     // Add the initially selected language
//     selectedLanguages.add(widget.selectedLanguage);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ViewProjectPage(
//       projectTitle: widget.projectTitle,
//       selectedLanguages: selectedLanguages,
//       onAddLanguage: (String language) {
//         setState(() {
//           selectedLanguages.add(language);
//         });
//       },
//     );
//   }
// }

// w