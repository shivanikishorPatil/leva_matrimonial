import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/enums/gender.dart';
import 'package:leva_matrimonial/enums/role.dart';
import 'package:leva_matrimonial/enums/status.dart';
import 'package:leva_matrimonial/models/marriage_profile.dart';
import 'package:leva_matrimonial/repositories/marriage_profile_repository_provider.dart';
import 'package:leva_matrimonial/repositories/pdf_repository_pprovider.dart';
import 'package:leva_matrimonial/ui/components/big_button.dart';
import 'package:leva_matrimonial/ui/components/loading_layer.dart';
import 'package:leva_matrimonial/ui/components/snackbar.dart';
import 'package:leva_matrimonial/ui/marriage_profile/providers/marriage_profile_provider.dart';
import 'package:leva_matrimonial/ui/marriage_profile/providers/write_marriage_profile_provider.dart';
import 'package:leva_matrimonial/ui/marriage_profile/write_family_details_page.dart';
import 'package:leva_matrimonial/ui/marriage_profile/write_personal_details_page.dart';
import 'package:leva_matrimonial/ui/marriage_profile/write_professional_details_page.dart';
import 'package:leva_matrimonial/ui/pdf/providers/generate.dart';
import 'package:leva_matrimonial/ui/profile/providers/profile_provider.dart';
import 'package:leva_matrimonial/utils/data.dart';
import 'package:leva_matrimonial/utils/formats.dart';
import 'package:leva_matrimonial/utils/labels.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../providers/loading_provider.dart';
import 'widgets/info_tile.dart';
import 'widgets/submit_dialog.dart';

class DetailsPage extends ConsumerWidget {
  DetailsPage({Key? key, required this.mProfile}) : super(key: key);

  MarriageProfile mProfile;
  static const route = "/details";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final scheme = theme.colorScheme;
    final user = ref.read(profileProvider).value!;
    final isAdmin = user.role == Role.admin;
    final isMy = user.id == mProfile.id;
    final generate = ref.read(generateProvider);
    final pdf = ref.read(pdfRepoProvider);
    final profile = ref.watch(profileFutureProvider(mProfile.id)).value;
    if (isMy) {
      mProfile = ref.watch(marriageProfileProvider).value!;
    }
    void edit(String name) async {
      final model = ref.read(writeMarriageProfileProvider);
      model.initial = mProfile;
      await Navigator.pushNamed(context, name);
      model.clear();
    }

