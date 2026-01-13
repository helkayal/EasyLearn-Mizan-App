import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mizan_app/core/utils/hive_constants.dart';
import 'package:mizan_app/core/widgets/welcome_view.dart';
import 'package:mizan_app/features/installment/model/installment_dm.dart';
import 'package:mizan_app/features/installment/widgets/add_edit_installment_dialog.dart';
import 'package:mizan_app/features/installment/widgets/installment_table.dart';
import 'package:mizan_app/features/installment/widgets/no_installment.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class InstallmentScreen extends StatefulWidget {
  const InstallmentScreen({super.key});

  @override
  State<InstallmentScreen> createState() => _InstallmentScreenState();
}

class _InstallmentScreenState extends State<InstallmentScreen> {
  List<InstallmentDm> installments = [];

  @override
  void initState() {
    super.initState();
    _loadInstallments();
  }

  void _loadInstallments() {
    final box = Hive.box(HiveConstants.installmentsBox);
    installments = box.values
        .map((e) => InstallmentDm.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    // Sort by due date
    installments.sort((a, b) => a.dueDate.compareTo(b.dueDate));

    setState(() {});
  }

  Future<void> _openAddInstallmentDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AddEditInstallmentDialog(),
    );

    if (result == true) {
      _loadInstallments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.app_name.tr())),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddInstallmentDialog,
        child: const Icon(Icons.add, size: 36),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            WelcomeView(
              greetingMessage: LocaleKeys.installment_room_description.tr(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: installments.isEmpty
                  ? NoInstallment()
                  : InstallmentsTable(
                      items: installments,
                      onRefresh: _loadInstallments,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
