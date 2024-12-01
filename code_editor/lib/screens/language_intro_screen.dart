import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageIntroScreen extends StatelessWidget {
  const LanguageIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ProgrammingLanguage> languages = [
      ProgrammingLanguage(
        name: 'Dart',
        description:
            'Dart is a client-optimized programming language for fast apps on multiple platforms. '
            'It is developed by Google and is used to build mobile, desktop, web, and server applications.',
        features: [
          'Object-oriented',
          'Garbage-collected',
          'Class-based',
          'Strong typing',
        ],
        useCases: [
          'Mobile development with Flutter',
          'Web applications',
          'Server-side development',
        ],
        yearCreated: 2011,
        creator: 'Google',
        logo: 'https://dart.dev/assets/img/shared/dart/logo+text/horizontal/white.svg',
        primaryColor: Colors.blue,
      ),
      ProgrammingLanguage(
        name: 'JavaScript',
        description:
            'JavaScript is a high-level, interpreted programming language that conforms to the ECMAScript specification. '
            'It is multi-paradigm, supporting event-driven, functional, and imperative programming styles.',
        features: [
          'Dynamic typing',
          'First-class functions',
          'Object-oriented',
          'Prototype-based',
        ],
        useCases: [
          'Web development',
          'Server-side development (Node.js)',
          'Mobile development',
          'Desktop applications',
        ],
        yearCreated: 1995,
        creator: 'Brendan Eich',
        logo: 'https://upload.wikimedia.org/wikipedia/commons/6/6a/JavaScript-logo.png',
        primaryColor: Colors.yellow[700]!,
      ),
      ProgrammingLanguage(
        name: 'Java',
        description:
            'Java is a class-based, object-oriented programming language designed to have as few implementation '
            'dependencies as possible. It follows the principle of WORA (Write Once, Run Anywhere).',
        features: [
          'Object-oriented',
          'Platform independent',
          'Secure',
          'Robust',
        ],
        useCases: [
          'Enterprise software',
          'Android development',
          'Web applications',
          'Cloud computing',
        ],
        yearCreated: 1995,
        creator: 'James Gosling at Sun Microsystems',
        logo: 'https://www.oracle.com/a/ocom/img/cb71-java-logo.png',
        primaryColor: Colors.red,
      ),
      ProgrammingLanguage(
        name: 'C++',
        description:
            'C++ is a general-purpose programming language created as an extension of the C programming language. '
            'It supports procedural, object-oriented, and generic programming.',
        features: [
          'Object-oriented',
          'Low-level memory manipulation',
          'Fast and efficient',
          'Rich standard library',
        ],
        useCases: [
          'System programming',
          'Game development',
          'Resource-constrained applications',
          'High-performance computing',
        ],
        yearCreated: 1985,
        creator: 'Bjarne Stroustrup',
        logo: 'https://isocpp.org/assets/images/cpp_logo.png',
        primaryColor: Colors.blue[800]!,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Programming Languages',
          style: GoogleFonts.firaCode(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
      ),
      body: Container(
        color: Colors.blueGrey[900],
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final language = languages[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                title: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: language.primaryColor.withOpacity(0.2),
                    child: Text(
                      language.name[0],
                      style: TextStyle(
                        color: language.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    language.name,
                    style: GoogleFonts.firaCode(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    'Created in ${language.yearCreated} by ${language.creator}',
                    style: GoogleFonts.firaCode(fontSize: 12),
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: GoogleFonts.firaCode(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          language.description,
                          style: GoogleFonts.firaCode(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Key Features',
                          style: GoogleFonts.firaCode(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: language.features.map((feature) {
                            return Chip(
                              label: Text(
                                feature,
                                style: GoogleFonts.firaCode(fontSize: 12),
                              ),
                              backgroundColor: language.primaryColor.withOpacity(0.1),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Common Use Cases',
                          style: GoogleFonts.firaCode(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: language.useCases.map((useCase) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_right,
                                    color: language.primaryColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      useCase,
                                      style: GoogleFonts.firaCode(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProgrammingLanguage {
  final String name;
  final String description;
  final List<String> features;
  final List<String> useCases;
  final int yearCreated;
  final String creator;
  final String logo;
  final Color primaryColor;

  const ProgrammingLanguage({
    required this.name,
    required this.description,
    required this.features,
    required this.useCases,
    required this.yearCreated,
    required this.creator,
    required this.logo,
    required this.primaryColor,
  });
}
