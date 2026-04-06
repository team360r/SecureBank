---
sidebar_position: 1
slug: /intro
title: Introduction
description: "Welcome to Fort Knox — a hands-on Flutter security tutorial built around a real banking app."
---

# Introduction

**Fort Knox** is a hands-on Flutter security tutorial for developers who can build apps but haven't focused on security. You'll start with a deliberately vulnerable banking app and harden it chapter by chapter against the OWASP Mobile Top 10.

## What you'll learn

Over 12 chapters and roughly 6 hours, you'll fix real security vulnerabilities:

- **Authentication** — Secure login, session management, token handling
- **Secure Storage** — Keychain/Keystore via flutter_secure_storage
- **Network Security** — HTTPS enforcement, certificate pinning, MITM prevention
- **Encryption** — AES at rest, key derivation, encrypted database columns
- **Authorization** — Role-based guards, deep link validation
- **Injection Prevention** — SQL injection, XSS, input sanitization
- **Obfuscation** — Dart obfuscation, ProGuard, anti-tampering
- **Secure Logging** — PII filtering, audit trails, crash reporting
- **Biometrics** — local_auth, screenshot prevention, lifecycle protection
- **Security Testing** — Static analysis, dependency auditing, CI pipeline
- **Secure Deployment** — Signing, runtime integrity, secrets management

## Who this is for

You're a Flutter developer who can build apps. You know widgets, state management, and navigation — but you haven't focused on security. No prior security experience needed.

## How it works

Each chapter follows the same pattern: identify a vulnerability, explain the real-world risk, then fix it. You'll work in two windows — this tutorial in your browser and the FortKnox app in your IDE.

### Chapter branches

Every chapter has a matching git branch that contains FortKnox exactly as it should look after completing that chapter. The branches build incrementally — `chapter-1-front-door` secures authentication, `chapter-3-encrypted-channels` adds cert pinning, and so on up to `completed` which is the fully hardened app.

```bash
# See the finished code for any chapter
git checkout chapter-3-encrypted-channels

# Compare your work against the solution
git diff chapter-3-encrypted-channels -- lib/

# Go back to where you were
git checkout main
```

:::tip
You don't need to use the branches at all if you're following along — they're a safety net, not a requirement.
:::

## Prerequisites

- Flutter SDK 3.22+ and basic Flutter experience
- Node.js 20+ (for the tutorial site)
- A device or emulator
- An IDE — VS Code or Android Studio

## Quick Start

```bash
git clone git@github.com:team360r/secure.git
cd secure
./setup.sh
./start.sh
```

Then head to [Chapter 0: Threat Briefing](/chapters/threat-briefing).
