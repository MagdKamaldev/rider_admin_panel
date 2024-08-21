import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/Settings/logic/settings_cubit.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 35.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).selectLanguage,
              style: TextStyles.headings.copyWith(
                color: AppColors.prussianBlue,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            _buildLanguageOption(
              context,
              language: S.of(context).english,
              localeCode: 'en',
            ),
            const Divider(thickness: 1.5),
            _buildLanguageOption(
              context,
              language: S.of(context).arabic,
              localeCode: 'ar',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context,
      {required String language, required String localeCode}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      selectedColor: AppColors.prussianBlue,
      iconColor: AppColors.prussianBlue,
      title: Text(
        language,
        style: TextStyles.headings.copyWith(
          color: AppColors.prussianBlue,
          fontSize: 18,
        ),
      ),
      leading: const Icon(Icons.language),
      onTap: () {
        SettingsCubit.get(context).changeLanguage(Locale(localeCode));
      },
      trailing: BlocBuilder<SettingsCubit, Locale>(
        builder: (context, locale) {
          if (locale.languageCode == localeCode) {
            return const Icon(Icons.check_circle,
                color: AppColors.prussianBlue);
          } else {
            return const Icon(Icons.radio_button_unchecked,
                color: AppColors.prussianBlue);
          }
        },
      ),
    );
  }
}
