import React from 'react';

const STORAGE_KEY = 'fortknox_progress';

export interface QuizState {
  answers: (number | null)[];
  revealed: boolean;
}

export interface Progress {
  lastPage: string;
  visitedPages: string[];
  quizAnswers: Record<string, QuizState>;
}

const defaultProgress: Progress = {
  lastPage: '',
  visitedPages: [],
  quizAnswers: {},
};

function readStorage(): Progress {
  if (typeof window === 'undefined') return defaultProgress;
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (!raw) return defaultProgress;
    return { ...defaultProgress, ...JSON.parse(raw) };
  } catch {
    return defaultProgress;
  }
}

function writeStorage(p: Progress): void {
  if (typeof window === 'undefined') return;
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(p));
  } catch {}
}

export function useProgress() {
  const [progress, setProgress] = React.useState<Progress>(readStorage);

  const markVisited = React.useCallback((path: string) => {
    setProgress(prev => {
      const alreadyVisited = prev.visitedPages.includes(path);
      const samePage = prev.lastPage === path;
      if (alreadyVisited && samePage) return prev;
      const next: Progress = {
        ...prev, lastPage: path,
        visitedPages: alreadyVisited ? prev.visitedPages : [...prev.visitedPages, path],
      };
      writeStorage(next);
      return next;
    });
  }, []);

  const saveQuiz = React.useCallback(
    (chapterId: string, answers: (number | null)[], revealed: boolean) => {
      setProgress(prev => {
        const next: Progress = { ...prev, quizAnswers: { ...prev.quizAnswers, [chapterId]: { answers, revealed } } };
        writeStorage(next);
        return next;
      });
    }, []);

  const clearProgress = React.useCallback(() => { writeStorage(defaultProgress); setProgress(defaultProgress); }, []);

  return { progress, markVisited, saveQuiz, clearProgress };
}
