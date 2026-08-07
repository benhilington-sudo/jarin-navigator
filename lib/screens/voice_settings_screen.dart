import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/settings_service.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';

class VoiceSettingsScreen extends StatelessWidget {
  const VoiceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();
    final s = settings.strings;
    final tts = context.read<TtsService>();
    final sub = Theme.of(context).brightness == Brightness.dark
        ? AppTheme.darkSubtext
        : AppTheme.lightSubtext;

    return Scaffold(
      appBar: AppBar(title: Text(s.voiceConfigure)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SliderTile(
                    icon: Icons.graphic_eq_rounded,
                    label: s.pitch,
                    lowLabel: s.low,
                    highLabel: s.high,
                    value: settings.pitch,
                    min: 0.5,
                    max: 1.5,
                    onChanged: settings.setPitch,
                  ),
                  _SliderTile(
                    icon: Icons.speed_rounded,
                    label: s.speechRate,
                    lowLabel: '0.3',
                    highLabel: '1.0',
                    value: settings.rate,
                    min: 0.3,
                    max: 1.0,
                    onChanged: settings.setRate,
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.volume_off_rounded,
                        color: AppTheme.accent,
                        size: 22,
                      ),
                    ),
                    title: Text(
                      s.whisperMode,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      s.whisperDesc,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: Switch(
                      value: settings.whisper,
                      onChanged: settings.setWhisper,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: sub.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded,
                    color: AppTheme.accent, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Load · ${settings.ttsLocale == 'ru-RU' ? 'русский' : 'English'}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => tts.speak(s.testVoiceText),
            icon: const Icon(Icons.play_arrow_rounded),
            label: Text(s.testVoice),
          ),
        ],
      ),
    );
  }
}

class _SliderTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String lowLabel;
  final String highLabel;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const _SliderTile({
    required this.icon,
    required this.label,
    required this.lowLabel,
    required this.highLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.accent, size: 22),
          ),
          title: Text(label, style: Theme.of(context).textTheme.titleMedium),
          trailing: Text(
            value.toStringAsFixed(2),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppTheme.accent,
            ),
          ),
        ),
        Row(
          children: [
            Text(lowLabel, style: Theme.of(context).textTheme.bodyMedium),
            Expanded(
              child: Slider(
                value: value,
                min: min,
                max: max,
                onChanged: onChanged,
              ),
            ),
            Text(highLabel, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
