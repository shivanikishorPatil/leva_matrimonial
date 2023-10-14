import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/enums/gender.dart';
import 'package:leva_matrimonial/models/marriage_profile.dart';
import 'package:leva_matrimonial/ui/admin/widgets/approval_buttons.dart';
import 'package:leva_matrimonial/ui/components/my_image_icon.dart';
import 'package:leva_matrimonial/ui/marriage_profile/details_page.dart';
import 'package:leva_matrimonial/utils/assets.dart';
import 'package:leva_matrimonial/utils/labels.dart';

import '../../../enums/marital_status.dart';
import '../../../enums/status.dart';
import '../../../utils/data.dart';
import '../../admin/widgets/confirm_dialog.dart';
import '../providers/profile_card_provider.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard(
      {Key? key, required this.profile, required this.isApprovalButtons})
      : super(key: key);
  final MarriageProfile profile;
  final bool isApprovalButtons;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final scheme = theme.colorScheme;
    final model = ref.watch(profileCardNotifier);

    return GestureDetector(
      onTap: () {
        print(profile.toString());
        Navigator.pushNamed(context, DetailsPage.route, arguments: profile);
      },
      child: Card(
        color: scheme.surface,
        surfaceTintColor: scheme.surface,
        child: AspectRatio(
          aspectRatio: 2.7,
          child: Row(
            children: [
              profile.thumbnail != null
                  ? AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        profile.thumbnail!,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        errorBuilder: (context, exception, stackTrace) {
                          return Image.asset(Assets.defaultImage);
                        },
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: 0.8,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: profile.gender == Gender.male
                            ? Colors.blue
                            : Colors.pink,
                      ),
                    ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: style.titleMedium,
                        maxLines: 1,
                      ),
                      Row(
                        children: [
                          const MyIconImage(path: Assets.education),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              profile.eduCategory,
                              style: style.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const MyIconImage(
                            path: Assets.age,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            profile.ageLabel,
                            style: style.bodyLarge,
                          ),
                          const Spacer(),
                          const MyIconImage(
                            path: Assets.height,
                            size: 20,
                          ),
                          Text(
                            profile.height,
                            style: style.bodyLarge,
                          ),
                          const Spacer(),
                          if (profile.salary != null)
                            const MyIconImage(
                              path: Assets.salary,
                              size: 20,
                            ),
                          if (profile.salary != null) const SizedBox(width: 4),
                          if (profile.salary != null)
                            Text(
                              "${Labels.rupee}${profile.salary}",
                              style: style.bodyLarge,
                              maxLines: 1,
                            ),
                        ],
                      ),
                      if (profile.maritalStatus == MaritalStatus.divorced)
                        Text(
                          Data.maritalStatusLabels[MaritalStatus.divorced] ??
                              '',
                          style: const TextStyle(fontSize: 12),
                        ),
                      // profile.status != Status.approved
                      //     ? const Divider()
                      //     : const SizedBox(),
                      // profile.status == Status.pending
                      //     ? ApporvalButtons(onAccepted: () {
                      //         model.status = Status.approved;
                      //         model.changeStatus(profile);
                      //       }, onRejected: () {
                      //         model.status = Status.rejected;
                      //         model.changeStatus(profile);
                      //       })
                      // : const SizedBox(),
                      // profile.status == Status.rejected
                      //     ? Center(
                      //         child: TextButton(
                      //           // style: ButtonStyle(
                      //           //   backgroundColor: MaterialStateProperty.all(Colors.green),
                      //           //   shape: MaterialStateProperty.all(
                      //           //     const RoundedRectangleBorder(
                      //           //       borderRadius: BorderRadius.only(
                      //           //         bottomLeft: Radius.circular(10),
                      //           //       ),
                      //           //     ),
                      //           //   ),
                      //           // ),
                      //           onPressed: () async {
                      //             final val = await showDialog(
                      //               context: context,
                      //               builder: (_) => ConfirmDialog(
                      //                   title:
                      //                       "Are you sure you want to Accept",
                      //                   yesColor: Colors.green,
                      //                   yes: () {
                      //                     Navigator.pop(context, true);
                      //                   },
                      //                   no: () {
                      //                     Navigator.pop(context);
                      //                   }),
                      //             );
                      //             if (val != null) {
                      //               model.status = Status.approved;
                      //               model.changeStatus(profile);
                      //             }
                      //           },
                      //           child: Text(
                      //             "Accept",
                      //             style: style.button!
                      //                 .copyWith(color: Colors.green),
                      //           ),
                      //         ),
                      //       )
                      //     : const SizedBox()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
