// docs-site/src/components/Quiz/QuizQuestion.tsx
import React from 'react';
import styles from './Quiz.module.css';

const LABELS = ['A', 'B', 'C', 'D'];

export interface QuizQuestionProps {
  question: string;
  options: string[];
  correctIndex: number;
  explanation: string;
  // Set by Quiz parent — do not pass manually in MDX:
  questionIndex?: number;
  selectedIndex?: number | null;
  revealed?: boolean;
  onAnswer?: (questionIndex: number, selectedIndex: number) => void;
}

export function QuizQuestion({
  question,
  options,
  correctIndex,
  explanation,
  questionIndex = 0,
  selectedIndex = null,
  revealed = false,
  onAnswer,
}: QuizQuestionProps) {
  const qId = `quiz-q-${questionIndex}`;

  function cardClass(i: number): string {
    if (!revealed) {
      return i === selectedIndex ? styles.cardSelected : styles.card;
    }
    if (i === correctIndex) return styles.cardCorrect;
    if (i === selectedIndex && i !== correctIndex) return styles.cardWrong;
    return styles.cardDimmed;
  }

  return (
    <div className={styles.question}>
      <p id={qId} className={styles.questionText}>{question}</p>
      <div role="group" aria-labelledby={qId} className={styles.options}>
        {options.map((opt, i) => (
          <button
            key={i}
            className={cardClass(i)}
            onClick={() => !revealed && onAnswer?.(questionIndex, i)}
            disabled={revealed}
            aria-pressed={!revealed ? selectedIndex === i : undefined}
          >
            <span className={styles.label}>{LABELS[i]}</span>
            <span className={styles.optionText}>{opt}</span>
            {revealed && i === selectedIndex && i !== correctIndex && (
              <span className={styles.yourAnswer}>(your answer)</span>
            )}
            {revealed && i === correctIndex && (
              <span className={styles.correctMark} aria-hidden="true">+</span>
            )}
          </button>
        ))}
      </div>
      {revealed && (
        <div className={styles.explanation}>
          {selectedIndex === correctIndex ? (
            <strong>Correct!</strong>
          ) : (
            <strong aria-label={`Incorrect. The correct answer was ${LABELS[correctIndex]}.`}>
              The correct answer was {LABELS[correctIndex]}.
            </strong>
          )}{' '}
          {explanation}
        </div>
      )}
    </div>
  );
}
