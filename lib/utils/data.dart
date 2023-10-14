import 'package:leva_matrimonial/enums/marital_status.dart';

class Data {
  static const List<String> countryCodeList = ['+91','+1'];
  
  static const List<String> eduCategories = [
    "M.S. / M.D. / M.B.B.S",
    "B.D.S. / M.D.S.",
    "AYUERVED / PHYSIO / VETERNARY",
    "ARCHITECTURE / LAW /C.A /C.F.A/C.S.",
    "Ph. D",
    "M.E. / M. TECH / M.S. / B.E. + M.B.A.",
    "B.E. / B.TECH / B. Sc TECH",
    "PHARMACY",
    "B.Sc / M.Sc /M.C.A. /M.B.A/ B.C.S. / B.C.A. /M.C.S. / M.C.M",
    "DIPLOMA (ALL)",
    "M.Com/M.A./M.S.W. / B.COM/ HOTEL MANAGEMENT / B. LIB",
    "M.Ed/ B.Ed/D.Ed/M.PHIL M.PED",
    "10TH 12 TH",
    "I.T.I",
    "FARMER",
  ];

 static Map<MaritalStatus,String> maritalStatusLabels = {
    MaritalStatus.notmarried:"Not Married",
    MaritalStatus.divorced: "Divorced/Widowed" 
  };

  static const List<String> gotras = [
    "अत्री",
    "आत्रेय",
    "अगस्थ",
    "अंगीरस",
    "अनंत",
    "कपिलमुनी",
    "कौशिक",
    "काश्यप",
    "कश्यप",
    "कौण्डिण्य",
    "कण्व",
    "कुशिक",
    "कार्तिक",
    "कलकी",
    "कल्की",
    "कालंकी",
    "कैवल्य",
    "गौतम",
    "गंधर्व",
    "गर्ग",
    "गर्गाचार्य",
    "गोकर्ण",
    "गौलव",
    "गहीलव",
    "गालव",
    "पाराशर",
    "देवमुनी",
    "देवल",
    "पौलस्य",
    "बगदालभ्य",
    "बलव",
    "बालव",
    "ब्रह्मचारी",
    "ब्रह्मष्री",
    "भ्रमाचार्य",
    "ब्राह्मणी",
    "भर्माचार्य",
    "भारद्वाज",
    "भार्गव",
    "भृगू",
    "भृशुंडी",
    "भृपाचार्य",
    "मार्कंडेय",
    "मार्कंड",
    "मार्तंड",
    "मांडव्य",
    "मातंग",
    "मारीच",
    "लोकाक्ष",
    "दुर्वास",
    "धृतकौशिक",
    "वसिष्ठ",
    "विश्वामित्रा",
    "वात्स्य",
    "शुनक",
    "शौनक",
    "वामदेव",
    "वामन",
    "शांडील्य",
    "मरिची",
    "उदालक",
    "लोहित",
    "लवंबन",
    "मध्यम",
    "लोमश",
    "लोमेश",
    "वाल्मिकी",
    "वाल्यम",
    "विश्वामित्र",
    "विभांडक",
    "शुकमुनी",
    "शृंग",
    "शृंगव",
    "सनकादिस",
    "सनकादिक",
  ];

  static List<String> varns = [
    "गोरा",
    "निमगोरा",
    "गव्हाळ",
  ];

  static List<String> get heights => heightRanges.expand((e) => e).toList();

  static const List<List<String>> heightRanges = [
    [
      "4.10",
      "4.11",
    ],
    [
      "5.0",
      "5.1",
      "5.2",
      "5.3",
      "5.4",
      "5.5",
    ],
    [
      "5.6",
      "5.7",
      "5.8",
      "5.9",
      "5.10",
      "5.11",
    ],
    [
      "6.0",
      "6.1",
      "6.2",
      "6.3",
      "6.4",
    ]
  ];

  static const List<String> heightLabels = [
    "4.10 to 4.11",
    "5.0 to 5.5",
    "5.6 to 5.11",
    "6.0 to 6.4",
  ];
}