    void update(Status status, String name) async {
      final value = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
              "Are you sure you want to ${name.toLowerCase()} this profile?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("NO"),
            ),
            MaterialButton(
              color: scheme.primary,
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("YES"),
            ),
          ],
        ),
      );
      if (value ?? false) {
        int number = await ref
            .read(marriageProfileRepositoryProvider)
            .getNumberOfApprovedProfiles(mProfile.gender!);
        print(number);
        if (mProfile.gender == Gender.male) {
          ref.read(marriageProfileRepositoryProvider).update(
              status: status, id: mProfile.id, number: (number + 30000));
        }
        if (mProfile.gender == Gender.female) {
          ref.read(marriageProfileRepositoryProvider).update(
              status: status, id: mProfile.id, number: (number + 25000));
        }

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }

    return LoadingLayer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Matrimonial Profile"),
          actions: [
            if (mProfile.status == Status.approved)
              if (isMy || isAdmin)
                IconButton(
                  onPressed: () async {
                    // try {
                    //   var status = await Permission.storage.status;
                    //   if (!status.isGranted) {
                    //     await Permission.storage.request();
                    //   }
                    //   await generate.create(mProfile);
                    //   AppSnackbar(context).message("Saved to Downloads");
                    // } catch (e) {}
                    try {
                      print(mProfile.id);
                      var status = await Permission.storage.status;
                      if (!status.isGranted) {
                        await Permission.storage.request();
                      }
                      final loading = ref.read(loadingProvider);
                      loading.start();
                      String? url = await pdf.checkPDF(mProfile.id);
                      if (url != null) {
                        await pdf.downloadFile(url, mProfile.name);
                      } else {
                        final response = await http.post(
                            Uri.parse(CloudFunctionApi.prodPDF),
                            body: {"id": mProfile.id});
                        if (response.statusCode == 200) {
                          String? url = await pdf.checkPDF(mProfile.id);
                          if (url != null) {
                            await pdf.downloadPDF(url, mProfile.name);
                          } else {
                            final response = await http.post(
                                Uri.parse(CloudFunctionApi.prodPDF),
                                body: {"id": mProfile.id});
                            if (response.statusCode == 200) {
                              String? url = await pdf.checkPDF(mProfile.id);
                              if (url != null) {
                                await pdf.downloadFile(url, mProfile.name);
                              }
                            }
                          }
                        }
                      }
                      await Future.delayed(const Duration(seconds: 5));
                      // Navigator.pop(context);
                      AppSnackbar(context).message("Saved to Downloads");
                      loading.stop();
                    } catch (e) {}
                  },
                  icon: const Icon(Icons.download),
                ),
          ],
        ),
        bottomNavigationBar: mProfile.needProfessionalDetails ||
                mProfile.needFamilyDetails
            ? Padding(
                padding: const EdgeInsets.all(24).copyWith(top: 0),
                child: BigButton(
                  label: "Complete Form",
                  onPressed: () {
                    edit(mProfile.needProfessionalDetails
                        ? WriteProfessionalDetailsPage.route
                        : WriteFamilyDetailsPage.route);
                  },
                ),
              )
            : mProfile.status == Status.draft
                ? Padding(
                    padding: const EdgeInsets.all(24).copyWith(top: 0),
                    child: BigButton(
                      label: "SUBMIT",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              SubmitDialog(id: mProfile.id),
                        );
                      },
                    ),
                  )
                : isAdmin
                    ? SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: Row(
                            children: [
                              if ([Status.approved, Status.pending]
                                  .contains(mProfile.status))
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: MaterialButton(
                                      color: scheme.errorContainer,
                                      onPressed: () =>
                                          update(Status.rejected, "REJECT"),
                                      child: Text("REJECT"),
                                    ),
                                  ),
                                ),
                              if ([Status.rejected, Status.pending]
                                  .contains(mProfile.status))
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: MaterialButton(
                                      color: scheme.tertiaryContainer,
                                      onPressed: () =>
                                          update(Status.approved, "APPROVE"),
                                      child: Text("APPROVE"),
                                    ),
                                  ),
                                ),
                              if (mProfile.status == Status.approved)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: MaterialButton(
                                      color: scheme.secondaryContainer,
                                      onPressed: () => update(
                                          Status.married, "set as married"),
                                      child: Text("MARRIED"),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    : null,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: scheme.tertiaryContainer,
                    child: mProfile.thumbnail != null
                        ? Image.network(
                            mProfile.thumbnail!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person_rounded,
                            size: 100,
                            color: scheme.tertiary,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Details",
                            style: style.titleMedium!
                                .copyWith(color: scheme.primary),
                          ),
                          InfoTile(
                            name: "Name",
                            value: mProfile.name,
                          ),
                          InfoTile(
                            name:
                                "${mProfile.gender == Gender.male ? "वराचे" : "वधूचे"} नाव",
                            value: mProfile.nameM,
                          ),
                          InfoTile(
                            name: "Type",
                            value:
                                mProfile.gender == Gender.male ? "वर" : "वधू",
                          ),
                          InfoTile(
                            name: "Marital Status",
                            value: Data.maritalStatusLabels[
                                    mProfile.maritalStatus] ??
                                '',
                          ),
                          InfoTile(
                            name: "Address",
                            value:
                                "${mProfile.originalFrom}, ${mProfile.taluka}, ${mProfile.district}",
                          ),
                          InfoTile(
                            name: "Birth Name (जन्म नाव)",
                            value: mProfile.birthName,
                          ),
                          InfoTile(
                            name: "Birth Date (जन्म तारीख)",
                            value: Formats.date(mProfile.birth),
                          ),
                          InfoTile(
                            name: "Birth Time (जन्म वेळ)",
                            value: Formats.time(mProfile.birth),
                          ),
                          InfoTile(
                            name: "Height (उंची)",
                            value: mProfile.height,
                          ),
                          InfoTile(
                            name: "Gotr (गोत्र)",
                            value: mProfile.gotr,
                          ),
                          InfoTile(
                            name: "Varn Complexion (वर्ण)",
                            value: mProfile.varn,
                          ),
                        ],
                      ),
                    ),
                    if (isMy && !(mProfile.status == Status.approved))
                      Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            edit(WritePersonalDetailsPage.route);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                  ],
                ),
              ),
              mProfile.needProfessionalDetails
                  ? Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, WriteProfessionalDetailsPage.route);
                        },
                        title: const Text("Enter Professional Details"),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    )
                  : Card(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Professional Details",
                                  style: style.titleMedium!
                                      .copyWith(color: scheme.primary),
                                ),
                                InfoTile(
                                  name: "Education (शिक्षण)",
                                  value: mProfile.education,
                                ),
                                InfoTile(
                                  name:
                                      "Education Category (शैक्षणिक वर्गीकरण)",
                                  value: mProfile.eduCategory,
                                ),
                                if (mProfile.job != null)
                                  InfoTile(
                                    name: "नोकरी पद/हुद्दा (Job Designation)",
                                    value: mProfile.job!,
                                  ),
                                if (mProfile.company != null)
                                  InfoTile(
                                    name: "नोकरी कंपनी",
                                    value: mProfile.company!,
                                  ),
                                if (mProfile.jobPlace != null)
                                  InfoTile(
                                    name: "नोकरी स्थळ",
                                    value: mProfile.jobPlace!,
                                  ),
                                if (mProfile.salary != null)
                                  InfoTile(
                                    name: "Monthly Salary (मासिक उत्पन्न)",
                                    value:
                                        "${Labels.rupee}${mProfile.salary} per month",
                                  ),
                                InfoTile(
                                  name: "Expectation (अपेक्षा)",
                                  value: mProfile.expectation,
                                ),
                              ],
                            ),
                          ),
                          if (isMy && !(mProfile.status == Status.approved))
                            Positioned(
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  edit(WriteProfessionalDetailsPage.route);
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                        ],
                      ),
                    ),
              mProfile.needFamilyDetails
                  ? Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            WriteFamilyDetailsPage.route,
                          );
                        },
                        title: const Text("Enter Family Details"),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    )
                  : Card(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Family Details",
                                  style: style.titleMedium!
                                      .copyWith(color: scheme.primary),
                                ),
                                InfoTile(
                                  name: "अविवाहित बहिण",
                                  value: "${mProfile.unmarriedSisters}",
                                ),
                                InfoTile(
                                  name: "विवाहित बहिण",
                                  value: "${mProfile.marriedSisters}",
                                ),
                                InfoTile(
                                  name: "अविवाहित भाऊ",
                                  value: "${mProfile.unmarriedBrothers}",
                                ),
                                InfoTile(
                                  name: "विवाहित भाऊ",
                                  value: "${mProfile.marriedBrothers}",
                                ),
                                InfoTile(
                                  name: "वडिलांचे नाव",
                                  value: mProfile.fatherNameM,
                                ),
                                InfoTile(
                                  name: "वडिलांचा पत्ता",
                                  value: mProfile.fatherAddress,
                                ),
                                InfoTile(
                                  name: "वडिलांची नोकरी",
                                  value: mProfile.fatherDesignation,
                                ),
                                InfoTile(
                                  name: "Father(वडिलांचा) mobile no. 1",
                                  value: mProfile.fatherMobile1,
                                ),
                                if (mProfile.fatherMobile2 != null)
                                  InfoTile(
                                    name: "Father(वडिलांचा) mobile no. 2",
                                    value: mProfile.fatherMobile2!,
                                  ),
                                if (mProfile.contact1 != null)
                                  InfoTile(
                                    name: "Contact Name(संपर्काचे नाव) 1",
                                    value: mProfile.contactName1,
                                  ),
                                if (mProfile.contact1 != null)
                                  InfoTile(
                                    name: "Contact(संपर्क) no. 1",
                                    value: mProfile.contact1!,
                                  ),
                                if (mProfile.contact1city != null)
                                  InfoTile(
                                    name: "संपर्क १ व्यक्तीचे गाव",
                                    value: mProfile.contact1city!,
                                  ),
                                if (mProfile.contact2 != null)
                                  InfoTile(
                                    name: "Contact Name(संपर्काचे नाव) 2",
                                    value: mProfile.contactName2,
                                  ),
                                if (mProfile.contact2city != null)
                                  InfoTile(
                                    name: "संपर्क २ व्यक्तीचे गाव",
                                    value: mProfile.contact2city!,
                                  ),
                                if (mProfile.contact2 != null)
                                  InfoTile(
                                    name: "Contact(संपर्क) no. 2",
                                    value: mProfile.contact2!,
                                  ),
                              ],
                            ),
                          ),
                          if (isMy && !(mProfile.status == Status.approved))
                            Positioned(
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  edit(WriteFamilyDetailsPage.route);
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                        ],
                      ),
                    ),
              isAdmin
                  ? Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Form Details",
                              style: style.titleMedium!
                                  .copyWith(color: scheme.primary),
                            ),
                            InfoTile(
                              name: "Mobile Number Signed up with",
                              value: profile!.phone,
                            ),
                            InfoTile(
                              name: "Form filled by person",
                              value: mProfile.filledBy,
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
