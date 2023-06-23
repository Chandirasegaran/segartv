// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:http/http.dart' as http;
// import 'package:xml/xml.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(SegarTvApp());
// }

// class SegarTvApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Set landscape mode
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Segar TV',
//       theme: ThemeData.dark(),
//       home: SegarTvHomePage(),
//     );
//   }
// }

// class SegarTvHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Segar TV'),
//       ),
//       body: SafeArea(
//         child: GridView.count(
//           crossAxisCount: 4,
//           children: [
//             GridItem(
//               name: 'Sun TV',
//               iconPath: 'ico/suntv.png',
//               onTap: () => navigateToPlayerPage(context, 'suntv'),
//             ),
//             GridItem(
//               name: 'Vijay TV',
//               iconPath: 'ico/vijaytv.png',
//               onTap: () => navigateToPlayerPage(context, 'vijaytv'),
//             ),
//             GridItem(
//               name: 'K TV',
//               iconPath: 'ico/ktv.png',
//               onTap: () => navigateToPlayerPage(context, 'ktv'),
//             ),
//             GridItem(
//               name: 'Isaiaruvi',
//               iconPath: 'ico/isaiaruvi.png',
//               onTap: () => navigateToPlayerPage(context, 'isaiaruvi'),
//             ),
//             GridItem(
//               name: 'Sun Music',
//               iconPath: 'ico/sunmusic.png',
//               onTap: () => navigateToPlayerPage(context, 'sunmusic'),
//             ),
//             GridItem(
//               name: 'Star Sports Tamil',
//               iconPath: 'ico/starsport.png',
//               onTap: () => navigateToPlayerPage(context, 'starsport'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void navigateToPlayerPage(BuildContext context, String channelName) async {
//     // Fetch the XML file
//     final response = await http.get(Uri.parse(
//         'https://raw.githubusercontent.com/Chandirasegaran/segartv/main/tv.xml'));
//     final xmlData = response.body;

//     // Parse the XML and get the channel URL
//     final channelUrl = parseChannelUrl(xmlData, channelName);

//     if (channelUrl != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => MediaPlayerPage(channelUrl)),
//       );
//     }
//   }

//   String? parseChannelUrl(String xmlData, String channelName) {
//     final parsedData = XmlDocument.parse(xmlData);
//     final channelElements = parsedData.findAllElements('channel');
//     for (var channelElement in channelElements) {
//       final nameElement = channelElement.findElements('name');
//       if (nameElement.isNotEmpty && nameElement.first.text == channelName) {
//         final urlElement = channelElement.findElements('url');
//         if (urlElement.isNotEmpty) {
//           return urlElement.first.text;
//         }
//       }
//     }
//     return null;
//   }
// }

// class GridItem extends StatelessWidget {
//   final String name;
//   final String iconPath;
//   final VoidCallback onTap;

//   GridItem({required this.name, required this.iconPath, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         alignment: Alignment.center,
//         child: Image.asset(
//           iconPath,
//           fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }
// }

// class MediaPlayerPage extends StatefulWidget {
//   final String channelUrl;

//   MediaPlayerPage(this.channelUrl);

//   @override
//   _MediaPlayerPageState createState() => _MediaPlayerPageState();
// }

// class _MediaPlayerPageState extends State<MediaPlayerPage> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.channelUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//         _controller.setLooping(true);
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RawKeyboardListener(
//         focusNode: FocusNode(),
//         onKey: (RawKeyEvent event) {
//           if (event is RawKeyDownEvent) {
//             if (event.logicalKey == LogicalKeyboardKey.select) {
//               _handleSelectKey();
//             }
//           }
//         },
//         child: Center(
//           child: _controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }

//   void _handleSelectKey() {
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//     } else {
//       _controller.play();
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }



import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(SegarTvApp());
}

class SegarTvApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Segar TV',
      theme: ThemeData.dark(),
      home: SegarTvHomePage(),
    );
  }
}

