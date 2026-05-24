import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.onContinue, this.onForgotPassword});

  final VoidCallback? onContinue;
  final VoidCallback? onForgotPassword;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _mode = AuthMode.signIn;
  var _rememberMe = false;

  bool get _isSignIn => _mode == AuthMode.signIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FitAI',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: FitAiColors.royalBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 56),
              _AuthHeader(
                description: _isSignIn
                    ? 'Entre com suas informacoes para ter acesso ao seu treino personalizado!'
                    : 'Preencha seus dados para comecar a montar seu treino personalizado!',
                title: _isSignIn ? 'Bem vindo de volta!' : 'Crie sua conta',
              ),
              const SizedBox(height: AppSpacing.xxl),
              if (_isSignIn) ...[
                const _AuthTextField(
                  hint: 'voce@exemplo.com',
                  keyboardType: TextInputType.emailAddress,
                  label: 'E-mail',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.lg),
                const _AuthTextField(
                  hint: 'Digite sua senha',
                  label: 'Senha',
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        activeColor: FitAiColors.royalBlue,
                        side: const BorderSide(color: Color(0xFFC3C6D7)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() => _rememberMe = value ?? false);
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Lembrar de mim',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF434655),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF004AC6),
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: widget.onForgotPassword,
                      child: const Text('Esqueceu a senha?'),
                    ),
                  ],
                ),
              ] else ...[
                const _AuthTextField(
                  hint: 'Seu nome completo',
                  label: 'Nome',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.lg),
                const _AuthTextField(
                  hint: 'voce@exemplo.com',
                  keyboardType: TextInputType.emailAddress,
                  label: 'E-mail',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.lg),
                const _AuthTextField(
                  hint: 'Digite sua senha',
                  label: 'Senha',
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.lg),
                const _AuthTextField(
                  hint: 'Digite novamente',
                  label: 'Confirmar senha',
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              _AuthPrimaryButton(
                label: _isSignIn ? 'Entrar' : 'Criar conta',
                onPressed: widget.onContinue,
              ),
              const SizedBox(height: AppSpacing.xxl),
              const _ContinueDivider(),
              const SizedBox(height: AppSpacing.xxl),
              _SocialProviders(onPressed: widget.onContinue),
              const SizedBox(height: AppSpacing.xxl),
              Center(
                child: _AuthSwitchPrompt(
                  actionLabel: _isSignIn ? 'Cadastre-se' : 'Entrar',
                  leadingText: _isSignIn
                      ? 'Ainda nao tem conta?'
                      : 'Ja tem uma conta?',
                  onPressed: () {
                    setState(() {
                      _mode = _isSignIn
                          ? AuthMode.signUp
                          : AuthMode.signIn;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum AuthMode { signIn, signUp }

class _AuthHeader extends StatelessWidget {
  const _AuthHeader({required this.description, required this.title});

  final String description;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF434655),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.hint,
    required this.label,
    required this.textInputAction,
    this.keyboardType,
    this.obscureText = false,
  });

  final String hint;
  final TextInputType? keyboardType;
  final String label;
  final bool obscureText;
  final TextInputAction textInputAction;

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
        TextField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 12,
            ),
            enabledBorder: _inputBorder,
            focusedBorder: _inputBorder.copyWith(
              borderSide: const BorderSide(
                color: FitAiColors.royalBlue,
                width: 1.4,
              ),
            ),
            filled: true,
            fillColor: FitAiColors.white,
            hintText: hint,
            suffixIcon: obscureText
                ? const Icon(
                    Icons.visibility_off_outlined,
                    color: Color(0xFF6B7286),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class _ContinueDivider extends StatelessWidget {
  const _ContinueDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE1E2ED))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'OU CONTINUAR COM',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF737686),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE1E2ED))),
      ],
    );
  }
}

class _AuthPrimaryButton extends StatelessWidget {
  const _AuthPrimaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: FitAiColors.royalBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

class _SocialProviders extends StatelessWidget {
  const _SocialProviders({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ProviderButton(
            icon: Icons.g_mobiledata_rounded,
            label: 'Google',
            onPressed: onPressed,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _ProviderButton(
            icon: Icons.apple_rounded,
            label: 'Apple',
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class _ProviderButton extends StatelessWidget {
  const _ProviderButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: FitAiColors.white,
          foregroundColor: FitAiColors.textPrimary,
          side: const BorderSide(color: Color(0xFFC3C6D7)),
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

class _AuthSwitchPrompt extends StatelessWidget {
  const _AuthSwitchPrompt({
    required this.actionLabel,
    required this.leadingText,
    required this.onPressed,
  });

  final String actionLabel;
  final String leadingText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          leadingText,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF434655),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF004AC6),
            padding: const EdgeInsets.only(left: AppSpacing.xs),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: onPressed,
          child: Text(actionLabel),
        ),
      ],
    );
  }
}

final _inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(color: Color(0xFFC3C6D7)),
);
