import 'package:flutter/material.dart';

import '../../models/marriage_profile.dart';
import '../home/widgets/profile_card.dart';

class PaginationView extends StatelessWidget {
  const PaginationView(
      {Key? key,
      required this.items,
      required this.busy,
      required this.onLoadMore,
      required this.onRefresh,
      required this.scroll,
      required this.loading})
      : super(key: key);

  final List<MarriageProfile> items;
  final bool busy;
  final Function() onLoadMore;
  final Function() onRefresh;
  final bool loading;
  final ScrollController scroll;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;

    return Expanded(
        child: items.isEmpty && busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : items.isEmpty
                ? Center(
                    child: Text(
                      "No profiles available",
                      style: style.titleMedium,
                    ),
                  )
                : SingleChildScrollView(
                    controller: scroll,
                    child: Column(children: [
                      ...items
                          .map((e) =>
                              ProfileCard(profile: e, isApprovalButtons: false))
                          .toList(),
                      loading && items.length >= 8
                          ? const Center(
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator()),
                            )
                          : const SizedBox()
                    ]),
                  )
        // NotificationListener<ScrollNotification>(
        //     onNotification: (notification) {
        //       // if (!busy &&
        //       //     notification.metrics.pixels ==
        //       //         notification.metrics.maxScrollExtent
        //       //         &&
        //       //     notification.metrics.maxScrollExtent > 0) {
        //       //   onLoadMore();
        //       // }
        //       return true;
        //     },
        //     child: RefreshIndicator(
        //       onRefresh: () async {
        //         onRefresh();
        //       },
        //       child: CustomScrollView(
        //         slivers: [
        //           SliverPadding(
        //             padding: const EdgeInsets.all(8),
        //             sliver: SliverList(
        //               delegate: SliverChildListDelegate(
        //                 items
        //                     .map(
        //                       (e) => ProfileCard(
        //                         profile: e,
        //                         isApprovalButtons: false,
        //                       ),
        //                     )
        //                     .toList(),
        //               ),
        //             ),
        //           ),
        //           SliverToBoxAdapter(
        //             child: loading && items.length >= 8
        //                 ? Center(
        //                     child: Padding(
        //                       padding: const EdgeInsets.all(8.0),
        //                       child: TextButton(
        //                           onPressed: onLoadMore,
        //                           child: const Text('Load More')),
        //                     ),
        //                   )
        //                 : const SizedBox(),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        );
  }
}
