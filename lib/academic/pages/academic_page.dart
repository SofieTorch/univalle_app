import 'package:flutter/material.dart';
import 'package:univalle_app/l10n/l10n.dart';
import 'package:univalle_app/schedule/schedule.dart';
import 'package:univalle_app/subjects/subjects.dart';

class AcademicPage extends StatelessWidget {
  const AcademicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            tabs: <Tab>[
              Tab(text: l10n.academicTabLabelNotes),
              Tab(text: l10n.academicTabLabelSchedule),
              Tab(text: l10n.academicTabLabelSubjects),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Center(
                  child: Text(
                    'This is the ${l10n.academicTabLabelNotes} tab',
                  ),
                ),
                const SchedulePage(),
                const SubjectsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
