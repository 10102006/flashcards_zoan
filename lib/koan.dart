class Koan {
  final String koan;
  final String meaning;
  bool liked = false;
  List<Map<String, String>> interpretations = [
    {
      'Date': "23/10",
      'Meaning': "lorem ipsum dore tho",
    }
  ];
  // {'Date' : '10/10/2006', "Meaning" : "Lorem ipsum dore"}

  Koan({required this.koan, required this.meaning});

  addInterpretation(String date, String interpretation) {
    interpretations.add({
      'Date': date,
      'Meaning': interpretation,
    });
  }

  likeKoan() {
    liked = !liked;
  }
}

final List<Koan> koans = [
  Koan(
    koan: "Question?",
    meaning: 'Lorem ipsum dore',
  ),
  Koan(
    koan: "1. Question?",
    meaning: 'Lorem ipsum dore Lorem ipsum dore',
  ),
  Koan(
    koan: "2. Question?",
    meaning: 'Lorem ipsum dore Lorem ipsum dore Lorem ipsum dore',
  ),
  Koan(
    koan: "3. Question?",
    meaning:
        'Lorem ipsum dore Lorem ipsum dore \n Lorem ipsum dore Lorem ipsum dore',
  ),
];
int currentIndex = 0;
List koanInterpretations = koans[currentIndex].interpretations;