class SegarTvHomePage extends StatefulWidget {
  @override
  _SegarTvHomePageState createState() => _SegarTvHomePageState();
}

class _SegarTvHomePageState extends State<SegarTvHomePage> {
  FocusNode _focusNode = FocusNode();
  int _selectedItemIndex = 0;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segar TV'),
      ),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              setState(() {
                _selectedItemIndex = (_selectedItemIndex - 1)
                    .clamp(0, 5); // 5 is the total number of items
              });
            } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              setState(() {
                _selectedItemIndex = (_selectedItemIndex + 1)
                    .clamp(0, 5); // 5 is the total number of items
              });
            } else if (event.logicalKey == LogicalKeyboardKey.select ||
                event.logicalKey == LogicalKeyboardKey.enter) {
              _handleSelectKey(context);
            }
          }
        },
        child: SafeArea(
          child: GridView.count(
            crossAxisCount: 4,
            children: [
              GridItem(
                name: 'Sun TV',
                iconPath: 'ico/suntv.png',
                onTap: () => navigateToPlayerPage(context, 'suntv'),
                isSelected: _selectedItemIndex == 0,
              ),
              GridItem(
                name: 'Vijay TV',
                iconPath: 'ico/vijaytv.png',
                onTap: () => navigateToPlayerPage(context, 'vijaytv'),
                isSelected: _selectedItemIndex == 1,
              ),
              GridItem(
                name: 'K TV',
                iconPath: 'ico/ktv.png',
                onTap: () => navigateToPlayerPage(context, 'ktv'),
                isSelected: _selectedItemIndex == 2,
              ),
              GridItem(
                name: 'Isaiaruvi',
                iconPath: 'ico/isaiaruvi.png',
                onTap: () => navigateToPlayerPage(context, 'isaiaruvi'),
                isSelected: _selectedItemIndex == 3,
              ),
              GridItem(
                name: 'Sun Music',
                iconPath: 'ico/sunmusic.png',
                onTap: () => navigateToPlayerPage(context, 'sunmusic'),
                isSelected: _selectedItemIndex == 4,
              ),
              GridItem(
                name: 'Star Sports Tamil',
                iconPath: 'ico/starsport.png',
                onTap: () => navigateToPlayerPage(context, 'starsport'),
                isSelected: _selectedItemIndex == 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToPlayerPage(BuildContext context, String channelName) async {
    // Fetch the XML file
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Chandirasegaran/segartv/main/tv.xml'));
    final xmlData = response.body;

    // Parse the XML and get the channel URL
    final channelUrl = parseChannelUrl(xmlData, channelName);

    if (channelUrl != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MediaPlayerPage(channelUrl)),
      );
    }
  }

  String? parseChannelUrl(String xmlData, String channelName) {
    final parsedData = XmlDocument.parse(xmlData);
    final channelElements = parsedData.findAllElements('channel');
    for (var channelElement in channelElements) {
      final nameElement = channelElement.findElements('name');
      if (nameElement.isNotEmpty && nameElement.first.text == channelName) {
        final urlElement = channelElement.findElements('url');
        if (urlElement.isNotEmpty) {
          return urlElement.first.text;
        }
      }
    }
    return null;
  }

  // void _handleSelectKey(BuildContext context) {
  //   final GridItem item = context.findAncestorWidgetOfExactType<GridItem>()!;
  //   item.onTap();
  // }
  void _handleSelectKey(BuildContext context) {
    switch (_selectedItemIndex) {
      case 0:
        navigateToPlayerPage(context, 'suntv');
        break;
      case 1:
        navigateToPlayerPage(context, 'vijaytv');
        break;
      case 2:
        navigateToPlayerPage(context, 'ktv');
        break;
      case 3:
        navigateToPlayerPage(context, 'isaiaruvi');
        break;
      case 4:
        navigateToPlayerPage(context, 'sunmusic');
        break;
      case 5:
        navigateToPlayerPage(context, 'starsport');
        break;
    }
  }
}

class GridItem extends StatelessWidget {
  final String name;
  final String iconPath;
  final VoidCallback onTap;
  final bool isSelected;

  GridItem({
    required this.name,
    required this.iconPath,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Image.asset(
          iconPath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class MediaPlayerPage extends StatefulWidget {
  final String channelUrl;

  MediaPlayerPage(this.channelUrl);

  @override
  _MediaPlayerPageState createState() => _MediaPlayerPageState();
}

class _MediaPlayerPageState extends State<MediaPlayerPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.channelUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.select) {
              _handleSelectKey();
            }
          }
        },
        child: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _handleSelectKey() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:http/http.dart' as http;
// import 'package:xml/xml.dart';
// import 'package:flutter/services.dart';
//
// void main() {
//   runApp(SegarTvApp());
// }
//
// class SegarTvApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Set landscape mode
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Segar TV',
//       theme: ThemeData.dark(),
//       home: SegarTvHomePage(),
//     );
//   }
// }
//
// class SegarTvHomePage extends StatefulWidget {
//   @override
//   _SegarTvHomePageState createState() => _SegarTvHomePageState();
// }
//
// class _SegarTvHomePageState extends State<SegarTvHomePage> {
//   FocusNode _focusNode = FocusNode();
//   int _selectedItemIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode.requestFocus();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Segar TV'),
//       ),
//       body: RawKeyboardListener(
//         focusNode: _focusNode,
//         onKey: (RawKeyEvent event) {
//           if (event is RawKeyDownEvent) {
//             if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
//               setState(() {
//                 _selectedItemIndex = (_selectedItemIndex - 1)
//                     .clamp(0, 5); // 5 is the total number of items
//               });
//             } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
//               setState(() {
//                 _selectedItemIndex = (_selectedItemIndex + 1)
//                     .clamp(0, 5); // 5 is the total number of items
//               });
//             } else if (event.logicalKey == LogicalKeyboardKey.select) {
//               _handleSelectKey(context);
//             }
//           }
//         },
//         child: SafeArea(
//           child: GridView.count(
//             crossAxisCount: 4,
//             children: [
//               GridItem(
//                 name: 'Sun TV',
//                 iconPath: 'ico/suntv.png',
//                 onTap: () => navigateToPlayerPage(context, 'suntv'),
//                 isSelected: _selectedItemIndex == 0,
//               ),
//               GridItem(
//                 name: 'Vijay TV',
//                 iconPath: 'ico/vijaytv.png',
//                 onTap: () => navigateToPlayerPage(context, 'vijaytv'),
//                 isSelected: _selectedItemIndex == 1,
//               ),
//               GridItem(
//                 name: 'K TV',
//                 iconPath: 'ico/ktv.png',
//                 onTap: () => navigateToPlayerPage(context, 'ktv'),
//                 isSelected: _selectedItemIndex == 2,
//               ),
//               GridItem(
//                 name: 'Isaiaruvi',
//                 iconPath: 'ico/isaiaruvi.png',
//                 onTap: () => navigateToPlayerPage(context, 'isaiaruvi'),
//                 isSelected: _selectedItemIndex == 3,
//               ),
//               GridItem(
//                 name: 'Sun Music',
//                 iconPath: 'ico/sunmusic.png',
//                 onTap: () => navigateToPlayerPage(context, 'sunmusic'),
//                 isSelected: _selectedItemIndex == 4,
//               ),
//               GridItem(
//                 name: 'Star Sports Tamil',
//                 iconPath: 'ico/starsport.png',
//                 onTap: () => navigateToPlayerPage(context, 'starsport'),
//                 isSelected: _selectedItemIndex == 5,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void navigateToPlayerPage(BuildContext context, String channelName) async {
//     // Fetch the XML file
//     final response = await http.get(Uri.parse(
//         'https://raw.githubusercontent.com/Chandirasegaran/segartv/main/tv.xml'));
//     final xmlData = response.body;
//
//     // Parse the XML and get the channel URL
//     final channelUrl = parseChannelUrl(xmlData, channelName);
//
//     if (channelUrl != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => MediaPlayerPage(channelUrl)),
//       );
//     }
//   }
//
//   String? parseChannelUrl(String xmlData, String channelName) {
//     final parsedData = XmlDocument.parse(xmlData);
//     final channelElements = parsedData.findAllElements('channel');
//     for (var channelElement in channelElements) {
//       final nameElement = channelElement.findElements('name');
//       if (nameElement.isNotEmpty && nameElement.first.text == channelName) {
//         final urlElement = channelElement.findElements('url');
//         if (urlElement.isNotEmpty) {
//           return urlElement.first.text;
//         }
//       }
//     }
//     return null;
//   }
//
//   void _handleSelectKey(BuildContext context) {
//     final GridItem item = context.findAncestorWidgetOfExactType<GridItem>()!;
//     item.onTap();
//   }
// }
//
// class GridItem extends StatelessWidget {
//   final String name;
//   final String iconPath;
//   final VoidCallback onTap;
//   final bool isSelected;
//
//   GridItem({
//     required this.name,
//     required this.iconPath,
//     required this.onTap,
//     required this.isSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.transparent,
//             width: 2.0,
//           ),
//         ),
//         child: Image.asset(
//           iconPath,
//           fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }
// }
//
// class MediaPlayerPage extends StatefulWidget {
//   final String channelUrl;
//
//   MediaPlayerPage(this.channelUrl);
//
//   @override
//   _MediaPlayerPageState createState() => _MediaPlayerPageState();
// }
//
// class _MediaPlayerPageState extends State<MediaPlayerPage> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.channelUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//         _controller.setLooping(true);
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RawKeyboardListener(
//         focusNode: FocusNode(),
//         onKey: (RawKeyEvent event) {
//           if (event is RawKeyDownEvent) {
//             if (event.logicalKey == LogicalKeyboardKey.select) {
//               _handleSelectKey();
//             }
//           }
//         },
//         child: Center(
//           child: _controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
//
//   void _handleSelectKey() {
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//     } else {
//       _controller.play();
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:video_player/video_player.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:xml/xml.dart';
// // import 'package:flutter/services.dart';
// //
// // void main() {
// //   runApp(SegarTvApp());
// // }
// //
// // class SegarTvApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     // Set landscape mode
// //     SystemChrome.setPreferredOrientations([
// //       DeviceOrientation.landscapeLeft,
// //       DeviceOrientation.landscapeRight,
// //     ]);
// //
// //     return Shortcuts(
// //       shortcuts: <LogicalKeySet, Intent>{
// //         LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
// //       },
// //       child: MaterialApp(
// //         debugShowCheckedModeBanner: false,
// //         title: 'Segar TV',
// //         theme: ThemeData.dark(),
// //         home: SegarTvHomePage(),
// //       ),
// //     );
// //   }
// // }
// //
// // class SegarTvHomePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Segar TV'),
// //       ),
// //       body: SafeArea(
// //         child: GridView.count(
// //           crossAxisCount: 4,
// //           children: [
// //             GridItem(
// //               name: 'Sun TV',
// //               iconPath: 'ico/suntv.png',
// //               onTap: () => navigateToPlayerPage(context, 'suntv'),
// //             ),
// //             GridItem(
// //               name: 'Vijay TV',
// //               iconPath: 'ico/vijaytv.png',
// //               onTap: () => navigateToPlayerPage(context, 'vijaytv'),
// //             ),
// //             GridItem(
// //               name: 'K TV',
// //               iconPath: 'ico/ktv.png',
// //               onTap: () => navigateToPlayerPage(context, 'ktv'),
// //             ),
// //             GridItem(
// //               name: 'Isaiaruvi',
// //               iconPath: 'ico/isaiaruvi.png',
// //               onTap: () => navigateToPlayerPage(context, 'isaiaruvi'),
// //             ),
// //             GridItem(
// //               name: 'Sun Music',
// //               iconPath: 'ico/sunmusic.png',
// //               onTap: () => navigateToPlayerPage(context, 'sunmusic'),
// //             ),
// //             GridItem(
// //               name: 'Star Sports Tamil',
// //               iconPath: 'ico/starsport.png',
// //               onTap: () => navigateToPlayerPage(context, 'starsport'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void navigateToPlayerPage(BuildContext context, String channelName) async {
// //     // Fetch the XML file
// //     final response = await http.get(Uri.parse(
// //         'https://raw.githubusercontent.com/Chandirasegaran/segartv/main/tv.xml'));
// //     final xmlData = response.body;
// //
// //     // Parse the XML and get the channel URL
// //     final channelUrl = parseChannelUrl(xmlData, channelName);
// //
// //     if (channelUrl != null) {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (context) => MediaPlayerPage(channelUrl)),
// //       );
// //     }
// //   }
// //
// //   String? parseChannelUrl(String xmlData, String channelName) {
// //     final parsedData = XmlDocument.parse(xmlData);
// //     final channelElements = parsedData.findAllElements('channel');
// //     for (var channelElement in channelElements) {
// //       final nameElement = channelElement.findElements('name');
// //       if (nameElement.isNotEmpty && nameElement.first.text == channelName) {
// //         final urlElement = channelElement.findElements('url');
// //         if (urlElement.isNotEmpty) {
// //           return urlElement.first.text;
// //         }
// //       }
// //     }
// //     return null;
// //   }
// // }
// //
// // class GridItem extends StatelessWidget {
// //   final String name;
// //   final String iconPath;
// //   final VoidCallback onTap;
// //
// //   GridItem({required this.name, required this.iconPath, required this.onTap});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         alignment: Alignment.center,
// //         child: Image.asset(
// //           iconPath,
// //           fit: BoxFit.fill,
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class MediaPlayerPage extends StatefulWidget {
// //   final String channelUrl;
// //
// //   MediaPlayerPage(this.channelUrl);
// //
// //   @override
// //   _MediaPlayerPageState createState() => _MediaPlayerPageState();
// // }
// //
// // class _MediaPlayerPageState extends State<MediaPlayerPage> {
// //   late VideoPlayerController _controller;
// //   late Future<void> _initializeVideoPlayerFuture;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = VideoPlayerController.network(widget.channelUrl)
// //       ..initialize().then((_) {
// //         setState(() {});
// //         _controller.play();
// //         _controller.setLooping(true);
// //       });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: RawKeyboardListener(
// //         focusNode: FocusNode(),
// //         onKey: (RawKeyEvent event) {
// //           if (event is RawKeyDownEvent) {
// //             if (event.logicalKey == LogicalKeyboardKey.select) {
// //               _handleSelectKey();
// //             }
// //           }
// //         },
// //         child: Center(
// //           child: _controller.value.isInitialized
// //               ? AspectRatio(
// //                   aspectRatio: _controller.value.aspectRatio,
// //                   child: VideoPlayer(_controller),
// //                 )
// //               : CircularProgressIndicator(),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void _handleSelectKey() {
// //     if (_controller.value.isPlaying) {
// //       _controller.pause();
// //     } else {
// //       _controller.play();
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }
// // }











---------------------------------------------------------











  import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  Wakelock.enable();
  runApp(SegarTvApp());
}

class SegarTvApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Segar TV',
      theme: ThemeData.dark(),
      home: SegarTvHomePage(),
    );
  }
}

