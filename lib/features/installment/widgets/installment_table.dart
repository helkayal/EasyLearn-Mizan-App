import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mizan_app/core/utils/hive_constants.dart';
import 'package:mizan_app/features/installment/model/installment_dm.dart';
import 'package:mizan_app/features/installment/widgets/add_edit_installment_dialog.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class InstallmentsTable extends StatefulWidget {
  final List<InstallmentDm> items;
  final VoidCallback onRefresh;

  const InstallmentsTable({
    super.key,
    required this.items,
    required this.onRefresh,
  });

  @override
  State<InstallmentsTable> createState() => _InstallmentsTableState();
}

class _InstallmentsTableState extends State<InstallmentsTable> {
  String _filterType = 'unpaid'; // 'all', 'paid', 'unpaid'

  List<InstallmentDm> get _filteredItems {
    switch (_filterType) {
      case 'paid':
        return widget.items.where((item) => item.isPaid).toList();
      case 'unpaid':
        return widget.items.where((item) => !item.isPaid).toList();
      default:
        return widget.items;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          ),
          dataRowMinHeight: 56,
          dataRowMaxHeight: 72,
          columnSpacing: 24,

          columns: buildHeaders(context),

          rows: _filteredItems.map((item) {
            return buildDataRow(item, context);
          }).toList(),
        ),
      ),
    );
  }

  List<DataColumn> buildHeaders(BuildContext context) {
    return [
      DataColumn(
        label: Text(
          LocaleKeys.installment_monthly_amount.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      DataColumn(
        label: Text(
          LocaleKeys.installment_due_date.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      DataColumn(
        label: Text(
          LocaleKeys.installment_notes.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      DataColumn(
        label: Text(
          LocaleKeys.installment_paid.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      DataColumn(
        headingRowAlignment: MainAxisAlignment.center,
        label: builfPopupMenu(),
      ),
    ];
  }

  DataRow buildDataRow(InstallmentDm item, BuildContext context) {
    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>(
        (states) => item.isPaid
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)
            : null,
      ),
      cells: [
        DataCell(Text(item.amount.toString())),
        DataCell(Text(item.dueDate)),
        DataCell(
          Text(
            item.notes.isEmpty ? '—' : item.notes,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(
          Checkbox(
            value: item.isPaid,
            onChanged: (v) {
              final box = Hive.box(HiveConstants.installmentsBox);
              item.isPaid = v ?? false;
              box.put(item.id, item.toMap());
              widget.onRefresh();
            },
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: LocaleKeys.installment_edit.tr(),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (_) => AddEditInstallmentDialog(installment: item),
                  );
                  widget.onRefresh();
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: LocaleKeys.installment_delete.tr(),
                onPressed: () {
                  Hive.box(HiveConstants.installmentsBox).delete(item.id);
                  widget.onRefresh();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  PopupMenuButton<String> builfPopupMenu() {
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'all',
          child: Row(
            children: [
              Text('All'),
              if (_filterType == 'all')
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.check, size: 18),
                ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'paid',
          child: Row(
            children: [
              Text('Paid'),
              if (_filterType == 'paid')
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.check, size: 18),
                ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'unpaid',
          child: Row(
            children: [
              Text('Unpaid'),
              if (_filterType == 'unpaid')
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.check, size: 18),
                ),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        setState(() {
          _filterType = value;
        });
      },
      child: Icon(Icons.filter_list, size: 22),
    );
  }
}
