# loomi‑project

**Descrição**  
Este projeto Flutter (“loomi‑project”) é uma aplicação mobile destinada ao teste técnico da Loomi. Ele integra uma arquitetura limpa com injeção de dependências via GetIt, comunicação HTTP via Dio, e segue boas práticas para modularização e testes.

---

## Índice  
- [Pré‑requisitos](#pré‑requisitos)  
- [Setup / Instalação](#setup--instalação)  
- [Arquitetura & decisões técnicas](#arquitetura--decisões‑técnicas)  
- [Principais dependências](#principais‑dependências)  
- [Estrutura de pastas](#estrutura‑de‑pastas)  
- [Como executar](#como‑executar)  
- [Como rodar testes](#como‑rodar‑testes)  
- [Melhorias futuras](#melhorias‑futuras)

---

### Pré‑requisitos  
- Flutter SDK (versão compatível com o projeto)  
- Dart SDK correspondente  
- Fvm para versionamente do Flutter (opcional)
- Android Studio
- JavaSDK OpenJDK
- XCode (caso desenvolver em iOS)
- Um emulador ou dispositivo físico com iOS ou Android configurado  
- (Opcional) Acesso à API backend definida (ex: base URL: `https://flutter-challenge.wiremockapi.cloud`)

---

### Setup / Instalação  
1. Clone o repositório:  
   ```bash
   git clone https://github.com/ViniciusInacio0108/loomi-project.git
   cd loomi-project
   ```  
2. Instale dependências:  
   ```bash
   fvm flutter pub get
   ```  
3. Configure ambiente (se aplicável):  
   - Verifique se há arquivo `.env` ou similar para ajustar a `BASE_URL`.  
   - Exemplo: `BASE_URL_LOOMI = 'https://flutter-challenge.wiremockapi.cloud'`  

---

### Arquitetura & decisões técnicas  
- Utiliza injeção de dependência via GetIt para registrar clientes HTTP, serviços, repositórios, casos de uso (use‑cases) e ViewModels.  
- O cliente HTTP é construído com Dio, configurado com base URL definida e interceptors potenciais para tratamentos de erro/resposta.  
- Camadas:  
  - **Cliente HTTP** (ex: `DioClient`) — abstração da comunicação com backend.  
  - **Serviços** (ex: `AuthService`) — encapsula chamadas HTTP específicas.  
  - **Repositórios** (ex: `AuthRepositoryImpl`) — implementa lógica de domínio, utiliza Serviços.  
  - **UseCases** (ex: `AuthUsecase`) — orquestra lógica para o domínio externo da UI.  
  - **ViewModels** (ex: `LoginAndSignupViewModel`) — expõe estado para a UI, interage com os UseCases.  
- Uso do padrão ChangeNotifier ou similar para a ViewModel, acoplado à UI via Provider.  
- Boas práticas como separação de responsabilidade, legibilidade e testabilidade.

---

### Principais dependências  
- `flutter` — framework principal.  
- `get_it` — para injeção de dependência.  
- `dio` — para requisições HTTP.  
- `provider` — para gerenciamento de estado de UI.
- `flutter_native_splash` — para splash screen nativa.
- `result_dart` — para facilitar o uso do Result pattern.
- `shared_preferences` — para salvar dados primitivos localmente.
- Outras dependências específicas que o projeto utilize (ver `pubspec.yaml` para detalhes exatos).

---

### Estrutura de pastas  
```
lib/
 ├─ config/
 │   └─ clients/           — configuração do cliente HTTP
 │   └─ dependency_injection/— configuração de GetIt
 ├─ data/
 │   ├─ services/          — serviços de acesso à API ou local
 │   └─ repositories/       — implementações de repositório
 ├─ domain/
 │   └─ usecases/          — casos de uso
 ├─ ui/
 │   └─ login_and_signup/  — telas e ViewModels
 └─ main.dart              — ponto de entrada da aplicação
```

---

### Como executar  
```bash
fvm flutter run
```
Para execução específica em Android ou iOS:  
```bash
fvm flutter run -d <device_id>
```

---

### Como rodar testes  
Se o projeto possui testes (unidade/integrados):  
```bash
fvm flutter test
```
Certifique‑se que os mocks e injeções estejam configurados para testes.

---

### Melhorias futuras  
- Adicionar suporte a ambientes (desenvolvimento, homologação, produção) com `.env` ou `flutter_dotenv`.  
- Implementar interceptors do Dio para tratamento padrão de erros, refresh de token e logs de rede.  
- Adicionar testes unitários e de widget para ViewModels e UI.  
- Documentar componentes e fluxos de navegação / estados da UI.  
- Melhorar internacionalização (i18n) e acessibilidade.
- Finalizar demais features faltantes.