class SegarTvHomePage extends StatefulWidget {
  @override
  _SegarTvHomePageState createState() => _SegarTvHomePageState();
}

class _SegarTvHomePageState extends State<SegarTvHomePage> {
  FocusNode _focusNode = FocusNode();
  int _selectedItemIndex = 0;
  CarouselController _carouselController = CarouselController();
  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.tv),
        title: Text('Segar TV'),
      ),
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              setState(() {
                _selectedItemIndex = (_selectedItemIndex - 1)
                    .clamp(0, 12); // 5 is the total number of items
              });
              _carouselController.previousPage();
            } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              setState(() {
                _selectedItemIndex = (_selectedItemIndex + 1)
                    .clamp(0, 13); // 5 is the total number of items
              });
              _carouselController.nextPage();
            } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
              setState(() {
                _selectedItemIndex =
                    (_selectedItemIndex - 4).clamp(0, 12); // 4 items per row
              });
            }
            // else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            //   setState(() {
            //     _selectedItemIndex =
            //         (_selectedItemIndex + 4).clamp(0, 12); // 4 items per row
            //   });
            // } else if (event.logicalKey == LogicalKeyboardKey.select ||
            //     event.logicalKey == LogicalKeyboardKey.enter) {
            //   _handleSelectKey(context);
            // }
          }
        },
        child: SafeArea(
          child: CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: double.infinity,
              initialPage: _selectedItemIndex,
              enableInfiniteScroll: false,
              viewportFraction: 0.25,
              enlargeCenterPage: true,
              onPageChanged: (index, _) {
                setState(() {
                  _selectedItemIndex = index;
                });
              },
            ),
            items: [
              GridItem(
                name: 'Sun TV',
                iconPath: 'ico/suntv.png',
                onTap: () => navigateToPlayerPage(context, 'suntv'),
                isSelected: _selectedItemIndex == 0,
              ),
              GridItem(
                name: 'Vijay TV',
                iconPath: 'ico/vijaytv.png',
                onTap: () => navigateToPlayerPage(context, 'vijaytv'),
                isSelected: _selectedItemIndex == 1,
              ),
              GridItem(
                name: 'K TV',
                iconPath: 'ico/ktv.png',
                onTap: () => navigateToPlayerPage(context, 'ktv'),
                isSelected: _selectedItemIndex == 2,
              ),
              GridItem(
                name: 'Isaiaruvi',
                iconPath: 'ico/isaiaruvi.png',
                onTap: () => navigateToPlayerPage(context, 'isaiaruvi'),
                isSelected: _selectedItemIndex == 3,
              ),
              GridItem(
                name: 'Sun Music',
                iconPath: 'ico/sunmusic.png',
                onTap: () => navigateToPlayerPage(context, 'sunmusic'),
                isSelected: _selectedItemIndex == 4,
              ),
              GridItem(
                name: 'Star Sports Tamil',
                iconPath: 'ico/starsport.png',
                onTap: () => navigateToPlayerPage(context, 'starsport'),
                isSelected: _selectedItemIndex == 5,
              ),
              GridItem(
                name: 'Polimer News',
                iconPath: 'ico/polimernews.png',
                onTap: () => navigateToPlayerPage(context, 'polimernews'),
                isSelected: _selectedItemIndex == 6,
              ),
              GridItem(
                name: 'News 18 Tamil Nadu',
                iconPath: 'ico/news18.png',
                onTap: () => navigateToPlayerPage(context, 'news18'),
                isSelected: _selectedItemIndex == 7,
              ),
              GridItem(
                name: 'Adithya TV',
                iconPath: 'ico/adthiya.png',
                onTap: () => navigateToPlayerPage(context, 'adthiya'),
                isSelected: _selectedItemIndex == 8,
              ),
              GridItem(
                name: 'Jaya TV',
                iconPath: 'ico/jayatv.png',
                onTap: () => navigateToPlayerPage(context, 'jayatv'),
                isSelected: _selectedItemIndex == 9,
              ),
              GridItem(
                name: 'Zee Tamil',
                iconPath: 'ico/zeetamil.png',
                onTap: () => navigateToPlayerPage(context, 'zeetamil'),
                isSelected: _selectedItemIndex == 10,
              ),
              GridItem(
                name: 'Sony Ten 4 Tamil',
                iconPath: 'ico/sonytentamil.png',
                onTap: () => navigateToPlayerPage(context, 'sonytentamil'),
                isSelected: _selectedItemIndex == 11,
              ),
              GridItem(
                name: 'Nick Tamil',
                iconPath: 'ico/nicktamil.png',
                onTap: () => navigateToPlayerPage(context, 'nicktamil'),
                isSelected: _selectedItemIndex == 12,
              ),
              GridItem(
                name: 'Chutti TV',
                iconPath: 'ico/chutti.png',
                onTap: () => navigateToPlayerPage(context, 'chutti'),
                isSelected: _selectedItemIndex == 13,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToPlayerPage(BuildContext context, String channelName) async {
    // Fetch the XML file
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Chandirasegaran/segartv/main/tv.xml'));
    final xmlData = response.body;

    // Parse the XML and get the channel URL
    final channelUrl = parseChannelUrl(xmlData, channelName);

    if (channelUrl != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MediaPlayerPage(channelUrl)),
      );
    }
  }

  String? parseChannelUrl(String xmlData, String channelName) {
    final parsedData = XmlDocument.parse(xmlData);
    final channelElements = parsedData.findAllElements('channel');
    for (var channelElement in channelElements) {
      final nameElement = channelElement.findElements('name');
      if (nameElement.isNotEmpty && nameElement.first.text == channelName) {
        final urlElement = channelElement.findElements('url');
        if (urlElement.isNotEmpty) {
          return urlElement.first.text;
        }
      }
    }
    return null;
  }

  // void _handleSelectKey(BuildContext context) {
  //   final GridItem item = context.findAncestorWidgetOfExactType<GridItem>()!;
  //   item.onTap();
  // }
  void _handleSelectKey(BuildContext context) {
    switch (_selectedItemIndex) {
      case 0:
        navigateToPlayerPage(context, 'suntv');
        break;
      case 1:
        navigateToPlayerPage(context, 'vijaytv');
        break;
      case 2:
        navigateToPlayerPage(context, 'ktv');
        break;
      case 3:
        navigateToPlayerPage(context, 'isaiaruvi');
        break;
      case 4:
        navigateToPlayerPage(context, 'sunmusic');
        break;
      case 5:
        navigateToPlayerPage(context, 'starsport');
        break;
      case 6:
        navigateToPlayerPage(context, 'polimernews');
        break;
      case 7:
        navigateToPlayerPage(context, 'news18');
        break;
      case 8:
        navigateToPlayerPage(context, 'news18');
        break;
      case 9:
        navigateToPlayerPage(context, 'jayatv');
        break;
      case 10:
        navigateToPlayerPage(context, 'zeetamil');
        break;
      case 11:
        navigateToPlayerPage(context, 'sonytentamil');
        break;
      case 12:
        navigateToPlayerPage(context, 'nicktamil');
        break;
      case 13:
        navigateToPlayerPage(context, 'chutti');
        break;
    }
    _carouselController.animateToPage(_selectedItemIndex);
  }
}

class GridItem extends StatelessWidget {
  final String name;
  final String iconPath;
  final VoidCallback onTap;
  final bool isSelected;

  GridItem({
    required this.name,
    required this.iconPath,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Image.asset(
          iconPath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class MediaPlayerPage extends StatefulWidget {
  final String channelUrl;

  MediaPlayerPage(this.channelUrl);

  @override
  _MediaPlayerPageState createState() => _MediaPlayerPageState();
}

class _MediaPlayerPageState extends State<MediaPlayerPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.channelUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
    Wakelock.enable();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double aspectRatio = screenWidth / screenHeight;
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.select) {
              _handleSelectKey();
            }
          }
        },
        child: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _handleSelectKey() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

