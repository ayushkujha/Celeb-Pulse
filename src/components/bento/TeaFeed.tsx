'use client';

import { TeaItem } from '@/lib/types';

interface Props { items: TeaItem[]; }

export default function TeaFeed({ items }: Props) {
  return (
    <div className="md:col-span-8 p-7 rounded-[20px] transition-all duration-300 overflow-hidden" 
    style={{
      background: 'linear-gradient(145deg, #150a1a, #0e0a18)',
      border: '1px solid rgba(168,85,247,0.2)',
    }}
    onMouseEnter={e => { e.currentTarget.style.transform = 'translateY(-4px)'; e.currentTarget.style.boxShadow = '0 20px 60px rgba(0,0,0,0.4)'; }}
    onMouseLeave={e => { e.currentTarget.style.transform = 'none'; e.currentTarget.style.boxShadow = 'none'; }}>
      {/* Header */}
      <div className="flex items-center justify-between mb-5">
        <div className="font-[family-name:var(--font-heading)] text-[1.1rem] flex items-center gap-2">
          ☕ The Tea
          <span className="text-[0.65rem] font-extrabold tracking-[0.1em] uppercase bg-[var(--accent-purple)] text-white px-[10px] py-[3px] rounded-full">
            Fresh Brew
          </span>
        </div>
      </div>

      {/* Grid */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
        {items.map(item => (
          <div key={item.id} className="rounded-xl px-[14px] py-[14px] cursor-pointer transition-all duration-200 hover:scale-[1.02]"
            style={{
              background: 'rgba(168,85,247,0.05)',
              border: '1px solid rgba(168,85,247,0.12)',
            }}
            onMouseEnter={e => { e.currentTarget.style.background = 'rgba(168,85,247,0.1)'; e.currentTarget.style.borderColor = 'rgba(168,85,247,0.25)'; }}
            onMouseLeave={e => { e.currentTarget.style.background = 'rgba(168,85,247,0.05)'; e.currentTarget.style.borderColor = 'rgba(168,85,247,0.12)'; }}>
            <div className="text-[0.65rem] text-[var(--muted)] uppercase tracking-[0.1em] mb-[6px]">{item.date_label}</div>
            <div className="text-[0.85rem] leading-[1.4] font-medium">{item.content}</div>
            <div className="flex items-center gap-1 mt-2 text-[0.7rem] text-[var(--accent-purple)] font-bold">
              {item.emoji} {item.share_count}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
