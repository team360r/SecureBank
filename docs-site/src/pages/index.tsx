import type {ReactNode} from 'react';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import styles from './index.module.css';

const chapters = [
  { num: 0, title: 'Threat Briefing', branch: 'chapter-0-threat-briefing',
    desc: 'Understand the OWASP Mobile Top 10, tour the vulnerable app, and map out what needs fixing.', time: '~15 min' },
  { num: 1, title: 'Locking the Front Door', branch: 'chapter-1-front-door',
    desc: 'Secure authentication with proper validation, session tokens, and rate limiting.', time: '~25 min' },
  { num: 2, title: 'The Vault Door', branch: 'chapter-2-vault-door',
    desc: 'Move secrets from SharedPreferences to flutter_secure_storage backed by Keychain and Keystore.', time: '~25 min' },
  { num: 3, title: 'Encrypted Channels', branch: 'chapter-3-encrypted-channels',
    desc: 'Enforce HTTPS, implement certificate pinning, and prevent man-in-the-middle attacks.', time: '~30 min' },
  { num: 4, title: 'Guarding the Payload', branch: 'chapter-4-payload',
    desc: 'Encrypt sensitive data at rest with AES and proper key derivation.', time: '~25 min' },
  { num: 5, title: 'Need to Know', branch: 'chapter-5-access-control',
    desc: 'Add role-based route guards, validate deep links, and enforce authorization.', time: '~25 min' },
  { num: 6, title: 'Hardened Inputs', branch: 'chapter-6-hardened-inputs',
    desc: 'Prevent SQL injection, XSS in WebViews, and sanitize all user input.', time: '~30 min' },
  { num: 7, title: 'Behind Closed Doors', branch: 'chapter-7-obfuscation',
    desc: 'Obfuscate Dart code, configure ProGuard, and detect tampered builds.', time: '~25 min' },
  { num: 8, title: 'The Watchtower', branch: 'chapter-8-watchtower',
    desc: 'Build secure logging that never leaks PII, plus audit trails and crash reporting.', time: '~25 min' },
  { num: 9, title: 'Biometric Checkpoint', branch: 'chapter-9-biometrics',
    desc: 'Add fingerprint/face auth, screenshot prevention, and app lifecycle protection.', time: '~30 min' },
  { num: 10, title: 'Penetration Test', branch: 'chapter-10-pen-test',
    desc: 'Set up static analysis, dependency auditing, and security checks in CI.', time: '~30 min' },
  { num: 11, title: 'Deployment Lockdown', branch: 'chapter-11-deployment',
    desc: 'Secure signing, runtime integrity checks, environment config, and secrets management.', time: '~30 min' },
];

const features = [
  { icon: '{}', title: 'Fix Real Vulnerabilities',
    desc: 'Start with a deliberately insecure app and harden it chapter by chapter against the OWASP Mobile Top 10.' },
  { icon: '12', title: '12 Progressive Chapters',
    desc: 'From threat assessment in Chapter 0 to deployment lockdown in Chapter 11.' },
  { icon: '<>', title: 'Before & After',
    desc: 'Toggle between vulnerable and secure code. See exactly what each fix changes and why it matters.' },
];

function HeroSection(): ReactNode {
  return (
    <header className={styles.hero}>
      <div className={styles.heroInner}>
        <p className={styles.heroPre}>Flutter Security Tutorial</p>
        <h1 className={styles.heroTitle}>Fort Knox</h1>
        <p className={styles.heroTagline}>
          Harden a Flutter banking app against real-world attacks.<br />
          From OWASP to deployment. Every vulnerability explained and fixed.
        </p>
        <div className={styles.heroButtons}>
          <Link className={styles.btnPrimary} to="/chapters/threat-briefing">Start Chapter 0</Link>
          <Link className={styles.btnSecondary} to="/intro">Read the Introduction</Link>
        </div>
      </div>
    </header>
  );
}

function FeaturesSection(): ReactNode {
  return (
    <section className={styles.features}>
      <div className={styles.container}>
        <div className={styles.featureGrid}>
          {features.map((f) => (
            <div key={f.title} className={styles.featureCard}>
              <div className={styles.featureIcon}>{f.icon}</div>
              <h3 className={styles.featureTitle}>{f.title}</h3>
              <p className={styles.featureDesc}>{f.desc}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

function ChapterRoadmap(): ReactNode {
  return (
    <section className={styles.roadmap}>
      <div className={styles.container}>
        <h2 className={styles.sectionTitle}>Chapter Roadmap</h2>
        <p className={styles.sectionSubtitle}>Twelve focused chapters, each hardening a different attack surface. Total time: roughly 6 hours.</p>
        <ol className={styles.chapterList}>
          {chapters.map((ch) => (
            <li key={ch.num} className={styles.chapterItem}>
              <span className={styles.chapterNum}>{ch.num}</span>
              <div className={styles.chapterBody}>
                <div className={styles.chapterHeader}>
                  <strong className={styles.chapterTitle}>{ch.title}</strong>
                  <span className={styles.chapterTime}>{ch.time}</span>
                </div>
                <p className={styles.chapterDesc}>{ch.desc}</p>
              </div>
            </li>
          ))}
        </ol>
      </div>
    </section>
  );
}

function QuickStartSection(): ReactNode {
  return (
    <section className={styles.quickstart}>
      <div className={styles.container}>
        <h2 className={styles.sectionTitle}>Quick Start</h2>
        <p className={styles.sectionSubtitle}>Two commands and you are up — vulnerable app on device, guide in your browser.</p>
        <div className={styles.quickstartGrid}>
          <div className={styles.codeBlock}>
            <p className={styles.codeLabel}>1. Clone and install</p>
            <pre className={styles.pre}><code>{`git clone git@github.com:team360r/secure.git
cd secure
./setup.sh`}</code></pre>
          </div>
          <div className={styles.codeBlock}>
            <p className={styles.codeLabel}>2. Start everything</p>
            <pre className={styles.pre}><code>{`./start.sh
# Opens browser + launches app`}</code></pre>
          </div>
          <div className={styles.codeBlock}>
            <p className={styles.codeLabel}>3. Open in your IDE</p>
            <pre className={styles.pre}><code>{`code .
# VS Code — or open in Android Studio`}</code></pre>
          </div>
        </div>
      </div>
    </section>
  );
}

function CtaSection(): ReactNode {
  return (
    <section className={styles.cta}>
      <div className={styles.container}>
        <h2 className={styles.ctaTitle}>Ready to lock it down?</h2>
        <p className={styles.ctaSubtitle}>
          Start with Chapter 0 — understand the threat landscape, tour the vulnerable app,
          and map out every security fix you will make across 12 chapters.
        </p>
        <Link className={styles.btnPrimary} to="/chapters/threat-briefing">Start Chapter 0: Threat Briefing</Link>
      </div>
    </section>
  );
}

export default function Home(): ReactNode {
  const {siteConfig} = useDocusaurusContext();
  return (
    <Layout title={siteConfig.title}
      description="Harden a Flutter banking app against real-world attacks. 12 progressive chapters covering OWASP Mobile Top 10, encryption, auth, and secure deployment.">
      <HeroSection />
      <main>
        <FeaturesSection />
        <ChapterRoadmap />
        <QuickStartSection />
        <CtaSection />
      </main>
    </Layout>
  );
}
