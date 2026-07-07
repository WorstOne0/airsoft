// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
// Router
import '/router/app_routes.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Host a game — a single structured form: title, game type, date/time,
/// location, roster cap, fee, brief and safety rules. "Publicar" pushes the
/// game-live confirmation.
class HostGamePage extends ConsumerStatefulWidget {
  const HostGamePage({super.key});

  @override
  ConsumerState<HostGamePage> createState() => _HostGamePageState();
}

class _HostGamePageState extends ConsumerState<HostGamePage> {
  static const gameTypes = ['Milsim', 'CQB', 'Speedsoft', 'Skirmish'];

  final titleController = TextEditingController(text: 'Woodland Milsim OP');
  final briefController = TextEditingController(
    text: 'Push de dois times por 40 hectares. Respawn na base a cada 15 min, cronografagem na entrada...',
  );

  int selectedType = 0;
  int maxPlayers = 40;

  DateTime date = DateTime(2026, 7, 12);
  TimeOfDay time = const TimeOfDay(hour: 9, minute: 0);

  bool chronoRequired = true;
  bool sealedEyewear = true;
  bool lateEntry = false;

  @override
  void dispose() {
    titleController.dispose();
    briefController.dispose();

    super.dispose();
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) setState(() => date = picked);
  }

  Future<void> pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: time);

    if (picked != null) setState(() => time = picked);
  }

  String get timeLabel => '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget buildBox(IconData icon, String value, {Color? iconColor, VoidCallback? onTap}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
          child: Row(
            children: [
              Icon(icon, size: 18, color: iconColor ?? context.colorScheme.onSurfaceVariant),
              const SizedBox(width: 10),
              Text(value, style: context.textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColumn(String label, Widget child) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildLabel(label), child],
      ),
    );
  }

  Widget buildGameTypes() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < gameTypes.length; i++)
          ChoiceChip(
            label: Text(gameTypes[i]),
            selected: selectedType == i,
            onSelected: (_) => setState(() => selectedType = i),
          ),
      ],
    );
  }

  Widget buildStepperButton(IconData icon, bool filled, VoidCallback onTap) {
    return InkResponse(
      onTap: onTap,
      radius: 26,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: filled ? context.colorScheme.secondaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        child: Icon(
          icon,
          size: 20,
          color: filled ? context.colorScheme.onSecondaryContainer : context.colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget buildMaxPlayers() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Máx. jogadores', style: context.textTheme.titleSmall),
                Text(
                  'Limite da escalação',
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),

          buildStepperButton(Icons.remove, false, () {
            if (maxPlayers > 1) setState(() => maxPlayers--);
          }),

          SizedBox(
            width: 44,
            child: Text(
              '$maxPlayers',
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),

          buildStepperButton(Icons.add, true, () => setState(() => maxPlayers++)),
        ],
      ),
    );
  }

  Widget buildRuleRow(IconData icon, String label, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: context.colorScheme.onSurfaceVariant),

          const SizedBox(width: 12),

          Expanded(child: Text(label, style: context.textTheme.titleSmall)),

          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
        title: const Text('Organizar jogo'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton(
              onPressed: () => context.push(AppRoutes.hostPublished),
              style: FilledButton.styleFrom(
                backgroundColor: context.colorScheme.tertiary,
                foregroundColor: context.colorScheme.onTertiary,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                minimumSize: const Size(0, 38),
              ),
              child: const Text('Publicar'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          buildLabel('Título'),
          TextField(controller: titleController),

          const SizedBox(height: 20),

          buildLabel('Tipo de jogo'),
          buildGameTypes(),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildColumn('Data', buildBox(Icons.calendar_today_outlined, DateFormat('d MMM').format(date), onTap: pickDate)),
              const SizedBox(width: 12),
              buildColumn('Início', buildBox(Icons.schedule, timeLabel, onTap: pickTime)),
            ],
          ),

          const SizedBox(height: 20),

          buildLabel('Local'),
          buildBox(Icons.place_outlined, 'Bravo Field, Kent', onTap: () {}),

          const SizedBox(height: 20),

          buildMaxPlayers(),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildColumn('Taxa', buildBox(Icons.attach_money, 'R\$ 25', iconColor: context.colorScheme.tertiary, onTap: () {})),
              const SizedBox(width: 12),
              buildColumn('Limite BB', buildBox(Icons.bolt, '1.14J', iconColor: context.colorScheme.tertiary, onTap: () {})),
            ],
          ),

          const SizedBox(height: 20),

          buildLabel('Briefing'),
          TextField(controller: briefController, maxLines: 4, minLines: 3),

          const SizedBox(height: 24),

          buildLabel('Regras e segurança'),

          buildRuleRow(
            Icons.shield_outlined,
            'Cronógrafo obrigatório',
            chronoRequired,
            (v) => setState(() => chronoRequired = v),
          ),
          buildRuleRow(
            Icons.remove_red_eye_outlined,
            'Proteção ocular vedada',
            sealedEyewear,
            (v) => setState(() => sealedEyewear = v),
          ),
          buildRuleRow(
            Icons.schedule,
            'Entrada tardia permitida',
            lateEntry,
            (v) => setState(() => lateEntry = v),
          ),
        ],
      ),
    );
  }
}
