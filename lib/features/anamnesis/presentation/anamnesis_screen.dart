import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:fitai/core/widgets/app_card.dart';
import 'package:fitai/core/widgets/app_primary_button.dart';
import 'package:fitai/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class AnamnesisScreen extends StatefulWidget {
  const AnamnesisScreen({super.key, this.onContinue});

  final VoidCallback? onContinue;

  @override
  State<AnamnesisScreen> createState() => _AnamnesisScreenState();
}

class _AnamnesisScreenState extends State<AnamnesisScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _goal;
  String? _gender;

  void _continue() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onContinue?.call();
    }
  }

  String? _requiredText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatorio';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seu perfil de treino',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Conte o essencial para montar uma ficha mockada coerente com seu momento.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: FitAiColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Anamnese inicial',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppTextField(
                        label: 'Nome',
                        hint: 'Como devemos chamar voce?',
                        textInputAction: TextInputAction.next,
                        validator: _requiredText,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'Idade',
                              hint: '28',
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              validator: _requiredText,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: AppTextField(
                              label: 'Peso (kg)',
                              hint: '78',
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              validator: _requiredText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        label: 'Altura (m)',
                        hint: '1.76',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: _requiredText,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      DropdownButtonFormField<String>(
                        initialValue: _gender,
                        decoration: const InputDecoration(labelText: 'Genero'),
                        items: _genders
                            .map(
                              (gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ),
                            )
                            .toList(),
                        onChanged: (gender) {
                          setState(() => _gender = gender);
                        },
                        validator: (value) =>
                            value == null ? 'Selecione um genero' : null,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      DropdownButtonFormField<String>(
                        initialValue: _goal,
                        decoration: const InputDecoration(labelText: 'Objetivo'),
                        items: _goals
                            .map(
                              (goal) => DropdownMenuItem(
                                value: goal,
                                child: Text(goal),
                              ),
                            )
                            .toList(),
                        onChanged: (goal) {
                          setState(() => _goal = goal);
                        },
                        validator: (value) =>
                            value == null ? 'Selecione um objetivo' : null,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      FormField<Set<String>>(
                        initialValue: const {},
                        validator: (days) {
                          if (days == null || days.isEmpty) {
                            return 'Escolha ao menos um dia';
                          }

                          return null;
                        },
                        builder: (field) {
                          final selectedDays = field.value ?? <String>{};

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dias disponiveis',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Wrap(
                                spacing: AppSpacing.sm,
                                runSpacing: AppSpacing.sm,
                                children: _days
                                    .map(
                                      (day) => FilterChip(
                                        label: Text(day),
                                        selected: selectedDays.contains(day),
                                        onSelected: (isSelected) {
                                          final nextDays = {...selectedDays};

                                          if (isSelected) {
                                            nextDays.add(day);
                                          } else {
                                            nextDays.remove(day);
                                          }

                                          field.didChange(nextDays);
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                              if (field.hasError) ...[
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  field.errorText!,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                      ),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppTextField(
                        label: 'Lesoes ou restricoes',
                        hint: 'Descreva limites que devemos considerar.',
                        maxLines: 3,
                        textInputAction: TextInputAction.newline,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppPrimaryButton(
                        label: 'Continuar',
                        onPressed: _continue,
                        icon: const Icon(Icons.arrow_forward_rounded),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _days = [
  'Seg',
  'Ter',
  'Qua',
  'Qui',
  'Sex',
  'Sab',
  'Dom',
];

const _genders = [
  'Feminino',
  'Masculino',
  'Nao informar',
];

const _goals = [
  'Hipertrofia',
  'Forca',
  'Condicionamento',
  'Recomposicao corporal',
];
