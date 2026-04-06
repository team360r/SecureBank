// docs-site/src/components/Quiz/Quiz.tsx
import React from 'react';
import { useProgress } from '../../hooks/useProgress';
import { QuizQuestion, QuizQuestionProps } from './QuizQuestion';
import styles from './Quiz.module.css';

interface QuizProps {
  chapterId: string;
  children: React.ReactNode;
}

export function Quiz({ chapterId, children }: QuizProps) {
  const { progress, saveQuiz } = useProgress();
  const saved = progress.quizAnswers[chapterId];

  const questions = React.Children.toArray(children).filter(
    (child): child is React.ReactElement<QuizQuestionProps> =>
      React.isValidElement(child),
  );
  const count = questions.length;

  const [answers, setAnswers] = React.useState<(number | null)[]>(
    () => saved?.answers ?? Array<number | null>(count).fill(null),
  );
  const [revealed, setRevealed] = React.useState(() => saved?.revealed ?? false);

  const answeredCount = answers.filter(a => a !== null).length;
  const allAnswered = answeredCount === count;

  function handleAnswer(questionIndex: number, selectedIndex: number) {
    setAnswers(prev => {
      const next = [...prev];
      next[questionIndex] = selectedIndex;
      return next;
    });
  }

  function handleReveal() {
    setRevealed(true);
    saveQuiz(chapterId, answers, true);
  }

  const score = revealed
    ? questions.filter((q, i) => answers[i] === q.props.correctIndex).length
    : 0;

  function scoreCardClass(): string {
    if (score === count) return `${styles.scoreCard} ${styles.scoreCardGreen}`;
    if (score === 0) return `${styles.scoreCard} ${styles.scoreCardRed}`;
    return `${styles.scoreCard} ${styles.scoreCardAmber}`;
  }

  function scoreLabel(): string {
    if (score === count) return 'Perfect score!';
    if (score === 0) return 'Keep going — review the explanations below.';
    return 'Good effort — check the explanations below.';
  }

  return (
    <div>
      {revealed && (
        <div className={scoreCardClass()}>
          <div className={styles.scoreNumber}>
            {score} / {count}
          </div>
          <div className={styles.scoreLabel}>{scoreLabel()}</div>
        </div>
      )}
      {questions.map((child, i) =>
        React.cloneElement(child, {
          questionIndex: i,
          selectedIndex: answers[i],
          revealed,
          onAnswer: handleAnswer,
        }),
      )}
      {!revealed && (
        <button
          className={styles.checkButton}
          disabled={!allAnswered}
          onClick={handleReveal}
        >
          {allAnswered
            ? 'Check Answers'
            : `Answer all questions to continue (${answeredCount}/${count})`}
        </button>
      )}
    </div>
  );
}
