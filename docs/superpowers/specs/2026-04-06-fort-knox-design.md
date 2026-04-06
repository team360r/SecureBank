# Fort Knox — Design Spec

**Date:** 2026-04-06
**Repo:** `https://github.com/team360r/secure.git` (private)
**App name:** FortKnox
**Tutorial name:** Fort Knox: Secure Flutter Development
**Currency:** GBP (£)

---

## Overview

A Docusaurus-based tutorial that teaches Flutter security to experienced developers through hardening a deliberately vulnerable banking app. The app starts with common security anti-patterns (hardcoded secrets, plaintext storage, no cert pinning, injectable inputs) and each chapter identifies a vulnerability, explains the real-world risk, then fixes it.

**Target audience:** Flutter developers who can build apps but haven't focused on security. Assumes familiarity with Flutter widgets, state management, and navigation.
**Format:** 12 chapters, ~6 hours total, text + code + quizzes + Mermaid diagrams.
**Structure:** Identical Docusaurus 3.9.2 stack as AccessBank and Learning to Fly — same components, same patterns, fortress-themed naming.

---

## Chapter Structure

| # | Title | Slug | Branch | Focus | ~Time |
|---|-------|------|--------|-------|-------|
| 0 | Threat Briefing | `threat-briefing` | `chapter-0-threat-briefing` | OWASP Mobile Top 10, security mindset, tour the vulnerable app | 15 min |
| 1 | Locking the Front Door | `front-door` | `chapter-1-front-door` | Secure auth — input validation, rate limiting, session tokens | 25 min |
| 2 | The Vault Door | `vault-door` | `chapter-2-vault-door` | Secure storage — flutter_secure_storage, Keychain/Keystore, never SharedPreferences for secrets | 25 min |
| 3 | Encrypted Channels | `encrypted-channels` | `chapter-3-encrypted-channels` | Network security — HTTPS enforcement, certificate pinning, MITM prevention | 30 min |
| 4 | Guarding the Payload | `payload` | `chapter-4-payload` | Data encryption at rest — AES with encrypt package, key derivation | 25 min |
| 5 | Need to Know | `access-control` | `chapter-5-access-control` | Authorization — role-based guards, deep link validation, route protection | 25 min |
| 6 | Hardened Inputs | `hardened-inputs` | `chapter-6-hardened-inputs` | Injection prevention — sanitizing input, XSS in WebViews, SQL injection in Drift | 30 min |
| 7 | Behind Closed Doors | `obfuscation` | `chapter-7-obfuscation` | Reverse engineering protection — ProGuard/R8, Dart obfuscation, anti-tampering | 25 min |
| 8 | The Watchtower | `watchtower` | `chapter-8-watchtower` | Secure logging — no PII in logs, crash reporting, audit trails | 25 min |
| 9 | Biometric Checkpoint | `biometrics` | `chapter-9-biometrics` | Biometric auth — local_auth, app lifecycle protection, screenshot prevention | 30 min |
| 10 | Penetration Test | `pen-test` | `chapter-10-pen-test` | Security testing — static analysis, dependency audit, CI security checks | 30 min |
| 11 | Deployment Lockdown | `deployment` | `chapter-11-deployment` | Secure release — signing, runtime integrity, env config, secrets management | 30 min |

**Total: 12 chapters, ~6 hours**

---

## FortKnox App — The Deliberately Vulnerable Starter

Same banking features as AccessBank/FlightBank, but starting with intentional security flaws:

### Screens
1. **Login screen** — hardcoded credentials, no rate limiting, passwords in logs
2. **Accounts overview** — API key in source code, no auth token rotation
3. **Transaction history** — unvalidated deep link params, PII in console logs
4. **Transfer screen** — no input sanitization, unencrypted amount storage
5. **Settings screen** — user token in SharedPreferences (plaintext), no biometrics

