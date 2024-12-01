import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final Map<String, Map<String, dynamic>> _languages = {
    'Dart': {
      'videoId': 'Ej_Pcr4uC2Q',
      'description': 'A client-optimized language for fast apps on any platform',
      'features': [
        'Object-oriented programming',
        'Garbage collection',
        'Rich standard library',
        'Strong typing',
        'Async/await support',
      ],
      'documentation': 'https://dart.dev/guides',
      'thumbnail': 'https://dart.dev/assets/img/shared/dart-logo-for-shares.png?2',
    },
    'Python': {
      'videoId': 'rfscVS0vtbw',
      'description': 'A versatile language known for its simplicity and readability',
      'features': [
        'Easy to learn and read',
        'Large standard library',
        'Dynamic typing',
        'Extensive third-party packages',
        'Cross-platform',
      ],
      'documentation': 'https://docs.python.org/3/',
      'thumbnail': 'https://www.python.org/static/community_logos/python-logo-generic.svg',
    },
    'JavaScript': {
      'videoId': 'PkZNo7MFNFg',
      'description': 'The programming language of the web',
      'features': [
        'First-class functions',
        'Dynamic typing',
        'Object-oriented',
        'Event-driven programming',
        'Rich ecosystem',
      ],
      'documentation': 'https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide',
      'thumbnail': 'https://upload.wikimedia.org/wikipedia/commons/6/6a/JavaScript-logo.png',
    },
    'Java': {
      'videoId': 'eIrMbAQSU34',
      'description': 'Write once, run anywhere',
      'features': [
        'Object-oriented',
        'Platform independence',
        'Automatic memory management',
        'Rich API',
        'Strong community',
      ],
      'documentation': 'https://docs.oracle.com/en/java/',
      'thumbnail': 'https://www.oracle.com/a/tech/img/cb88-java-logo-001.jpg',
    },
  };

  String _selectedLanguage = 'Dart';

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _watchTutorial() {
    final videoId = _languages[_selectedLanguage]!['videoId'];
    final url = Uri.parse('https://www.youtube.com/watch?v=$videoId');
    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn', style: GoogleFonts.firaCode()),
        actions: [
          DropdownButton<String>(
            value: _selectedLanguage,
            dropdownColor: Theme.of(context).primaryColor,
            style: GoogleFonts.firaCode(color: Colors.white),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedLanguage = newValue;
                });
              }
            },
            items: _languages.keys
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selectedLanguage,
                style: GoogleFonts.firaCode(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _languages[_selectedLanguage]!['description'],
                style: GoogleFonts.firaCode(fontSize: 16),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _watchTutorial,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade800,
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: 'https://img.youtube.com/vi/${_languages[_selectedLanguage]!['videoId']}/maxresdefault.jpg',
                          placeholder: (context, url) => Container(
                            height: 200,
                            color: Colors.grey.shade900,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 200,
                            color: Colors.grey.shade900,
                            child: const Icon(Icons.error),
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Key Features',
                style: GoogleFonts.firaCode(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: (_languages[_selectedLanguage]!['features'] as List)
                    .map((feature) => ListTile(
                          leading: const Icon(Icons.check_circle_outline),
                          title: Text(
                            feature,
                            style: GoogleFonts.firaCode(),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _launchURL(
                    _languages[_selectedLanguage]!['documentation']),
                icon: const Icon(Icons.book),
                label: Text(
                  'Official Documentation',
                  style: GoogleFonts.firaCode(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
