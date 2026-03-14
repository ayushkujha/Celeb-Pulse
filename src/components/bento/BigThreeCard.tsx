'use client';

import { Celebrity } from '@/lib/types';

interface Props { celeb: Celebrity; }

export default function BigThreeCard({ celeb }: Props) {
  const signs = [
    { label: 'Sun', value: celeb.sun_sign, emoji: '☀️' },
    { label: 'Moon', value: celeb.moon_sign, emoji: '🌙' },
    { label: 'Rising', value: celeb.rising_sign, emoji: '⭐' },
  ];

  return (
    <div className="w-full p-7 rounded-[20px] transition-all duration-300"
    style={{
      background: 'linear-gradient(145deg, #0a1a12, #0f1520)',
      border: '1px solid rgba(0,245,196,0.2)',
    }}
    onMouseEnter={e => { e.currentTarget.style.transform = 'translateY(-4px)'; e.currentTarget.style.boxShadow = '0 20px 60px rgba(0,0,0,0.4)'; }}
    onMouseLeave={e => { e.currentTarget.style.transform = 'none'; e.currentTarget.style.boxShadow = 'none'; }}>
      <div className="font-[family-name:var(--font-heading)] text-[0.8rem] tracking-[0.1em] uppercase text-[var(--accent-teal)] mb-5 flex items-center gap-2">
        ☽ The Big Three
      </div>
      <div className="flex flex-col gap-3">
        {signs.map(s => (
          <div key={s.label} className="flex items-center justify-between rounded-[10px] px-[14px] py-[10px]"
            style={{ background: 'rgba(0,245,196,0.05)', border: '1px solid rgba(0,245,196,0.1)' }}>
            <span className="text-[0.7rem] text-[var(--muted)] uppercase tracking-[0.1em]">{s.label}</span>
            <span className="font-[family-name:var(--font-heading)] text-base">{s.value}</span>
            <span className="text-xl">{s.emoji}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
