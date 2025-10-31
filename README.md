# Desafio 04 — Refatoração com DDD no Flutter

Este repositório contém a solução do exercício "Exercício de Refatoração com DDD no Flutter" aplicado ao projeto inicial onde toda a lógica estava concentrada em um único `StatefulWidget` (o "God Widget"). O objetivo foi reorganizar o código usando princípios de DDD (Domain-Driven Design) / Clean Architecture e separar responsabilidades entre Camada de Domínio, Infraestrutura (dados) e Apresentação.

Resumo do que foi feito
- Separei o código em camadas claras: domain, data e presentation dentro de `lib/features/todo/`.
- Implementei um Value Object (`TodoTitle`) que contém a validação de negócio (não vazio e máximo 50 caracteres).
- Transformei a classe de modelo em uma Entidade de Domínio (`Todo`) com operações imutáveis (copyWith).
- Criei uma interface de repositório (`ITodoRepository`) na camada de domínio.
- Adicionei casos de uso (use cases) que encapsulam ações do domínio:
  - `GetTodos`
  - `AddTodo`
  - `ToggleTodoStatus`
- Implementei uma fonte de dados local simulada (`TodoLocalDataSource`) e uma implementação do repositório (`TodoRepositoryImpl`) na camada de data.
- Criei um `ChangeNotifier` (`TodoNotifier`) na camada de apresentação que depende apenas dos casos de uso do domínio.
- Refatorei a tela para `TodoListScreen` (apenas UI) que observa o `TodoNotifier` (sem lógica de negócio).
- `main.dart` inicializa o app e injeta dependências (registro simples / injeção por construtor).

Estrutura principal (resumida)
lib/
├── features/
│   └── todo/
│       ├── domain/
│       │   ├── entities/
│       │   │   └── todo.dart
│       │   ├── value_objects/
│       │   │   └── todo_title.dart
│       │   ├── repositories/
│       │   │   └── i_todo_repository.dart
│       │   └── usecases/
│       │       ├── get_todos.dart
│       │       ├── add_todo.dart
│       │       └── toggle_todo_status.dart
│       ├── data/
│       │   ├── datasources/
│       │   │   └── todo_local_datasource.dart
│       │   └── repositories/
│       │       └── todo_repository_impl.dart
│       └── presentation/
│           ├── notifiers/
│           │   └── todo_notifier.dart
│           └── pages/
│               └── todo_list_screen.dart
└── main.dart

Observações sobre critérios do exercício
1. Isolamento do Domínio: A camada `domain` não importa nada de `data`, `presentation` ou `flutter`. Todas as regras do domínio ficam nela.
2. Encapsulamento: A validação do título (não vazio e <= 50 caracteres) está no `TodoTitle` (Value Object). A UI não faz essa validação diretamente.
3. Separação de Preocupações: A tela apenas renderiza e chama métodos do `TodoNotifier`. O Notifier orchestrates apenas os Use Cases.
4. Funcionalidade: O app mantém o comportamento original: adicionar tarefas e alternar status (marcar/desmarcar).

Como rodar
1. Tenha Flutter SDK instalado.
2. No diretório do projeto:
   - flutter pub get
   - flutter run

Dependências
- provider (ou outro gerenciador de injeção que for usado) — opcional conforme implementação.

Notas finais
- A solução foca em clareza arquitetural e separação de responsabilidades, utilizando um padrão simples de injeção por construtor para o Notifier e os Use Cases. É possível estender para persistência real (SQLite / SharedPreferences) ou trocar o gerenciamento de estado para BLoC/riverpod conforme preferências.

Autores
- Vitor-Bobato
- Paulo-Cesar-Cardoso-Domingues
