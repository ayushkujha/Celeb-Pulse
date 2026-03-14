'use client';

import Link from 'next/link';
import { Celebrity, Era } from '@/lib/types';

interface Props {
  celeb: Celebrity;
  era: Era;
}

export default function CelebCard({ celeb, era }: Props) {
  return (
    <Link href={`/celeb/${celeb.slug}`} className="relative w-full flex flex-col justify-end overflow-hidden no-underline text-[var(--foreground)]"
      style={{
        background: 'linear-gradient(145deg, #1a0a14, #120a1c)',
        border: '1px solid rgba(255,45,120,0.2)',
        borderRadius: '20px',
        minHeight: '420px',
        display: 'flex',
        flexDirection: 'column',
        justifyContent: 'flex-end',
        overflow: 'hidden',
        position: 'relative',
        transition: 'transform 0.3s ease, box-shadow 0.3s ease',
      }}
      onMouseEnter={e => { e.currentTarget.style.transform = 'translateY(-4px)'; e.currentTarget.style.boxShadow = '0 20px 60px rgba(0,0,0,0.4)'; }}
      onMouseLeave={e => { e.currentTarget.style.transform = 'none'; e.currentTarget.style.boxShadow = 'none'; }}>

      {/* Background: profile image or gradient + emoji */}
      <div className="absolute inset-0 flex items-center justify-center"
        style={{ background: 'linear-gradient(135deg, rgba(168,85,247,0.3) 0%, rgba(255,45,120,0.2) 40%, rgba(0,0,0,0.8) 100%)' }}>
        {celeb.image_url ? (
          <img src={celeb.image_url} alt={celeb.name} className="absolute inset-0 w-full h-full object-cover opacity-90" />
        ) : (
          <div className="flex items-center justify-center text-[4rem] opacity-60"
            style={{ width: 200, height: 300, background: 'linear-gradient(to bottom, rgba(255,255,255,0.06), rgba(255,255,255,0.02))', borderRadius: '120px 120px 20px 20px', border: '1px solid rgba(255,255,255,0.08)' }}>
            {celeb.emoji}
          </div>
        )}
      </div>

      {/* Info overlay */}
      <div className="relative z-10 p-7" style={{ background: 'linear-gradient(to top, rgba(8,8,8,0.95) 0%, transparent 100%)' }}>
        <div className="inline-block bg-[var(--accent-gold)] text-black text-[0.65rem] font-extrabold tracking-[0.12em] uppercase px-3 py-1 rounded-full mb-3">
          ✨ {era.name} Era
        </div>
        <div className="font-[family-name:var(--font-display)] text-[3.5rem] leading-[0.95] mb-2">
          {celeb.name.split(' ').map((word, i) => <span key={i}>{word}<br /></span>)}
        </div>
        <div className="flex gap-3 flex-wrap items-center">
          {(celeb.tags || []).map(tag => (
            <span key={tag} className="text-[0.75rem] text-[var(--muted)] border border-[var(--border)] px-[10px] py-1 rounded-md">{tag}</span>
          ))}
          <span className="font-[family-name:var(--font-heading)] text-2xl text-[var(--accent-teal)] ml-auto">
            {celeb.vibe_score} ✦
          </span>
        </div>
      </div>
    </Link>
  );
}