### Deliberate Vulnerabilities (fixed chapter by chapter)
- **Ch 0:** Identified during the "threat audit" walkthrough
- **Ch 1:** Hardcoded `admin/password123` login, no session expiry → proper auth with secure tokens
- **Ch 2:** API key and user token in SharedPreferences → flutter_secure_storage with Keychain/Keystore
- **Ch 3:** HTTP (not HTTPS) API calls, no cert pinning → HTTPS enforcement + certificate pinning
- **Ch 4:** Transaction amounts stored as plaintext in local DB → AES encryption at rest
- **Ch 5:** No route guards, deep links bypass auth → role-based GoRouter guards, validated params
- **Ch 6:** Raw user input passed to queries and WebViews → sanitization, parameterized queries
- **Ch 7:** Readable Dart source in release build → obfuscation flags, ProGuard rules
- **Ch 8:** PII logged to console, no audit trail → filtered logging, secure crash reporting
- **Ch 9:** No biometric lock, app visible in task switcher → local_auth + lifecycle protection
- **Ch 10:** No security CI checks → static analysis rules, dependency audit, security linter
- **Ch 11:** Debug keys in release, env secrets in source → proper signing, env management

### Data Model (GBP)
- `Account` — id, name, type (current/savings), balance (£), currency ('GBP')
- `Transaction` — id, accountId, amount (£), description, date, type (credit/debit)
- `User` — id, name, email, role (admin/user), sessionToken

---

## Docusaurus Site Structure

### Identical Infrastructure (Adapted from Learning to Fly)
- Docusaurus 3.9.2 with React 19
- `@docusaurus/theme-mermaid` for diagrams
- Prism with `dart`, `bash`, `yaml`, `json`, `swift`, `kotlin` highlighting
- Auto-generated sidebar from `docs/chapters/`
- Swizzled components: resume banner, visited checkmarks
- Quiz system with progress tracking
- Storage key: `fortknox_progress`

### Color Palette — Gold/Amber Fortress Theme
```
Light:
  --ifm-color-primary: #B8860B (dark goldenrod)
  --fk-amber-bg: #FFF8E1
  --fk-blue-bg: #FFF3E0
  --fk-green-bg: #E8F5E9

Dark:
  --ifm-color-primary: #FFD54F (amber)
  --fk-amber-bg: #3E2F00
  --fk-blue-bg: #3E2700
  --fk-green-bg: #0A2F0A
```

### CSS prefix: `fk-` (FortKnox)
- `.fk-callout`, `.fk-callout--amber`, `.fk-callout--blue`, `.fk-callout--green`
- `.fk-step`, `.fk-step__badge`, `.fk-step__content`

### Landing Page
1. **Hero** — "Fort Knox" title, tagline: "Harden a Flutter banking app against real-world attacks. From OWASP to deployment."
2. **Features** — 3 cards: "Fix Real Vulnerabilities" / "12 Progressive Chapters" / "Before & After"
3. **Chapter Roadmap** — Numbered list with descriptions
4. **Quick Start** — Clone, setup.sh, start.sh
5. **CTA** — "Start Chapter 0: Threat Briefing"

### File Structure
```
secure/
├── docs-site/
│   ├── docusaurus.config.ts
│   ├── sidebars.ts
│   ├── package.json
│   ├── tsconfig.json
│   ├── static/img/
│   ├── src/
│   │   ├── css/custom.css
│   │   ├── pages/index.tsx + index.module.css
│   │   ├── hooks/useProgress.ts
│   │   ├── components/Quiz/
│   │   └── theme/ (DocRoot/Layout, DocSidebarItem)
│   └── docs/
│       ├── intro.md
│       └── chapters/ (00-threat-briefing through 11-deployment)
├── lib/                    # Flutter app
│   ├── main.dart
│   ├── app.dart
│   ├── screens/
│   ├── data/
│   ├── services/           # Security services
│   ├── routing/
│   ├── providers/
│   ├── theme/
│   └── widgets/
├── pubspec.yaml
├── setup.sh
├── start.sh
└── README.md
```

---

## Chapter Content — Detailed Outlines

### Chapter 0: Threat Briefing
**Goal:** Understand the security landscape and identify vulnerabilities.

Sections:
1. Why security matters for mobile apps — real breach examples
2. OWASP Mobile Top 10 overview (M1-M10 mapped to Flutter)
3. Clone the repo, run the deliberately vulnerable app
4. Guided "threat audit" — walk through the app identifying each vulnerability
5. The security fix roadmap — what we'll fix and in what order

Deep Dive: OWASP Mobile Top 10, NIST Mobile Security Guidelines, Flutter security best practices
Quiz: 4 questions on OWASP categories, common mobile vulnerabilities

### Chapter 1: Locking the Front Door
**Goal:** Secure the authentication flow.

