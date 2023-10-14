import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/models/marriage_profile.dart';
import 'package:leva_matrimonial/ui/providers/loading_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import '../../../enums/gender.dart';
import '../../../utils/data.dart';
import '../../../utils/formats.dart';
import '../../../utils/labels.dart';

final generateProvider = Provider((ref) => Generate(ref));

class Generate {
  final Ref _ref;

  Generate(this._ref);

  Loading get _loading => _ref.read(loadingProvider);

  Future<File?> create(MarriageProfile profile) async {
    try {
      _loading.start();
      final font = await rootBundle.load("assets/mr.ttf");

      final ttf = Font.ttf(font);

      final pdf = Document();

      Widget row(String key, String value) {
        return Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    key,
                    style: TextStyle(color: PdfColors.grey, font: ttf),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    value,
                    style: TextStyle(font: ttf),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      final netImage = profile.image != null
          ? await networkImage(profile.image!, cache: false)
          : null;

      pdf.addPage(
        Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            row("Name", profile.name),
                            row("${profile.gender == Gender.male ? "वराचे" : "वधूचे"} नाव",
                                profile.nameM),
                            row("पाटिल", "पाटिल"),
                            row(
                                "Marital Status",
                                Data.maritalStatusLabels[
                                        profile.maritalStatus] ??
                                    ''),
                            row(
                              "Address",
                              "${profile.originalFrom}, ${profile.taluka}, ${profile.district}",
                            ),
                            row("Birth Name (जन्म नाव)", profile.birthName),
                            row("Birth Date (जन्म तारीख)",
                                Formats.date(profile.birth)),
                            row("Birth Time (जन्म वेळ)",
                                Formats.time(profile.birth)),
                            row("Height (उंची)", profile.height),
                            row("Gotr (गोत्र)", profile.gotr),
                            row("Varn Complexion (वर्ण)", profile.varn),
                          ],
                        ),
                      ),
                      if (netImage != null) Expanded(child: Image(netImage)),
                    ],
                  ),
                  Divider(),
                  row("Education (शिक्षण)", profile.education),
                  row("Education Category (शैक्षणिक वर्गीकरण)",
                      profile.eduCategory),
                  if (profile.job != null)
                    row(
                      "नोकरी पद/हुद्दा (Job Designation)",
                      profile.job!,
                    ),
                  if (profile.company != null)
                    row(
                      "नोकरी कंपनी",
                      profile.company!,
                    ),
                  if (profile.jobPlace != null)
                    row(
                      "नोकरी स्थळ",
                      profile.jobPlace!,
                    ),
                  if (profile.salary != null)
                    row(
                      "Monthly Salary (मासिक उत्पन्न)",
                      "${Labels.rupee}${profile.salary} per month",
                    ),
                  row("Expectation (अपेक्षा)", profile.expectation),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      "Family",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  row("Number of Sisters",
                      "${profile.unmarriedSisters} (Married: ${profile.marriedSisters})"),
                  row("Number of Brothers",
                      "${profile.unmarriedBrothers} (Married: ${profile.marriedBrothers})"),
                  row("वडिलांचे नाव", profile.fatherNameM),
                  row("वडिलांचा पत्ता", profile.fatherAddress),
                  row("वडिलांची नोकरी", profile.fatherDesignation),
                ]);
          },
        ),
      );
      pdf.addPage(
        Page(
          build: (context) {
            return Column(children: [
              row("Father(वडिलांचा) mobile no. 1", profile.fatherMobile1),
              if (profile.fatherMobile2 != null)
                row(
                  "Father(वडिलांचा) mobile no. 2",
                  profile.fatherMobile2!,
                ),
              if (profile.contact1 != null)
                row(
                  "Contact Name(संपर्काचे नाव) 1",
                  profile.contactName1,
                ),
              if (profile.contact1 != null)
                row(
                  "Contact(संपर्क) no. 1",
                  profile.contact1!,
                ),
              if (profile.contact2 != null)
                row(
                  "Contact Name(संपर्काचे नाव) 2",
                  profile.contactName2,
                ),
              if (profile.contact2 != null)
                row(
                  "Contact(संपर्क) no. 2",
                  profile.contact2!,
                ),
            ]);
          },
        ),
      );
      final file = File(
          "/storage/emulated/0/Download/${profile.name} marriage resume.pdf");
      await file.writeAsBytes(await pdf.save());
      _loading.stop();
      return file;
    } catch (e) {
      print(e);
      _loading.stop();
    }
  }
}
