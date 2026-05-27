# FitAI

FitAI é um MVP mobile em Flutter para organizar treinos de musculação com base em dados físicos, objetivo e limitações do usuário.

Nesta versão, a criação do treino por IA é simulada com dados locais/mockados. O foco da entrega é demonstrar o fluxo principal do produto, interface navegável, regras básicas de negócio e persistência local.

## Fluxo principal

1. Splash screen.
2. Onboarding.
3. Login/cadastro visual.
4. Anamnese com validação de idade, peso, altura, gênero, objetivo e limitações.
5. Persistência local dos dados da anamnese em JSON.
6. Loading simulado de geração de treino por IA.
7. Home com cronograma de treinos mockados.
8. Tela de treino do dia.
9. Tela de evolução e perfil.
10. Recuperação de senha visual.

## Critérios do trabalho final

### 1. Interface Gráfica, Widgets e Usabilidade

- Telas construídas com widgets nativos do Flutter.
- Navegação funcional entre splash, onboarding, auth, anamnese, loading, home, treino, progresso/perfil e recuperação de senha.
- Uso de `SafeArea`, `SingleChildScrollView`, `LayoutBuilder`, `Expanded` e componentes responsivos para reduzir risco de overflow.
- Validações visuais na anamnese e feedback de erro via `SnackBar`.

### 2. Regras de Negócio, Integrações e Funcionalidade

- A anamnese valida dados obrigatórios e números positivos antes de avançar.
- Os dados da anamnese são persistidos localmente em arquivo JSON usando `dart:io`, sem backend.
- O loading de geração lê os dados salvos e exibe informações baseadas no perfil persistido.
- Em caso de falha ao salvar os dados, o app informa o erro e impede o avanço.

### 3. Desenvolvimento, Versionamento e Pitch

- O projeto usa Git com commits pequenos e mensagens no padrão Conventional Commits.
- O código está organizado por features, modelos, dados mockados e componentes reutilizáveis.
- Impacto social para o pitch: o FitAI ajuda pessoas que não têm acesso frequente a acompanhamento profissional a organizar treinos de forma mais simples, registrar sua evolução e considerar limitações físicas antes de iniciar uma rotina.

## Roteiro rapido de demonstracao

1. Abrir o app e passar pelo onboarding.
2. Entrar pelo login visual.
3. Preencher a anamnese com idade, peso e altura válidos.
4. Informar uma limitação física, como dor no joelho.
5. Avançar e mostrar o loading de IA lendo os dados salvos.
6. Exibir a home com o treino mockado.
7. Abrir um treino e depois navegar para evolução/perfil.

## Como rodar

```bash
flutter pub get
flutter run
```
