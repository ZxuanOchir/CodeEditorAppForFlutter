import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class CodeEditorScreen extends StatefulWidget {
  const CodeEditorScreen({Key? key}) : super(key: key);

  @override
  State<CodeEditorScreen> createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  String _selectedLanguage = 'Dart';
  final TextEditingController _codeController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  double _fontSize = 14.0;
  bool _wordWrap = true;
  bool _isEditing = false;

  final Map<String, String> _languageMap = {
    'Dart': 'dart',
    'Python': 'python',
    'JavaScript': 'javascript',
    'Java': 'java',
  };

  final Map<String, String> _examples = {
    'Dart': '''void main() {
  print('Hello, Dart!');
  
  // Variables
  var name = 'John';
  int age = 25;
  double height = 1.75;
  
  // String interpolation
  print('Name: \$name, Age: \$age, Height: \$height');
  
  // Lists
  var numbers = [1, 2, 3, 4, 5];
  print('Numbers: \$numbers');
  
  // Functions
  int add(int a, int b) => a + b;
  print('2 + 3 = \${add(2, 3)}');
}''',
    'Python': '''def main():
    print("Hello, Python!")
    
    # Variables
    name = "John"
    age = 25
    height = 1.75
    
    # String formatting
    print(f"Name: {name}, Age: {age}, Height: {height}")
    
    # Lists
    numbers = [1, 2, 3, 4, 5]
    print(f"Numbers: {numbers}")
    
    # Functions
    def add(a, b):
        return a + b
    
    print(f"2 + 3 = {add(2, 3)}")

if __name__ == "__main__":
    main()''',
    'JavaScript': '''function main() {
  console.log("Hello, JavaScript!");
  
  // Variables
  let name = "John";
  let age = 25;
  let height = 1.75;
  
  // String concatenation
  console.log("Name: " + name + ", Age: " + age + ", Height: " + height);
  
  // Arrays
  let numbers = [1, 2, 3, 4, 5];
  console.log("Numbers: " + numbers);
  
  // Arrow functions
  const add = (a, b) => a + b;
  console.log("2 + 3 = " + add(2, 3));
}

main();''',
    'Java': '''public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, Java!");
        
        // Variables
        String name = "John";
        int age = 25;
        double height = 1.75;
        
        // String formatting
        System.out.printf("Name: %s, Age: %d, Height: %.2f%n", 
            name, age, height);
        
        // Arrays
        int[] numbers = {1, 2, 3, 4, 5};
        System.out.println("Numbers: " + 
            java.util.Arrays.toString(numbers));
        
        // Method call
        System.out.println("2 + 3 = " + add(2, 3));
    }
    
    public static int add(int a, int b) {
        return a + b;
    }
}'''
  };

  @override
  void initState() {
    super.initState();
    _codeController.text = _examples[_selectedLanguage]!;
  }

  @override
  void dispose() {
    _codeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: _codeController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _clearCode() {
    setState(() {
      _codeController.clear();
    });
  }

  void _resetCode() {
    setState(() {
      _codeController.text = _examples[_selectedLanguage]!;
    });
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Editor Settings',
                style: GoogleFonts.firaCode(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Font Size: ${_fontSize.toInt()}',
                    style: GoogleFonts.firaCode(),
                  ),
                  Expanded(
                    child: Slider(
                      value: _fontSize,
                      min: 10,
                      max: 30,
                      divisions: 20,
                      onChanged: (value) {
                        setState(() => _fontSize = value);
                        this.setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Word Wrap',
                    style: GoogleFonts.firaCode(),
                  ),
                  const SizedBox(width: 16),
                  Switch(
                    value: _wordWrap,
                    onChanged: (value) {
                      setState(() => _wordWrap = value);
                      this.setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code Editor', style: GoogleFonts.firaCode()),
        actions: [
          DropdownButton<String>(
            value: _selectedLanguage,
            dropdownColor: Theme.of(context).primaryColor,
            style: GoogleFonts.firaCode(color: Colors.white),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedLanguage = newValue;
                  _codeController.text = _examples[newValue]!;
                });
              }
            },
            items: _examples.keys
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: _copyCode,
            tooltip: 'Copy code',
          ),
          IconButton(
            icon: const Icon(Icons.restore),
            onPressed: _resetCode,
            tooltip: 'Reset code',
          ),
          IconButton(
            icon: Icon(_isEditing ? Icons.visibility : Icons.edit),
            onPressed: _toggleEditMode,
            tooltip: _isEditing ? 'View mode' : 'Edit mode',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettings,
            tooltip: 'Editor settings',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade800,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(8),
                        ),
                      ),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _codeController.text.split('\n').length,
                        itemBuilder: (context, index) => Container(
                          height: 24,
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 1}',
                            style: GoogleFonts.firaCode(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _isEditing
                          ? TextField(
                              controller: _codeController,
                              maxLines: null,
                              style: GoogleFonts.firaCode(
                                color: Colors.white,
                                fontSize: _fontSize,
                                height: 1.5,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                              ),
                              onChanged: (value) => setState(() {}),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: _wordWrap
                                    ? MediaQuery.of(context).size.width - 96
                                    : null,
                                child: HighlightView(
                                  _codeController.text,
                                  language: _languageMap[_selectedLanguage]!
                                      .toLowerCase(),
                                  theme: monokaiSublimeTheme,
                                  padding: const EdgeInsets.all(16),
                                  textStyle: GoogleFonts.firaCode(
                                    fontSize: _fontSize,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Lines: ${_codeController.text.split('\n').length}',
                      style: GoogleFonts.firaCode(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Characters: ${_codeController.text.length}',
                      style: GoogleFonts.firaCode(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (_isEditing)
                      TextButton.icon(
                        onPressed: _clearCode,
                        icon: const Icon(Icons.clear),
                        label: Text(
                          'Clear',
                          style: GoogleFonts.firaCode(),
                        ),
                      ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Code Output',
                              style: GoogleFonts.firaCode(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Language: $_selectedLanguage',
                                  style: GoogleFonts.firaCode(),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Note: This is a demo app. For security reasons, code execution is not implemented. In a production environment, you would need a secure backend service to compile and run code safely.',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: Text(
                        'Run Code',
                        style: GoogleFonts.firaCode(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
