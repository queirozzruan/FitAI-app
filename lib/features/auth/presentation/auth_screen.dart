import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:fitai/core/widgets/app_card.dart';
import 'package:fitai/core/widgets/app_primary_button.dart';
import 'package:fitai/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.onContinue});

  final VoidCallback? onContinue;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _mode = AuthMode.signIn;

  bool get _isSignIn => _mode == AuthMode.signIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: FitAiColors.royalBlue,
                ),
                child: const Icon(
                  Icons.fitness_center_rounded,
                  color: FitAiColors.white,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                _isSignIn ? 'Acesse seus treinos' : 'Crie sua conta visual',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Nesta versao MVP, seus dados serao usados apenas no fluxo local do app.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: FitAiColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SegmentedButton<AuthMode>(
                      segments: const [
                        ButtonSegment(
                          value: AuthMode.signIn,
                          label: Text('Entrar'),
                          icon: Icon(Icons.login_rounded),
                        ),
                        ButtonSegment(
                          value: AuthMode.signUp,
                          label: Text('Cadastro'),
                          icon: Icon(Icons.person_add_alt_1_rounded),
                        ),
                      ],
                      selected: {_mode},
                      showSelectedIcon: false,
                      onSelectionChanged: (selection) {
                        setState(() => _mode = selection.first);
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    if (!_isSignIn) ...[
                      const AppTextField(
                        label: 'Nome',
                        hint: 'Como devemos chamar voce?',
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    const AppTextField(
                      label: 'E-mail',
                      hint: 'voce@exemplo.com',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const AppTextField(
                      label: 'Senha',
                      hint: 'Minimo de 6 caracteres',
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppPrimaryButton(
                      label: _isSignIn ? 'Entrar' : 'Criar conta',
                      onPressed: widget.onContinue,
                      icon: const Icon(Icons.arrow_forward_rounded),
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

enum AuthMode { signIn, signUp }
