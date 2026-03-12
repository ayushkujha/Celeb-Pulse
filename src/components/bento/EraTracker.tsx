'use client';

import { Era } from '@/lib/types';

interface Props { era: Era; }

export default function EraTracker({ era }: Props) {
  return (
    <div className="md:col-span-4 p-7 rounded-[20px] transition-all duration-300"
    style={{
      background: 'linear-gradient(145deg, #1a1408, #14100a)',
      border: '1px solid rgba(255,214,0,0.2)',
    }}
    onMouseEnter={e => { e.currentTarget.style.transform = 'translateY(-4px)'; e.currentTarget.style.boxShadow = '0 20px 60px rgba(0,0,0,0.4)'; }}
    onMouseLeave={e => { e.currentTarget.style.transform = 'none'; e.currentTarget.style.boxShadow = 'none'; }}>
      <div className="text-[0.7rem] font-bold tracking-[0.15em] uppercase text-[var(--accent-gold)] mb-4">📅 Current Era</div>
      <div className="font-[family-name:var(--font-display)] text-[2.5rem] text-[var(--accent-gold)] mb-2">{era.name}</div>
      <div className="text-[0.85rem] text-[var(--muted)] leading-[1.5] mb-5">{era.description}</div>
      <div className="h-1 rounded-sm overflow-hidden" style={{ background: 'var(--border)' }}>
        <div className="h-full rounded-sm" style={{
          width: `${era.progress}%`,
          background: 'linear-gradient(90deg, var(--accent-gold), var(--accent-pink))',
          animation: 'progressLoad 1.5s ease both 0.5s',
        }} />
      </div>
    </div>
  );
}
