import { PortfolioItem } from '@/lib/types';

interface Props { items: PortfolioItem[]; }

export default function PortfolioGrid({ items }: Props) {
  return (
    <section id="portfolio" className="py-20 px-6 max-w-[1280px] mx-auto">
      <div className="text-[0.7rem] font-bold tracking-[0.2em] uppercase text-[var(--accent-pink)] mb-2">🎬 Portfolio</div>
      <div className="font-[family-name:var(--font-heading)] leading-none mb-10"
        style={{ fontSize: 'clamp(2rem, 5vw, 3.5rem)' }}>
        Filmography & Projects
      </div>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        {items.map(item => (
          <div key={item.id} className="rounded-2xl overflow-hidden cursor-pointer transition-all duration-300 hover:-translate-y-[6px] hover:shadow-[0_24px_48px_rgba(0,0,0,0.5)]"
            style={{ background: 'var(--surface)', border: '1px solid var(--border)' }}>
            <div className="h-[180px] flex items-center justify-center text-[3rem] relative" style={{ background: item.gradient }}>
              {item.emoji}
              <span className="absolute top-3 right-3 text-[0.6rem] font-extrabold tracking-[0.08em] uppercase px-2 py-[3px] rounded text-[var(--accent-purple)]"
                style={{ background: 'rgba(0,0,0,0.7)', border: '1px solid var(--border)' }}>
                {item.energy_label}
              </span>
            </div>
            <div className="p-[14px]">
              <div className="font-bold text-[0.9rem] mb-1">{item.title}</div>
              <div className="text-[0.75rem] text-[var(--muted)]">{item.year} · {item.type}</div>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}
