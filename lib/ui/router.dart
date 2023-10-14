import 'package:flutter/material.dart';
import 'package:leva_matrimonial/models/marriage_profile.dart';
import 'package:leva_matrimonial/ui/admin/admin_page.dart';
import 'package:leva_matrimonial/ui/ads/ads_page.dart';
import 'package:leva_matrimonial/ui/ads/write_ad_page.dart';
import 'package:leva_matrimonial/ui/components/update_dialog.dart';
import 'package:leva_matrimonial/ui/marriage_profile/details_page.dart';
import 'package:leva_matrimonial/ui/marriage_profile/write_family_details_page.dart';
import 'package:leva_matrimonial/ui/marriage_profile/write_personal_details_page.dart';
import 'package:leva_matrimonial/ui/marriage_profile/write_professional_details_page.dart';
import 'package:leva_matrimonial/ui/splash/splash_page.dart';
import 'package:leva_matrimonial/ui/static/about_page.dart';
import 'package:leva_matrimonial/ui/static/board_page.dart';
import 'package:leva_matrimonial/ui/static/contact_page.dart';
import 'package:leva_matrimonial/ui/static/gallary_page.dart';
import 'package:leva_matrimonial/ui/static/jalgav_page.dart';
import 'admin/admin_list.dart';
import 'marriage_profile/details_root.dart';
import 'root.dart';

class AppRouter {
  static Route<MaterialPageRoute> onNavigate(RouteSettings settings) {
    late final Widget selectedPage;

    switch (settings.name) {
      case DetailsPage.route:
        selectedPage = DetailsPage(
          mProfile: settings.arguments as MarriageProfile,
        );
        break;
      case DetailsRoot.route:
        selectedPage = const DetailsRoot();
        break;
      case WritePersonalDetailsPage.route:
        selectedPage = WritePersonalDetailsPage();
        break;
      case WriteProfessionalDetailsPage.route:
        selectedPage = WriteProfessionalDetailsPage();
        break;
      case WriteFamilyDetailsPage.route:
        selectedPage = WriteFamilyDetailsPage();
        break;
      case AdminList.route:
        selectedPage = const AdminList();
        break;
      case UpdatePage.route:
        selectedPage = const UpdatePage();
        break;
      case AdminPage.route:
        selectedPage = const AdminPage();
        break;
      case GallaryPage.route:
        selectedPage = const GallaryPage();
        break;
      case JalgavPage.route:
        selectedPage = const JalgavPage();
        break;
      case AboutPage.route:
        selectedPage = const AboutPage();
        break;
      case ContactPage.route:
        selectedPage = const ContactPage();
        break;
      case BoardPage.route:
        selectedPage = const BoardPage();
        break;
      case SplashPage.route:
        selectedPage = const SplashPage();
        break;
      case AdsPage.route:
        selectedPage = const AdsPage();
        break;
      case WriteAdPage.route:
        selectedPage = const WriteAdPage();
        break;
      default:
        selectedPage = const Root();
        break;
    }

    return MaterialPageRoute(builder: (context) => selectedPage);
  }
}
