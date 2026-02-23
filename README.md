# Test Multiplier App

Aplicativo Flutter com autenticação via Google, chat com IA (OpenAI) e persistência local de conversas utilizando arquitetura baseada em Clean Architecture + Bloc e Cubit.

---

<p align="center">
  <img src="https://github.com/user-attachments/assets/d300ed1f-7d42-48da-8fd7-f41e29dc71a7" width="402" height="874" />
  <img src="https://github.com/user-attachments/assets/77894fb7-f3b8-4ab3-8253-52d4f853c9e8" width="402" height="874" />
  <img src="https://github.com/user-attachments/assets/0cbb738e-1d66-4fad-bb55-cf3529f797c5" width="402" height="874" />
  <img src="https://github.com/user-attachments/assets/ca007c33-f78c-4884-a9e8-f7265b9834da" width="402" height="874" />
</p>

---


# 1. Como rodar o projeto do zero

## 1.1 Pré-requisitos

- Flutter instalado (recomendado: versão stable mais recente)
- Dart SDK (vem junto com Flutter)
- Android Studio ou VS Code
- Java 17 configurado
- Emulador Android ou dispositivo físico

Verifique sua instalação:

```bash
flutter doctor
```

---

## 1.2 Clonar o projeto

```bash
git clone <URL_DO_REPOSITORIO>
cd test_multiplier_app
```

---

## 1.3 Instalar dependências

```bash
flutter pub get
```

---

## 1.4 Configurar variáveis de ambiente (.env)

Crie um arquivo `.env` na raiz do projeto:

```
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxx
```

Certifique-se que o arquivo está declarado no `pubspec.yaml`:

```yaml
flutter:
  assets:
    - .env
```

---

## 1.5 Rodar o projeto

```bash
flutter clean
flutter pub get
flutter run
```

---

# 2. Como configurar login com Google (passo a passo)

## 2.1 Criar projeto no Google Cloud

1. Acesse:
   https://console.cloud.google.com
2. Crie um novo projeto
3. Ative a API:
   - Google Identity Services

---

## 2.2 Configurar OAuth 2.0

1. Vá em:
   APIs & Services → Credentials
2. Clique em "Create Credentials"
3. Escolha:
   OAuth Client ID

Crie dois tipos:

### Android

- Package name: mesmo package do app (ex: com.example.test_multiplier_app)
- SHA-1: obtido com:

```bash
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android
```

Salve o Client ID gerado.

---

### Web Application

Crie também um OAuth Client do tipo Web Application.

Copie o `Client ID`.  
Ele será usado como `serverClientId` no Android.

---

## 2.3 Configurar no Flutter

No login:

```dart
await GoogleSignIn.instance.initialize(
  serverClientId: "SEU_WEB_CLIENT_ID",
);
```

---

## 2.4 Android - google-services.json

1. No Firebase Console:
   https://console.firebase.google.com
2. Crie projeto
3. Adicione app Android
4. Baixe o arquivo `google-services.json`
5. Coloque em:

```
android/app/google-services.json
```

---

## 2.5 Aplicar plugin no Android

No `android/app/build.gradle.kts`:

```kotlin
plugins {
    id("com.google.gms.google-services")
}
```

No `android/build.gradle.kts`:

```kotlin
dependencies {
    classpath("com.google.gms:google-services:4.4.0")
}
```

---

# 3. Como configurar a chave da IA (OpenAI)

## 3.1 Criar conta

Acesse:
https://platform.openai.com

---

## 3.2 Criar API Key

1. Vá em:
   Dashboard → API Keys
2. Clique em:
   Create new secret key
3. Copie a chave gerada

---

## 3.3 Configurar no projeto

No arquivo `.env`:

```
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxx
```

No `main.dart`:

```dart
await dotenv.load(fileName: ".env");
```

No datasource:

```dart
final apiKey = dotenv.env['OPENAI_API_KEY'];
```

---

## 3.4 Rodar após alterar .env

Sempre executar:

```bash
flutter clean
flutter run
```

Hot reload não recarrega variáveis de ambiente.

---

# 4. Como testar o app (cenários principais)

## 4.1 Autenticação

- Login com Google (Pode utilizar qualquer conta google)
- Login com Email
    - massa de teste: usuario@teste.com
    - senha: 12345678
- Logout
- Persistência da sessão

Esperado:
- Usuário autenticado redireciona para Dashboard
- Logout redireciona para tela de autenticação

---

## 4.2 Dashboard

- Listar conversas salvas
- Atualizar lista ao voltar do Chat

Esperado:
- Conversas persistidas no SharedPreferences
- Lista atualiza após nova conversa

---

## 4.3 Chat

- Enviar mensagem
- Exibir indicador "Lara está digitando"
- Receber resposta da IA
- Persistir conversa

Esperado:
- Scroll automático
- Mensagem salva localmente
- Conversa atualizada corretamente

---

## 4.4 Persistência

- Fechar app
- Reabrir

Esperado:
- Conversas continuam salvas

---

# 5. Decisões técnicas

## 5.1 Arquitetura

Foi utilizada uma estrutura inspirada em Clean Architecture:

- Presentation
- Domain
- Data

Separação clara entre:

- Cubits (estado)
- Repositories (contratos)
- Datasources (implementações)
- Entities (modelo de domínio)

---

## 5.2 Gerenciamento de estado

Utiliza flutter_bloc.

Motivo:
- Simples
- Escalável
- Previsível
- Separação clara entre UI e lógica

---

## 5.3 Persistência

SharedPreferences foi escolhido para:

- Simplicidade
- Baixa complexidade
- Dados pequenos
- Conversas armazenadas como JSON

Hive não foi utilizado por estar sem atualizações recentes.

---

## 5.4 Chat IA

Integração direta com API OpenAI via HTTP (Dio).

Modelo utilizado:
gpt-4o-mini

Resposta é retornada completa (sem streaming).

---

## 5.5 CI/CD

Pipeline configurável via GitHub Actions com:

- flutter analyze
- flutter test
- build APK

---

# Estrutura simplificada

```
lib/
 ├── core/
 ├── features/
 │    ├── auth/
 │    ├── dashboard/
 │    └── chat/
 ├── main.dart
```

---

# Considerações finais

Este projeto foi estruturado para ser:

- Simples
- Escalável
- Organizado
- Fácil de testar
- Fácil de manter

Para produção real, recomenda-se:

- Assinatura de APK
- Proteção de API via backend
- Versionamento automático
- Testes de integração
