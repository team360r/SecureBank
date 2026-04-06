# Fort Knox

> *"The only truly secure system is one that is powered off, cast in a block of concrete and sealed in a lead-lined room with armed guards."* — Gene Spafford

**Fort Knox** is a hands-on Flutter security tutorial. You'll start with a deliberately vulnerable banking app and harden it against the OWASP Mobile Top 10 across 12 progressive chapters.

No toy examples. A real banking app with real vulnerabilities, fixed one at a time.

---

## What You'll Build

FortKnox is a multi-screen banking app (GBP) that starts with intentional security flaws:

- Hardcoded credentials and API keys in source code
- Sensitive data stored in plaintext SharedPreferences
- HTTP calls with no certificate pinning
- Unencrypted transaction data in the local database
- No route guards — deep links bypass authentication
- Raw user input passed directly to database queries
- PII leaked in console logs
- No biometric lock or screenshot prevention

By the end, every vulnerability is fixed and you understand *why* each fix matters.

## The Battle Plan

| Ch | Title | What You'll Fix | Time |
|----|-------|-----------------|------|
| 0 | **Threat Briefing** | OWASP Top 10 overview, tour the vulnerable app | ~15 min |
| 1 | **Locking the Front Door** | Hardcoded creds, no session management | ~25 min |
| 2 | **The Vault Door** | Secrets in SharedPreferences | ~25 min |
| 3 | **Encrypted Channels** | HTTP calls, no cert pinning | ~30 min |
| 4 | **Guarding the Payload** | Plaintext data in local DB | ~25 min |
| 5 | **Need to Know** | No route guards, deep link bypass | ~25 min |
| 6 | **Hardened Inputs** | SQL injection, XSS in WebViews | ~30 min |
| 7 | **Behind Closed Doors** | Readable source in release builds | ~25 min |
| 8 | **The Watchtower** | PII in logs, no audit trail | ~25 min |
| 9 | **Biometric Checkpoint** | No re-auth, visible in task switcher | ~30 min |
| 10 | **Penetration Test** | No security CI checks | ~30 min |
| 11 | **Deployment Lockdown** | Debug keys in release, secrets in source | ~30 min |

**Total time:** ~6 hours

## Who Is This For?

You're a Flutter developer who can build apps. You know widgets, Riverpod, GoRouter — but you haven't focused on security. This tutorial assumes Flutter knowledge and teaches security from scratch.

## Quick Start

```bash
git clone git@github.com:team360r/secure.git
cd secure
./setup.sh
./start.sh
```

Then open the project in your IDE and head to **Chapter 0: Threat Briefing**.

## How It Works

You work in two windows — the tutorial in your browser, FortKnox in your IDE. Each chapter identifies a vulnerability, explains the attack, then walks you through the fix.

The tutorial site tracks your progress automatically — visited pages get a checkmark, and a "Welcome back" banner picks up where you left off.

## Chapter Branches

Every chapter has a matching **git branch** containing the app exactly as it should look after completing that chapter. The branches build incrementally — each one adds only the security fixes from that chapter:

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
git checkout chapter-3-encrypted-channels
git diff chapter-3-encrypted-channels -- lib/
git checkout main
```

## Learning Path

**Phase 1 — Authentication & Storage** (Chapters 0-2)
> Threat assessment, secure login, and encrypted storage. The app stops leaking credentials.

**Phase 2 — Data Protection** (Chapters 3-6)
> Network security, encryption at rest, access control, and injection prevention. Data is protected in transit and at rest.

**Phase 3 — Hardening & Deployment** (Chapters 7-11)
> Obfuscation, secure logging, biometrics, security testing, and production deployment. The app is battle-ready.

## Project Structure

```
secure/
├── docs-site/                  # Tutorial website (Docusaurus)
│   ├── docs/chapters/          #   12 chapters, each with Part 1 + Part 2 + Quiz
│   ├── src/components/Quiz/    #   Quiz system with progress tracking
│   └── src/theme/              #   Resume banner + visited checkmarks
│
├── lib/                        # FortKnox app (Flutter)
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

## Tech Stack

**Tutorial site:** Docusaurus 3.9, React 19, TypeScript, Mermaid diagrams

**FortKnox app:** Flutter 3.22+, Riverpod 3, GoRouter 14, Drift 2.20, flutter_secure_storage, encrypt, local_auth

## Requirements

- **Flutter SDK** 3.22+ ([install](https://docs.flutter.dev/get-started/install))
- **Node.js** 20+ (for the tutorial site)
- **A device or emulator**
- **An IDE** — VS Code or Android Studio

---

Built with Docusaurus and a healthy dose of paranoia. Stay safe out there.
