'use client';

import { useState } from 'react';
import { Poll } from '@/lib/types';
import { castPollVote } from '@/app/actions';

interface Props { poll: Poll | null; }

export default function ServeOrFlop({ poll }: Props) {
  const [voted, setVoted] = useState(false);
  
  // Guard clause for early return if no active poll exists
  if (!poll) return null;

  const [serve, setServe] = useState(poll.serve_count);
  const [flop, setFlop] = useState(poll.flop_count);

  const total = serve + flop;
  // Prevent NaN if total is 0
  const servePct = total === 0 ? 50 : Math.round((serve / total) * 100);
  const flopPct = 100 - servePct;
  const verdict = servePct >= 50 ? '🔥 SERVE' : '💀 FLOP';

  const handleVote = async (type: 'serve' | 'flop') => {
    // Optimistic UI update
    if (type === 'serve') setServe(s => s + 1);
    else setFlop(f => f + 1);
    
    setVoted(true);
    
    // Call server action to update DB
    await castPollVote(poll.id, type);
  };

  return (
    <div className="text-center md:col-span-4 p-7 rounded-[20px] transition-all duration-300 overflow-hidden" 
    style={{
      background: 'linear-gradient(145deg, #14080f, #180d0d)',
      border: '1px solid rgba(255,45,120,0.2)',
    }}
    onMouseEnter={e => { e.currentTarget.style.transform = 'translateY(-4px)'; e.currentTarget.style.boxShadow = '0 20px 60px rgba(0,0,0,0.4)'; }}
    onMouseLeave={e => { e.currentTarget.style.transform = 'none'; e.currentTarget.style.boxShadow = 'none'; }}>
      <div className="font-[family-name:var(--font-display)] text-[1.8rem] mb-[6px] text-[var(--accent-pink)]">SERVE OR FLOP?</div>
      <div className="text-[0.8rem] text-[var(--muted)] mb-5">{poll.event_name}</div>
      <div className="w-full h-[140px] rounded-xl flex items-center justify-center text-[3rem] mb-5"
        style={{ background: 'linear-gradient(135deg, rgba(255,45,120,0.2), rgba(168,85,247,0.2))', border: '1px solid rgba(255,45,120,0.15)' }}>
        👗✨
      </div>

      {!voted ? (
        <div className="grid grid-cols-2 gap-[10px]">
          <button onClick={() => handleVote('serve')}
            className="py-3 rounded-[10px] font-[family-name:var(--font-heading)] text-base cursor-pointer border-none bg-[var(--accent-teal)] text-black transition-all duration-200 hover:scale-[1.03] hover:shadow-[0_0_20px_rgba(0,245,196,0.4)]">
            SERVE 🔥
          </button>
          <button onClick={() => handleVote('flop')}
            className="py-3 rounded-[10px] font-[family-name:var(--font-heading)] text-base cursor-pointer bg-transparent text-[var(--accent-pink)] transition-all duration-200 hover:scale-[1.03]"
            style={{ border: '1.5px solid var(--accent-pink)' }}>
            FLOP 💀
          </button>
        </div>
      ) : (
        <div className="text-center py-2">
          <div className="text-[0.8rem] text-[var(--muted)] mb-2">Community Verdict</div>
          <div className="flex gap-[10px] my-4">
            <div className="flex-1 text-center">
              <div className="h-2 rounded mb-1" style={{ background: 'var(--accent-teal)', width: `${servePct}%`, marginLeft: 'auto', marginRight: 'auto' }} />
              <div className="font-[family-name:var(--font-heading)] text-xl text-[var(--accent-teal)]">{servePct}%</div>
              <div className="text-[0.65rem] text-[var(--muted)] uppercase tracking-[0.1em]">Serve</div>
            </div>
            <div className="flex-1 text-center">
              <div className="h-2 rounded mb-1" style={{ background: 'var(--accent-pink)', width: `${flopPct}%`, marginLeft: 'auto', marginRight: 'auto' }} />
              <div className="font-[family-name:var(--font-heading)] text-xl text-[var(--accent-pink)]">{flopPct}%</div>
              <div className="text-[0.65rem] text-[var(--muted)] uppercase tracking-[0.1em]">Flop</div>
            </div>
          </div>
          <div className="font-[family-name:var(--font-heading)] text-[1.4rem] text-[var(--accent-teal)]">{verdict}</div>
          <div className="text-[0.75rem] text-[var(--muted)] mt-1">{total.toLocaleString()} votes</div>
        </div>
      )}
    </div>
  );
}
