# SecureBank — Flutter Security Tutorial

**Learn Flutter security by hardening a real banking app against the OWASP Mobile Top 10.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## What is this?

SecureBank is a hands-on Flutter security tutorial where you start with a deliberately vulnerable banking app and harden it — one chapter at a time. You will learn how real-world attacks work, how Flutter apps are exploited, and how to write secure code that protects user data across iOS and Android.

The tutorial is delivered through a **browser-based guide** (Docusaurus site) that runs alongside the app. Open the guide in your browser, edit code in your IDE, and see the results instantly on your connected device or simulator. Each chapter identifies a vulnerability, explains the attack vector, and walks you through the fix. No prior security experience is needed — that's what we're here for!

---

## Prerequisites

- [ ] Flutter SDK 3.x+ — [Install Flutter](https://docs.flutter.dev/get-started/install)
- [ ] Node.js 18+ — [nodejs.org](https://nodejs.org) — for the tutorial guide
- [ ] VS Code — [Set up VS Code for Flutter](https://docs.flutter.dev/tools/vs-code) OR Android Studio — [Set up Android Studio](https://docs.flutter.dev/tools/android-studio)
- [ ] An iOS device/simulator or Android device/emulator
- [ ] Basic Flutter knowledge (built at least one app)
- [ ] No security experience needed!

---

## Quick Start

```bash
git clone git@github.com:team360r/SecureBank.git
cd SecureBank
./setup.sh
```

`setup.sh` installs all dependencies and configures iOS signing (you'll be prompted for your Apple Developer Team ID if you're running on a physical iPhone).

Then start everything with one command:

```bash
./start.sh
```

This opens the tutorial guide at `http://localhost:3000` and launches the app on your connected device or simulator.

Finally, open the project in your IDE:

```bash
code .              # VS Code
# or open the SecureBank/ folder in Android Studio
```

---

## How This Tutorial Works

You work in two windows — the tutorial in your browser, SecureBank in your IDE. Each chapter identifies a vulnerability, explains the attack, then walks you through the fix.

| Panel | What's Here |
|-------|-------------|
| **Browser** | Tutorial guide at `localhost:3000` — vulnerability analysis, attack demos, and fix walkthroughs |
| **IDE** | VS Code or Android Studio — where you edit the Flutter code |
| **Device** | Your connected iPhone/simulator or Android phone/emulator with hot reload |

The tutorial site tracks your progress automatically — visited pages get a checkmark in the sidebar, and a "Welcome back" banner picks up where you left off.

### Chapter Branches

Every chapter has a matching **git branch** containing the app exactly as it should look after completing that chapter. The branches build incrementally — each one adds only the security fixes introduced in that chapter:

| Branch | What it contains |
|--------|-----------------|
| `chapter-0-threat-briefing` | Vulnerable starter app, issues identified |
| `chapter-1-front-door` | + Secure auth, session tokens, rate limiting |
| `chapter-2-vault-door` | + flutter_secure_storage for secrets |
| `chapter-3-encrypted-channels` | + HTTPS enforcement, certificate pinning |
| `chapter-4-payload` | + AES encryption at rest |
| `chapter-5-access-control` | + Role-based route guards, deep link validation |
| `chapter-6-hardened-inputs` | + Input sanitization, parameterized queries |
| `chapter-7-obfuscation` | + Dart obfuscation, ProGuard, anti-tampering |
| `chapter-8-watchtower` | + Secure logging, PII filtering, audit trail |
| `chapter-9-biometrics` | + Biometric auth, screenshot prevention |
| `chapter-10-pen-test` | + Security CI pipeline, static analysis |
| `chapter-11-deployment` | + Secure signing, runtime integrity |
| `completed` | The fully hardened app |

**Stuck on a chapter?** Check out the branch to see the solution:

```bash
# See the completed code for chapter 3
git checkout chapter-3-encrypted-channels

# Compare your work against the solution
git diff chapter-3-encrypted-channels -- lib/

# Go back to your working branch
git checkout main
```

> **Tip:** You don't need to use the branches at all if you're following along and writing the code yourself — they're a safety net, not a requirement.

---

## Chapter Overview

| # | Chapter | Branch | What You'll Fix | Time |
|---|---------|--------|-----------------|------|
| 0 | Threat Briefing | `chapter-0-threat-briefing` | OWASP Top 10 overview, tour the vulnerable app | ~15 min |
| 1 | Locking the Front Door | `chapter-1-front-door` | Hardcoded creds, no session management | ~25 min |
| 2 | The Vault Door | `chapter-2-vault-door` | Secrets in SharedPreferences | ~25 min |
| 3 | Encrypted Channels | `chapter-3-encrypted-channels` | HTTP calls, no cert pinning | ~30 min |
| 4 | Guarding the Payload | `chapter-4-payload` | Plaintext data in local DB | ~25 min |
| 5 | Need to Know | `chapter-5-access-control` | No route guards, deep link bypass | ~25 min |
| 6 | Hardened Inputs | `chapter-6-hardened-inputs` | SQL injection, XSS in WebViews | ~30 min |
| 7 | Behind Closed Doors | `chapter-7-obfuscation` | Readable source in release builds | ~25 min |
| 8 | The Watchtower | `chapter-8-watchtower` | PII in logs, no audit trail | ~25 min |
| 9 | Biometric Checkpoint | `chapter-9-biometrics` | No re-auth, visible in task switcher | ~30 min |
| 10 | Penetration Test | `chapter-10-pen-test` | No security CI checks | ~30 min |
| 11 | Deployment Lockdown | `chapter-11-deployment` | Debug keys in release, secrets in source | ~30 min |

**Total time:** ~6 hours

### Learning Path

**Phase 1 — Authentication & Storage** (Chapters 0-2)
> Threat assessment, secure login, and encrypted storage. The app stops leaking credentials.

**Phase 2 — Data Protection** (Chapters 3-6)
> Network security, encryption at rest, access control, and injection prevention. Data is protected in transit and at rest.

**Phase 3 — Hardening & Deployment** (Chapters 7-11)
> Obfuscation, secure logging, biometrics, security testing, and production deployment. The app is battle-ready.

---

## Project Structure

```
SecureBank/
├── docs-site/                  # Tutorial website (Docusaurus)
│   ├── docs/chapters/          #   12 chapters, each with Part 1 + Part 2 + Quiz
│   ├── src/components/Quiz/    #   Quiz system with progress tracking
│   └── src/theme/              #   Resume banner + visited checkmarks
│
├── lib/                        # SecureBank app (Flutter)
│   ├── screens/                #   Login, Accounts, Transactions, Transfer, Settings
│   ├── services/               #   SecureStorage, Encryption, Biometric, AuditLogger
│   ├── providers/              #   Riverpod state management
│   ├── routing/                #   GoRouter with security guards
│   ├── database/               #   Drift tables with encrypted columns
│   ├── data/                   #   Models, mock data (GBP), API service
│   ├── theme/                  #   Material 3 theming
│   └── widgets/                #   Reusable components
│
├── setup.sh                    # Install Flutter + Node deps
└── start.sh                    # Launch tutorial at localhost:3000
```

---

## Useful Resources

### Flutter Security

- [Flutter Security Overview](https://docs.flutter.dev/security)
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
- [encrypt package](https://pub.dev/packages/encrypt)
- [local_auth (biometrics)](https://pub.dev/packages/local_auth)

### OWASP

- [OWASP Mobile Top 10](https://owasp.org/www-project-mobile-top-10/)
- [OWASP Mobile Security Testing Guide](https://mas.owasp.org/MASTG/)
- [OWASP Mobile Application Security Checklist](https://mas.owasp.org/checklists/)

### Tools

- [Flutter DevTools](https://docs.flutter.dev/tools/devtools/overview)
- [MobSF — Mobile Security Framework](https://mobsf.github.io/docs/)

---

## Troubleshooting

**"Tutorial site won't start"**
Check that Node.js 18+ is installed (`node --version`). Then run `cd docs-site && npm install` and try `./start.sh` again.

**"App won't install on my iPhone"**
Run `./setup.sh` again and enter your Apple Developer Team ID when prompted. If you don't have one, use a simulator instead (`flutter run -d "iPhone 16"`).

**"Hot reload not working"**
Make sure `./start.sh` is running and your device/simulator is connected. Save a file in your IDE to trigger hot reload.

**"App looks different from the chapter branch"**
Check which branch you are on (`git branch`) and run `flutter pub get` after switching branches.

---

## Tech Stack

**Tutorial site:** Docusaurus 3.9, React 19, TypeScript, Mermaid diagrams

**SecureBank app:** Flutter 3.22+, Riverpod 3, GoRouter 14, Drift 2.20, flutter_secure_storage, encrypt, local_auth

---

## Contributing & License

This project is licensed under the [MIT License](LICENSE). Contributions are welcome — please open an issue first to discuss any significant changes.

Built with Docusaurus and a healthy dose of paranoia. Stay safe out there.
