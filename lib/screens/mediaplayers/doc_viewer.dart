import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FileViewerPage extends StatefulWidget {
  final String url;

  const FileViewerPage({
    super.key,
    required this.url,
  });

  @override
  State<FileViewerPage> createState() => _FileViewerPageState();
}

class _FileViewerPageState extends State<FileViewerPage> {
  late PdfViewerController _pdfViewerController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchEnabled = false;
  PdfTextSearchResult _searchResult = PdfTextSearchResult();

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchEnabled = !_isSearchEnabled;
      if (!_isSearchEnabled) {
        _searchController.clear();
        _searchResult.clear();
      }
    });
  }

  void _searchText(String text) {
    _searchResult = _pdfViewerController.searchText(text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: _isSearchEnabled
      //       ? TextField(
      //           controller: _searchController,
      //           autofocus: true,
      //           decoration: InputDecoration(
      //             hintText: 'Search',
      //             suffixIcon: IconButton(
      //               icon: const Icon(Icons.clear),
      //               onPressed: () {
      //                 _searchController.clear();
      //                 _searchResult.clear();
      //               },
      //             ),
      //           ),
      //           onChanged: (text) {
      //             if (text.isNotEmpty) {
      //               _searchText(text);
      //             } else {
      //               _searchResult.clear();
      //             }
      //           },
      //         )
      //       : const Text('File Viewer'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(_isSearchEnabled ? Icons.close : Icons.search),
      //       onPressed: _toggleSearch,
      //     ),
      //     if (_isSearchEnabled && _searchResult.totalInstanceCount > 0)
      //       Row(
      //         children: [
      //           IconButton(
      //             icon: const Icon(Icons.keyboard_arrow_up),
      //             onPressed: () {
      //               _searchResult.previousInstance();
      //             },
      //           ),
      //           IconButton(
      //             icon: const Icon(Icons.keyboard_arrow_down),
      //             onPressed: () {
      //               _searchResult.nextInstance();
      //             },
      //           ),
      //         ],
      //       ),
      //   ],
      // ),
 backgroundColor: Colors.white,
      body: SfPdfViewer.network(
        widget.url,
        controller: _pdfViewerController,
      ),
    );
  }
}
