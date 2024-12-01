import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class FoundersScreen extends StatelessWidget {
  const FoundersScreen({Key? key}) : super(key: key);

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Creators', style: GoogleFonts.firaCode()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFounderCard(
            'Lars Bak & Kasper Lund',
            'Dart',
            'Created Dart at Google in 2011. The language was designed to create scalable web apps and later became the foundation for Flutter.',
            'https://miro.medium.com/max/1400/1*gF6QcpR6wCezvQtoYG9pEQ.jpeg',
            Colors.blue,
            'https://en.wikipedia.org/wiki/Lars_Bak_(computer_programmer)',
          ),
          const SizedBox(height: 16),
          _buildFounderCard(
            'Guido van Rossum',
            'Python',
            'Created Python in 1991. Python was designed to emphasize code readability with its notable use of significant whitespace.',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Guido_van_Rossum_OSCON_2006.jpg/1200px-Guido_van_Rossum_OSCON_2006.jpg',
            Colors.green,
            'https://en.wikipedia.org/wiki/Guido_van_Rossum',
          ),
          const SizedBox(height: 16),
          _buildFounderCard(
            'Brendan Eich',
            'JavaScript',
            'Created JavaScript in 1995 while at Netscape. The language was originally created for the Netscape browser.',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Brendan_Eich_Mozilla_Foundation_official_photo.jpg/1200px-Brendan_Eich_Mozilla_Foundation_official_photo.jpg',
            Colors.yellow,
            'https://en.wikipedia.org/wiki/Brendan_Eich',
          ),
          const SizedBox(height: 16),
          _buildFounderCard(
            'James Gosling',
            'Java',
            'Created Java at Sun Microsystems in 1995. Java was designed to be platform-independent: "Write once, run anywhere".',
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/James_Gosling_2008.jpg/1200px-James_Gosling_2008.jpg',
            Colors.orange,
            'https://en.wikipedia.org/wiki/James_Gosling',
          ),
        ],
      ),
    );
  }

  Widget _buildFounderCard(
    String name,
    String language,
    String description,
    String imageUrl,
    Color color,
    String wikipediaUrl,
  ) {
    return Builder(
      builder: (context) => Card(
        elevation: 4,
        child: InkWell(
          onTap: () => _launchURL(wikipediaUrl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 250,
                    color: color.withOpacity(0.2),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 250,
                    color: color.withOpacity(0.2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, size: 64, color: color),
                        const SizedBox(height: 8),
                        Text(
                          name,
                          style: GoogleFonts.firaCode(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.firaCode(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      language,
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: GoogleFonts.firaCode(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
