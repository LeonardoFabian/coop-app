import 'package:flutter/widgets.dart';
import 'package:coopmt_app/ui/views/login_view.dart';
import 'package:coopmt_app/ui/views/register_view.dart';
import 'package:coopmt_app/ui/views/forgot_password_view.dart';
import 'package:coopmt_app/ui/views/main_view.dart';
import 'package:coopmt_app/ui/views/notifications_view.dart';
import 'package:coopmt_app/ui/views/statics_view.dart';
import 'package:coopmt_app/ui/views/terms_and_conditions_view.dart';

var customRoutes = <String, WidgetBuilder>{
  LoginView.id: (_) => const LoginView(),
  RegisterView.id: (_) => const RegisterView(),
  ForgotPasswordView.id: (_) => const ForgotPasswordView(),
  MainView.id: (_) => const MainView(),
  NotificationsView.id: (_) => const NotificationsView(),
  StaticsView.id: (_) => const StaticsView(),
  TermsAndConditions.id: (_) => const TermsAndConditions(),
};
