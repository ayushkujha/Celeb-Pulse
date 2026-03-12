import { DatingEntry } from '@/lib/types';

interface Props { entries: DatingEntry[]; }

export default function DatingTimeline({ entries }: Props) {
  const statusClass = (status: string) => {
    switch (status) {
      case 'past': return { bg: 'rgba(102,102,102,0.2)', color: 'var(--muted)' };
      case 'drama': return { bg: 'rgba(255,45,120,0.15)', color: 'var(--accent-pink)' };
      case 'current': return { bg: 'rgba(0,245,196,0.15)', color: 'var(--accent-teal)' };
      default: return { bg: 'transparent', color: 'var(--muted)' };
    }
  };

  const statusLabel = (status: string) => {
    switch (status) {
      case 'past': return 'Past ✓';
      case 'drama': return '🌶 Drama Era';
      case 'current': return '💚 Current';
      default: return '';
    }
  };

  return (
    <div className="py-20 px-6" style={{ background: 'var(--surface)', borderTop: '1px solid var(--border)', borderBottom: '1px solid var(--border)' }}>
      <div className="max-w-[1280px] mx-auto">
        <div className="text-[0.7rem] font-bold tracking-[0.2em] uppercase text-[var(--accent-pink)] mb-2">💔 The Lore</div>
        <div className="font-[family-name:var(--font-heading)] mb-8"
          style={{ fontSize: 'clamp(2rem, 5vw, 3.5rem)', lineHeight: 1 }}>
          Dating History
        </div>
        <div className="flex gap-0 overflow-x-auto pb-5" style={{ scrollbarWidth: 'thin', scrollbarColor: 'var(--accent-pink) var(--border)' }}>
          {entries.map(entry => (
            <div key={entry.id} className="flex-shrink-0 relative px-5" style={{ width: 220, opacity: entry.status === 'future' ? 0.3 : 1 }}>
              {/* Line */}
              <div className="absolute top-7 left-0 right-0 h-px" style={{ background: 'var(--border)' }} />
              {/* Dot */}
              <div className="absolute top-[22px] left-5 w-3 h-3 rounded-full z-10"
                style={{
                  background: entry.status === 'current' ? 'var(--accent-teal)' : entry.status === 'drama' ? 'var(--accent-pink)' : entry.status === 'future' ? 'var(--muted)' : 'var(--accent-pink)',
                  border: '2px solid var(--bg)',
                  boxShadow: entry.status === 'current' ? '0 0 12px rgba(0,245,196,0.6)' : '0 0 12px rgba(255,45,120,0.5)',
                }} />
              <div className="pt-[52px] text-[0.65rem] font-bold tracking-[0.1em] text-[var(--muted)] uppercase mb-2">{entry.date_range}</div>
              <div className="font-[family-name:var(--font-heading)] text-base mb-1">{entry.partner_name}</div>
              <div className="text-[0.75rem] text-[var(--muted)] leading-[1.4]">{entry.description}</div>
              {entry.status !== 'future' && (
                <span className="inline-block mt-2 text-[0.65rem] font-bold tracking-[0.08em] uppercase px-2 py-[3px] rounded"
                  style={{ background: statusClass(entry.status).bg, color: statusClass(entry.status).color }}>
                  {statusLabel(entry.status)}
                </span>
              )}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