Sections:
1. The vulnerability: hardcoded credentials, passwords logged to console
2. Secure password handling — never store/log raw passwords
3. Token-based authentication — JWT or session tokens
4. Rate limiting login attempts (client-side + explaining server-side)
5. Session management — token rotation, secure expiry
6. Before/After: insecure login vs secure login

Deep Dive: OWASP M1 (Improper Credential Usage), JWT best practices, Dart crypto
Quiz: 4 questions

### Chapter 2: The Vault Door
**Goal:** Secure local data storage.

Sections:
1. The vulnerability: API key and user token in SharedPreferences
2. Why SharedPreferences is NOT secure (plaintext XML/plist)
3. flutter_secure_storage — backed by Keychain (iOS) and EncryptedSharedPreferences (Android)
4. Migrate sensitive data from SharedPreferences to secure storage
5. What belongs in secure storage vs regular storage (decision matrix)
6. Key management basics
7. Before/After: plaintext storage vs encrypted

Deep Dive: OWASP M9 (Insecure Data Storage), Keychain Services, Android Keystore
Quiz: 4 questions

### Chapter 3: Encrypted Channels
**Goal:** Secure network communication.

Sections:
1. The vulnerability: HTTP calls, no certificate validation
2. HTTPS enforcement — why and how
3. Certificate pinning with http_certificate_pinning or dio
4. Implementing a pinned HTTP client
5. Handling pin failures gracefully (don't crash, do alert)
6. Man-in-the-middle attack explanation (Mermaid diagram)
7. Network security config for Android, ATS for iOS
8. Before/After: HTTP vs pinned HTTPS

Deep Dive: OWASP M5 (Insecure Communication), Certificate Pinning guide, SSL Labs
Quiz: 4 questions

### Chapter 4: Guarding the Payload
**Goal:** Encrypt sensitive data at rest.

Sections:
1. The vulnerability: plaintext transaction data in local Drift DB
2. Why encryption at rest matters (device theft, backup extraction)
3. AES encryption with the encrypt package
4. Key derivation from user credentials (PBKDF2)
5. Building an EncryptionService class
6. Encrypting sensitive Drift columns
7. Before/After: plaintext DB vs encrypted

Deep Dive: OWASP M9 (Insecure Data Storage), AES-256, PBKDF2 key derivation
Quiz: 4 questions

### Chapter 5: Need to Know
**Goal:** Proper authorization and access control.

Sections:
1. The vulnerability: no route guards, deep links bypass auth
2. Role-based access control concepts (RBAC)
3. GoRouter redirect guards with role checking
4. Validating deep link parameters (prevent injection via URL)
5. API-side authorization headers (explaining the full picture)
6. Before/After: unguarded routes vs role-protected

Deep Dive: OWASP M6 (Inadequate Privacy Controls), RBAC patterns, deep link security
Quiz: 4 questions

### Chapter 6: Hardened Inputs
**Goal:** Prevent injection attacks.

Sections:
1. The vulnerability: raw input to Drift queries and WebView
2. SQL injection in Drift — parameterized queries vs string interpolation
3. XSS prevention in Flutter WebViews — sanitizing HTML content
4. Input validation patterns — allowlists over denylists
5. Building a SanitizationService
6. Before/After: injectable vs sanitized inputs

Deep Dive: OWASP M7 (Client Code Quality), SQL injection prevention, WebView security
Quiz: 5 questions

### Chapter 7: Behind Closed Doors
**Goal:** Protect against reverse engineering.

Sections:
1. The vulnerability: readable Dart source in release builds
2. What attackers can extract from an APK/IPA
3. Dart obfuscation flags (--obfuscate --split-debug-info)
4. Android ProGuard/R8 rules for Flutter
5. Detecting rooted/jailbroken devices
6. Anti-tampering: verifying app signature at runtime
7. What obfuscation does NOT protect (and what does)

Deep Dive: OWASP M8 (Code Tampering), M9 (Reverse Engineering), ProGuard docs
Quiz: 4 questions

### Chapter 8: The Watchtower
**Goal:** Secure logging and monitoring.

Sections:
1. The vulnerability: PII (emails, tokens) in console output
2. Secure logging rules — what to log, what never to log
3. Building a SecureLogger that filters sensitive data
4. Structured logging for audit trails
5. Crash reporting without PII (Sentry/Firebase Crashlytics config)
6. Before/After: PII-leaking logs vs filtered logs

Deep Dive: OWASP M3 (Insecure Communication of logs), logging best practices
Quiz: 4 questions

### Chapter 9: Biometric Checkpoint
**Goal:** Add biometric authentication and app lifecycle protection.

Sections:
1. The vulnerability: no re-authentication, app visible in task switcher
2. local_auth package — fingerprint and face authentication
3. Biometric prompt on app resume (after background)
4. Screenshot prevention (FLAG_SECURE on Android, UITextField trick on iOS)
5. App lifecycle management — lock on background, require re-auth
6. Secure clipboard handling — clear sensitive copied data
7. Before/After: unprotected app vs biometric-secured

Deep Dive: local_auth package, iOS LAContext, Android BiometricPrompt
Quiz: 4 questions

### Chapter 10: Penetration Test
**Goal:** Automated security testing.

Sections:
1. The vulnerability: no security checks in development workflow
2. Static analysis with custom lint rules for security
3. Dependency auditing — finding vulnerable packages
4. SAST tools for Flutter/Dart
5. Building a security check CI pipeline (GitHub Actions)
6. Manual penetration testing checklist
7. Before/After: no checks vs CI security pipeline

Deep Dive: OWASP Mobile Security Testing Guide, Dart analyzer, GitHub security features
Quiz: 4 questions

### Chapter 11: Deployment Lockdown
**Goal:** Secure release and runtime protection.

Sections:
1. The vulnerability: debug signing in release, secrets in source code
2. Environment-specific configuration (--dart-define, .env files)
3. Secure key management — never commit signing keys
4. Runtime integrity checks — detecting debuggers, emulators
5. App attestation (Play Integrity API, App Attest)
6. Release checklist: security audit before every deploy
7. What you've built — recap all 12 chapters
8. Where to go next — security resources, bug bounty programs

Deep Dive: Play Integrity API, App Attest, secure CI/CD for Flutter
Quiz: 4 questions

---

## Content Style Guide

### Same conventions as AccessBank / Learning to Fly
- MDX with YAML frontmatter
- Fortress/security-themed quotes at chapter starts
- Metadata: `**Estimated time:** ~XX minutes | **Focus:** Screen | **Branch:** \`chapter-N-slug\``
- Admonitions: `:::tip`, `:::info`, `:::caution` (no raw HTML divs)
- Mermaid diagrams for attack flows and security architecture
- Before/After tabs for vulnerable vs secure code
- Quiz at end of each chapter (3-5 questions)
- Deep Dive links + What's Next in Part 2

### Voice
- Direct, practical, security-aware
- Assumes Flutter knowledge, explains security concepts
- Fortress/vault metaphors where natural
- "You" addressing the reader

---

## Technical Dependencies

### Flutter (pubspec.yaml — full list, added incrementally per chapter)
- **SDK:** Flutter ^3.22.0, Dart ^3.4.0
- **Ch 1:** (no new deps — just better auth patterns)
- **Ch 2:** `flutter_secure_storage: ^9.0.0`
- **Ch 3:** `http: ^1.2.0` (already present), cert pinning approach
- **Ch 4:** `encrypt: ^5.0.0`, `pointycastle: ^3.7.0`
- **Ch 5:** `go_router: ^14.0.0` (already present)
- **Ch 6:** `drift: ^2.20.0` (already present), `html_unescape: ^2.0.0`
- **Ch 7:** (build flags, no new packages)
- **Ch 8:** `logger: ^2.0.0`
- **Ch 9:** `local_auth: ^2.2.0`
- **Ch 10:** (CI config, no new runtime packages)
- **Ch 11:** (build config, no new runtime packages)

### Always present
- `flutter_riverpod: ^2.6.0`
- `go_router: ^14.0.0`
- `drift: ^2.20.0`
- `google_fonts: ^6.1.0`
- `intl: ^0.19.0`

---

## Git Strategy
- `main` branch: complete app + all tutorial content
- `chapter-N-slug` branches: app state after each chapter (incremental from main)
- `completed` branch: same as chapter-11
- All branches share ancestry with main (no orphan branches)

---

## What's NOT in Scope
- No server-side security (this is a Flutter/mobile tutorial)
- No Firebase security rules (could be a future addition)
- No iOS/Android specific security deep dives beyond what Flutter APIs expose
- No formal security certification guidance
