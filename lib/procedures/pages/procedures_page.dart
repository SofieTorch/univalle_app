import 'package:flutter/material.dart';
import 'package:univalle_app/l10n/l10n.dart';

class ProceduresPage extends StatelessWidget {
  const ProceduresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _ProceduresView();
  }
}

class _ProceduresView extends StatelessWidget {
  const _ProceduresView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pageTitleProcedures),
      ),
      body: Center(
        child: Text(l10n.pageTitleProcedures),
      ),
    );
  }
}
