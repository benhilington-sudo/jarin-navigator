import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../theme/app_theme.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  final String name;

  const VerificationScreen({
    super.key,
    required this.email,
    required this.name,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _checking = false;
  bool _sending = false;

  Future<void> _resend() async {
    setState(() => _sending = true);
    await context.read<AuthService>().sendVerification();
    if (!mounted) return;
    setState(() => _sending = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Письмо отправлено повторно')),
      );
    }
  }

  Future<void> _checkVerified() async {
    setState(() => _checking = true);
    final auth = context.read<AuthService>();
    final verified = await auth.reloadAndCheckEmailVerified();
    if (!mounted) return;
    setState(() => _checking = false);

    if (verified) {
      Navigator.of(context).popUntil((r) => r.isFirst);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email ещё не подтверждён. Проверьте папку "Спам".'),
          backgroundColor: AppTheme.warning,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sub = isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext;

    return Scaffold(
      appBar: AppBar(title: const Text('Подтверждение email')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mark_email_read_rounded,
                    size: 36,
                    color: AppTheme.accent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Письмо с ссылкой для подтверждения отправлено на:',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                widget.email,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.accent,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                '1. Откройте письмо и нажмите ссылку\n2. Вернитесь сюда и нажмите "Проверить"',
                style: TextStyle(color: sub, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: _checking ? null : _checkVerified,
                child: _checking
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Проверить'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _sending ? null : _resend,
                child: Text(
                  _sending ? 'Отправка...' : 'Отправить письмо повторно',
                  style: TextStyle(color: sub),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppTheme.warning, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Не забудьте проверить папку "Спам"',
                        style: TextStyle(color: sub, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
