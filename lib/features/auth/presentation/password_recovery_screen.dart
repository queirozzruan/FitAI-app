import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => _submitted = true);
  }

  void _handleBack() {
    if (widget.onBack != null) {
      widget.onBack!();
      return;
    }

    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final email = _emailController.text.trim();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RecoveryTopBar(onBack: _handleBack),
                      const SizedBox(height: 56),
                      _RecoveryHeader(submitted: _submitted),
                      const SizedBox(height: AppSpacing.xxl),
                      _RecoveryBadge(submitted: _submitted),
                      const SizedBox(height: AppSpacing.xxl),
                      if (_submitted)
                        _RecoverySuccessCard(email: email)
                      else
                        Form(
                          key: _formKey,
                          child: _RecoveryTextField(
                            controller: _emailController,
                            hint: 'voce@exemplo.com',
                            keyboardType: TextInputType.emailAddress,
                            label: 'E-mail',
                            textInputAction: TextInputAction.done,
                            validator: _validateEmail,
                          ),
                        ),
                      const SizedBox(height: AppSpacing.xxl),
                      _RecoveryPrimaryButton(
                        icon: _submitted
                            ? Icons.arrow_back_rounded
                            : Icons.mail_outline_rounded,
                        label: _submitted
                            ? 'Voltar para login'
                            : 'Enviar link de recuperacao',
                        onPressed: _submitted ? _handleBack : _handleSubmit,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Informe seu e-mail.';
    }

    if (!email.contains('@') || !email.contains('.')) {
      return 'Informe um e-mail valido.';
    }

    return null;
  }
}

class _RecoveryTopBar extends StatelessWidget {
  const _RecoveryTopBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
            color: FitAiColors.textPrimary,
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: onBack,
            padding: EdgeInsets.zero,
            style: IconButton.styleFrom(
              backgroundColor: FitAiColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
                side: const BorderSide(color: Color(0xFFE1E2ED)),
              ),
            ),
          ),
        ),
        const Spacer(),
        Text(
          'FitAI',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: FitAiColors.royalBlue,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _RecoveryHeader extends StatelessWidget {
  const _RecoveryHeader({required this.submitted});

  final bool submitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          submitted ? 'Verifique seu e-mail' : 'Recuperar senha',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          submitted
              ? 'Enviamos as instrucoes para voce redefinir sua senha e voltar ao treino.'
              : 'Informe o e-mail cadastrado para receber as instrucoes de redefinicao de senha.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF434655),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _RecoveryBadge extends StatelessWidget {
  const _RecoveryBadge({required this.submitted});

  final bool submitted;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 176,
        height: 176,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 176,
              height: 176,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0x80C3C6D7)),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Container(
              width: 136,
              height: 136,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFDBE1FF)),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 36,
                    color: FitAiColors.royalBlue.withValues(alpha: 0.28),
                    offset: const Offset(0, 12),
                  ),
                ],
                color: const Color(0xFF004AC6),
              ),
              child: Icon(
                submitted
                    ? Icons.mark_email_read_outlined
                    : Icons.lock_reset_rounded,
                color: FitAiColors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecoveryTextField extends StatelessWidget {
  const _RecoveryTextField({
    required this.controller,
    required this.hint,
    required this.label,
    required this.textInputAction,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final String label;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.md),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF434655),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 12,
            ),
            enabledBorder: _recoveryInputBorder,
            errorBorder: _recoveryInputBorder.copyWith(
              borderSide: const BorderSide(color: FitAiColors.error),
            ),
            focusedBorder: _recoveryInputBorder.copyWith(
              borderSide: const BorderSide(
                color: FitAiColors.royalBlue,
                width: 1.4,
              ),
            ),
            focusedErrorBorder: _recoveryInputBorder.copyWith(
              borderSide: const BorderSide(
                color: FitAiColors.error,
                width: 1.4,
              ),
            ),
            filled: true,
            fillColor: FitAiColors.white,
            hintText: hint,
          ),
        ),
      ],
    );
  }
}

class _RecoverySuccessCard extends StatelessWidget {
  const _RecoverySuccessCard({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE1E2ED)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 40,
            color: Color(0x0D000000),
            offset: Offset(0, 20),
            spreadRadius: -10,
          ),
        ],
        color: FitAiColors.white.withValues(alpha: 0.86),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: const Color(0xFFDFF7EA),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: FitAiColors.success,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Link enviado',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Confira a caixa de entrada de $email para continuar.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF505F76),
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecoveryPrimaryButton extends StatelessWidget {
  const _RecoveryPrimaryButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF004AC6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        icon: Icon(icon, size: 20),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }
}

final _recoveryInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(color: Color(0xFFC3C6D7)),
);
