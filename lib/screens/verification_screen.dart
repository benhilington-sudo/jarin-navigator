import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/settings_service.dart';
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

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  String? _error;
  late String _generatedCode;
  bool _codeSent = false;
  bool _sending = false;
  late AnimationController _shake;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _generatedCode = _generateCode();
    _shake = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _shake, curve: Curves.elasticOut),
    );
    _sendCode();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _shake.dispose();
    super.dispose();
  }

  String _generateCode() {
    final rng = Random();
    return List.generate(6, (_) => rng.nextInt(10)).join();
  }

  Future<void> _sendCode() async {
    setState(() => _sending = true);
    // Имитация отправки email (в реальном приложении — Firebase/SMTP)
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _sending = false;
        _codeSent = true;
      });
      // Показываем код в snackbar для тестирования
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Код отправлен на ${widget.email}\nДля теста: $_generatedCode',
            ),
            duration: const Duration(seconds: 8),
            backgroundColor: AppTheme.accent,
          ),
        );
      }
    }
  }

  String get _code => _controllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (_error != null) setState(() => _error = null);
    if (index == 5 && _code.length == 6) _submit();
  }

  void _submit() {
    if (_code != _generatedCode) {
      _shake.forward(from: 0);
      setState(() => _error = 'Неверный код. Попробуйте снова.');
      return;
    }
    context.read<SettingsService>().signIn(widget.email, name: widget.name);
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();
    final s = settings.strings;
    final isRu = settings.language == AppLanguage.ru;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sub = isDark ? AppTheme.darkSubtext : AppTheme.lightSubtext;

    return Scaffold(
      appBar: AppBar(title: Text(s.verificationTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Иконкаvelope
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
                s.verificationHint,
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
              const SizedBox(height: 8),
              if (_sending)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              const SizedBox(height: 24),
              AnimatedBuilder(
                animation: _shakeAnim,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      sin(_shakeAnim.value * 2 * pi * 3) * 8 * (1 - _shakeAnim.value),
                      0,
                    ),
                    child: child,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (i) {
                    return SizedBox(
                      width: 46,
                      height: 58,
                      child: TextField(
                        controller: _controllers[i],
                        focusNode: _focusNodes[i],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppTheme.accent,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (v) => _onChanged(i, v),
                      ),
                    );
                  }),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(
                  _error!,
                  style: TextStyle(
                    color: AppTheme.danger,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(s.verify),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _sending ? null : _sendCode,
                child: Text(
                  isRu ? 'Отправить код повторно' : 'Resend code',
                  style: TextStyle(color: sub),
                ),
              ),
              const Spacer(),
              // Подсказка для тестирования
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
                      isRu
                          ? 'Код: $_generatedCode'
                          : 'Code: $_generatedCode',
                        style: TextStyle(
                          color: sub,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
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
