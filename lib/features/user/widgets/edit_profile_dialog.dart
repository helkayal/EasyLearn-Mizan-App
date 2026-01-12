import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mizan_app/features/user/model/user_dm.dart';
import 'package:mizan_app/features/user/widgets/user_form.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class EditProfileDialog extends StatelessWidget {
  final UserDm user;

  const EditProfileDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRtl = context.locale.languageCode == 'ar';

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.personal_data_edit.tr(),
                      style: theme.textTheme.headlineMedium,
                      textAlign: isRtl ? TextAlign.right : TextAlign.left,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            /// 🔹 Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: UserForm(
                  initialUser: user,
                  onSaved: () {
                    Navigator.pop(context, true);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
