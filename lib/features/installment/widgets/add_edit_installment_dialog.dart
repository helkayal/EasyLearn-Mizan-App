import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mizan_app/core/theme/app_colors.dart';
import 'package:mizan_app/core/utils/hive_constants.dart';
import 'package:mizan_app/core/widgets/mizan_button.dart';
import 'package:mizan_app/core/widgets/mizan_text_field.dart';
import 'package:mizan_app/features/installment/model/installment_dm.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class AddEditInstallmentDialog extends StatefulWidget {
  final InstallmentDm? installment;

  const AddEditInstallmentDialog({super.key, this.installment});

  @override
  State<AddEditInstallmentDialog> createState() =>
      _AddEditInstallmentDialogState();
}

class _AddEditInstallmentDialogState extends State<AddEditInstallmentDialog> {
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.installment != null) {
      _amountController.text = widget.installment!.amount.toString();
      _dateController.text = widget.installment!.dueDate;
      _notesController.text = widget.installment!.notes;
    }
  }

  void _saveInstallment() {
    final box = Hive.box(HiveConstants.installmentsBox);

    final installment =
        widget.installment ?? InstallmentDm(amount: 0, dueDate: '', notes: '');

    installment.amount = double.tryParse(_amountController.text) ?? 0;
    installment.dueDate = _dateController.text;
    installment.notes = _notesController.text;

    box.put(installment.id, installment.toMap());
    Navigator.pop(context, true);
  }

  Future<void> _pickDate() async {
    DateTime initialDate = DateTime.now();

    // If editing and date field is not empty, parse the saved date
    if (widget.installment != null && _dateController.text.isNotEmpty) {
      try {
        initialDate = DateFormat('yyyy-MM-dd').parse(_dateController.text);
      } catch (e) {
        // If parsing fails, use current date
        initialDate = DateTime.now();
      }
    }

    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: initialDate,
      currentDate: widget.installment == null ? null : initialDate,
    );

    if (date != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(date);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.installment != null;
    final dialogTitle = isEditing
        ? LocaleKeys.installment_edit_monthly_installment.tr()
        : LocaleKeys.installment_add_monthly_installment.tr();
    final buttonText = isEditing
        ? LocaleKeys.installment_edit.tr()
        : LocaleKeys.installment_add.tr();

    return Dialog(
      backgroundColor: AppColors.lightYellowColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dialogTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),

            MizanTextField(
              label: LocaleKeys.installment_monthly_amount.tr(),
              controller: _amountController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            MizanTextField(
              label: LocaleKeys.installment_due_date.tr(),
              controller: _dateController,
              readOnly: true,
              onTap: _pickDate,
            ),
            const SizedBox(height: 16),

            MizanTextField(
              label: LocaleKeys.installment_notes.tr(),
              controller: _notesController,
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: MizanButton(
                    text: buttonText,
                    onPressed: _saveInstallment,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MizanButton(
                    text: LocaleKeys.installment_cancel.tr(),
                    backgroundColor: AppColors.lightGreenColor,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
