import React from 'react';
import Layout from '@theme-original/DocRoot/Layout';
import type LayoutType from '@theme/DocRoot/Layout';
import type {WrapperProps} from '@docusaurus/types';
import {useLocation} from '@docusaurus/router';
import {useHistory} from 'react-router-dom';
import {useProgress} from '../../../hooks/useProgress';

type Props = WrapperProps<typeof LayoutType>;

const BANNER_DISMISSED_KEY = 'fortknox_banner_dismissed';

export default function LayoutWrapper(props: Props): React.ReactElement {
  const {pathname} = useLocation();
  const history = useHistory();
  const {progress} = useProgress();
  const [visible, setVisible] = React.useState(false);

  React.useEffect(() => {
    if (typeof window === 'undefined') return;
    const dismissed = sessionStorage.getItem(BANNER_DISMISSED_KEY);
    if (dismissed) return;
    const last = progress.lastPage;
    if (last && last !== pathname && last !== '/') setVisible(true);
  }, []);

  React.useEffect(() => { setVisible(false); }, [pathname]);

  function handleContinue() {
    sessionStorage.setItem(BANNER_DISMISSED_KEY, '1');
    setVisible(false);
    history.push(progress.lastPage);
  }

  function handleDismiss() {
    sessionStorage.setItem(BANNER_DISMISSED_KEY, '1');
    setVisible(false);
  }

  return (
    <>
      {visible && (
        <div style={{ position: 'sticky', top: 0, zIndex: 100, background: 'var(--ifm-color-primary-lightest)',
          borderBottom: '2px solid var(--ifm-color-primary)', padding: '0.6rem 1.5rem',
          display: 'flex', alignItems: 'center', gap: '1rem', flexWrap: 'wrap' }}>
          <span style={{flex: 1, fontSize: '0.9rem'}}>
            <strong>Welcome back!</strong> Continue where you left off: <code>{progress.lastPage}</code>
          </span>
          <button onClick={handleContinue} style={{ background: 'var(--ifm-color-primary)', color: 'white',
            border: 'none', borderRadius: '6px', padding: '0.4rem 1rem', cursor: 'pointer', fontWeight: 600 }}>Continue</button>
          <button onClick={handleDismiss} style={{ background: 'transparent', border: '1px solid var(--ifm-color-primary)',
            borderRadius: '6px', padding: '0.4rem 0.75rem', cursor: 'pointer', color: 'var(--ifm-color-primary)' }}
            aria-label="Dismiss resume banner">X</button>
        </div>
      )}
      <Layout {...props} />
    </>
  );
}
