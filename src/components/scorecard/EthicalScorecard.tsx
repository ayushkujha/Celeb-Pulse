'use client';

import { ScorecardItem } from '@/lib/types';

interface Props { items: ScorecardItem[]; }

export default function EthicalScorecard({ items }: Props) {
  return (
    <section id="scorecard" className="py-20 px-6 max-w-[1280px] mx-auto">
      <div className="text-[0.7rem] font-bold tracking-[0.2em] uppercase text-[var(--accent-pink)] mb-2">💚 Social Impact</div>
      <div className="font-[family-name:var(--font-heading)] leading-none mb-10"
        style={{ fontSize: 'clamp(2rem, 5vw, 3.5rem)' }}>
        Ethical Scorecard
      </div>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {items.map(item => (
          <div key={item.id} className="rounded-2xl p-6 transition-all duration-200 hover:border-[var(--accent-teal)]"
            style={{ background: 'var(--surface)', border: '1px solid var(--border)' }}
            onMouseEnter={e => { e.currentTarget.style.borderColor = 'var(--accent-teal)'; e.currentTarget.style.background = 'rgba(0,245,196,0.03)'; }}
            onMouseLeave={e => { e.currentTarget.style.borderColor = 'var(--border)'; e.currentTarget.style.background = 'var(--surface)'; }}>
            <div className="text-[2rem] mb-3">{item.emoji}</div>
            <div className="text-[0.7rem] font-bold tracking-[0.12em] uppercase text-[var(--muted)] mb-[6px]">{item.category}</div>
            <div className="text-[0.9rem] leading-[1.5]">{item.description}</div>
            <div className="mt-[14px] h-[3px] rounded overflow-hidden" style={{ background: 'var(--border)' }}>
              <div className="h-full rounded" style={{
                width: `${item.score}%`,
                background: 'linear-gradient(90deg, var(--accent-teal), var(--accent-purple))',
              }} />
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}
