import React from 'react';
import DocSidebarItem from '@theme-original/DocSidebarItem';
import type DocSidebarItemType from '@theme/DocSidebarItem';
import type {WrapperProps} from '@docusaurus/types';
import {useProgress} from '../../hooks/useProgress';

type Props = WrapperProps<typeof DocSidebarItemType>;

export default function DocSidebarItemWrapper(props: Props): React.ReactElement {
  const {progress} = useProgress();

  // Only link-type items have an href we can match
  const href = (props.item as {href?: string}).href ?? '';
  const isVisited = href
    ? progress.visitedPages.some(p => p === href || p.startsWith(href))
    : false;

  if (!isVisited) {
    return <DocSidebarItem {...props} />;
  }

  const visited = {
    ...props,
    item: {
      ...props.item,
      label: `${(props.item as {label: string}).label} +`,
      className: [
        (props.item as {className?: string}).className ?? '',
        'sidebar-item--visited',
      ]
        .filter(Boolean)
        .join(' '),
    },
  };

  return <DocSidebarItem {...(visited as Props)} />;
}
