import 'package:fitai/app/theme.dart';
import 'package:fitai/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class AnamnesisScreen extends StatefulWidget {
  const AnamnesisScreen({super.key, this.onContinue});

  final VoidCallback? onContinue;

  @override
  State<AnamnesisScreen> createState() => _AnamnesisScreenState();
}

class _AnamnesisScreenState extends State<AnamnesisScreen> {
  final _formKey = GlobalKey<FormState>();

  var _gender = _genders.first;
  var _goal = _goals.first;

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
      backgroundColor: _anamnesisBackground,
      body: SafeArea(
        child: Column(
          children: [
            const _AnamnesisHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 144),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seus aspectos fisicos',
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(fontSize: 32, height: 1.2),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Precisão exige dados exatos. Conte-nos de onde voce esta partindo hoje.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: _anamnesisTextMuted,
                          fontSize: 18,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 64),
                      _MetricCard(
                        icon: Icons.calendar_month_outlined,
                        keyboardType: TextInputType.number,
                        label: 'Idade',
                        textInputAction: TextInputAction.next,
                        unit: 'Anos',
                        validator: _requiredText,
                      ),
                      const SizedBox(height: 20),
                      _GenderCard(
                        selectedGender: _gender,
                        onChanged: (gender) {
                          setState(() => _gender = gender);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _MetricCard(
                              icon: Icons.monitor_weight_outlined,
                              keyboardType: TextInputType.number,
                              label: 'Peso',
                              textInputAction: TextInputAction.next,
                              unit: 'Kg',
                              validator: _requiredText,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: _MetricCard(
                              icon: Icons.straighten_rounded,
                              keyboardType: TextInputType.number,
                              label: 'Altura',
                              textInputAction: TextInputAction.next,
                              unit: 'cm',
                              validator: _requiredText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 64),
                      const _LimitationsCard(),
                      const SizedBox(height: 64),
                      Text(
                        'Marque seu objetivo',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 11),
                      Text(
                        'Selecione a sua meta para montarmos seu treino personalizado.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: _anamnesisTextMuted,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: 10,
                        runSpacing: 14,
                        children: _goals
                            .map(
                              (goal) => _GoalPill(
                                goal: goal,
                                isSelected: goal == _goal,
                                onPressed: () {
                                  setState(() => _goal = goal);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _AnamnesisFooter(onPressed: _continue),
    );
  }
}

class _AnamnesisHeader extends StatelessWidget {
  const _AnamnesisHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 64,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: const BoxDecoration(
        color: Color(0xCCF8FAFC),
        border: Border(bottom: BorderSide(color: Color(0x80E2E8F0))),
      ),
      child: Text(
        'FitAI',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: FitAiColors.royalBlue,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.keyboardType,
    required this.label,
    required this.textInputAction,
    required this.unit,
    required this.validator,
  });

  final IconData icon;
  final TextInputType keyboardType;
  final String label;
  final TextInputAction textInputAction;
  final String unit;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return _AnamnesisCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardLabel(icon: icon, label: label),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            decoration: _metricDecoration(unit),
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            validator: validator,
          ),
        ],
      ),
    );
  }
}

class _GenderCard extends StatelessWidget {
  const _GenderCard({required this.onChanged, required this.selectedGender});

  final ValueChanged<String> onChanged;
  final String selectedGender;

  @override
  Widget build(BuildContext context) {
    return _AnamnesisCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardLabel(
            icon: Icons.accessibility_new_rounded,
            label: 'Genero',
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            height: 44,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: _anamnesisStroke,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: _genders
                  .map(
                    (gender) => Expanded(
                      child: _GenderSegment(
                        gender: gender,
                        isSelected: gender == selectedGender,
                        onPressed: () => onChanged(gender),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderSegment extends StatelessWidget {
  const _GenderSegment({
    required this.gender,
    required this.isSelected,
    required this.onPressed,
  });

  final String gender;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? FitAiColors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          decoration: isSelected
              ? BoxDecoration(
                  border: Border.all(color: const Color(0x0D000000)),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2,
                      color: Color(0x0D000000),
                      offset: Offset(0, 1),
                    ),
                  ],
                )
              : null,
          child: Text(
            gender,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSelected ? FitAiColors.textPrimary : _anamnesisTextMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _LimitationsCard extends StatelessWidget {
  const _LimitationsCard();

  @override
  Widget build(BuildContext context) {
    return _AnamnesisCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardLabel(
            icon: Icons.health_and_safety_outlined,
            label: 'Limitacoes Fisicas',
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            decoration: _fieldDecoration.copyWith(
              hintText:
                  'Descreva aqui suas limitacoes, problemas de saude e etc.\n(ex. Dor no joelho, hernia de disco...)',
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            minLines: 3,
            textInputAction: TextInputAction.newline,
          ),
        ],
      ),
    );
  }
}

class _GoalPill extends StatelessWidget {
  const _GoalPill({
    required this.goal,
    required this.isSelected,
    required this.onPressed,
  });

  final String goal;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? const Color(0x1A2563EB) : FitAiColors.white,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? const Color(0x332563EB)
                  : const Color(0xFFC3C6D7),
            ),
            borderRadius: BorderRadius.circular(999),
            boxShadow: isSelected
                ? null
                : const [
                    BoxShadow(
                      blurRadius: 2,
                      color: Color(0x0D000000),
                      offset: Offset(0, 1),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Color(0xFF004AC6),
                  size: 15,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                goal,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? const Color(0xFF004AC6)
                      : const Color(0xFF434655),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnamnesisFooter extends StatelessWidget {
  const _AnamnesisFooter({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x00FAF8FF), Color(0xF2FAF8FF), _anamnesisBackground],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
          child: SizedBox(
            height: 60,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF004AC6),
                elevation: 0,
                shadowColor: const Color(0x66004AC6),
                shape: const StadiumBorder(
                  side: BorderSide(color: Color(0x33FFFFFF)),
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: onPressed,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Continuar'),
                  SizedBox(width: AppSpacing.xs),
                  Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnamnesisCard extends StatelessWidget {
  const _AnamnesisCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: FitAiColors.white,
        border: Border.all(color: _anamnesisStroke),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 40,
            color: Color(0x08000000),
            offset: Offset(0, 10),
            spreadRadius: -10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: child,
      ),
    );
  }
}

class _CardLabel extends StatelessWidget {
  const _CardLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF434655), size: 15),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF434655),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

InputDecoration _metricDecoration(String unit) {
  return _fieldDecoration.copyWith(
    suffixIcon: Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Text(
        unit,
        style: const TextStyle(
          color: _anamnesisTextMuted,
          fontSize: 16,
          height: 1.6,
        ),
      ),
    ),
    suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
  );
}

final _fieldDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  enabledBorder: _fieldBorder,
  errorBorder: _fieldBorder.copyWith(
    borderSide: const BorderSide(color: FitAiColors.error),
  ),
  filled: false,
  focusedBorder: _fieldBorder.copyWith(
    borderSide: const BorderSide(color: FitAiColors.royalBlue, width: 1.4),
  ),
  hintStyle: const TextStyle(color: Color(0xFFC3C6D7), height: 1.6),
);

final _fieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(4),
  borderSide: const BorderSide(color: _anamnesisStroke),
);

const _anamnesisBackground = Color(0xFFFAF8FF);
const _anamnesisStroke = Color(0xFFEDEDF9);
const _anamnesisTextMuted = Color(0xFF505F76);

const _genders = ['Homem', 'Mulher'];

const _goals = [
  'Ganhar massa magra',
  'Perder Gordura',
  'Resistencia',
  'Mobilidade',
];
