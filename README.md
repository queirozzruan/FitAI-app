# FitAI

FitAI e um MVP mobile em Flutter para organizar treinos de musculacao com base em dados fisicos, objetivo e limitacoes do usuario.

Nesta versao, a criacao do treino por IA e simulada com dados locais/mockados. O foco da entrega e demonstrar o fluxo principal do produto, interface navegavel, regras basicas de negocio e persistencia local.

## Fluxo principal

1. Splash screen.
2. Onboarding.
3. Login/cadastro visual.
4. Anamnese com validacao de idade, peso, altura, genero, objetivo e limitacoes.
5. Persistencia local dos dados da anamnese em JSON.
6. Loading simulado de geracao de treino por IA.
7. Home com cronograma de treinos mockados.
8. Tela de treino do dia.
9. Tela de evolucao e perfil.
10. Recuperacao de senha visual.

## Criterios do trabalho final

### 1. Interface Grafica, Widgets e Usabilidade

- Telas construidas com widgets nativos do Flutter.
- Navegacao funcional entre splash, onboarding, auth, anamnese, loading, home, treino, progresso/perfil e recuperacao de senha.
- Uso de `SafeArea`, `SingleChildScrollView`, `LayoutBuilder`, `Expanded` e componentes responsivos para reduzir risco de overflow.
- Validacoes visuais na anamnese e feedback de erro via `SnackBar`.

### 2. Regras de Negocio, Integracoes e Funcionalidade

- A anamnese valida dados obrigatorios e numeros positivos antes de avancar.
- Os dados da anamnese sao persistidos localmente em arquivo JSON usando `dart:io`, sem backend.
- O loading de geracao le os dados salvos e exibe informacoes baseadas no perfil persistido.
- Em caso de falha ao salvar os dados, o app informa o erro e impede o avanco.

### 3. Desenvolvimento, Versionamento e Pitch

- O projeto usa Git com commits pequenos e mensagens no padrao Conventional Commits.
- O codigo esta organizado por features, modelos, dados mockados e componentes reutilizaveis.
- Impacto social para o pitch: o FitAI ajuda pessoas que nao tem acesso frequente a acompanhamento profissional a organizar treinos de forma mais simples, registrar sua evolucao e considerar limitacoes fisicas antes de iniciar uma rotina.

## Roteiro rapido de demonstracao

1. Abrir o app e passar pelo onboarding.
2. Entrar pelo login visual.
3. Preencher a anamnese com idade, peso e altura validos.
4. Informar uma limitacao fisica, como dor no joelho.
5. Avancar e mostrar o loading de IA lendo os dados salvos.
6. Exibir a home com o treino mockado.
7. Abrir um treino e depois navegar para evolucao/perfil.

## Como rodar

```bash
flutter pub get
flutter run
```
