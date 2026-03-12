import { getLatestTea } from '@/lib/api';

export default async function NewsTicker() {
  const baseItems = await getLatestTea();
  const items = [...baseItems, ...baseItems]; // duplicate for infinite scroll

  return (
    <div className="w-full overflow-hidden bg-[var(--accent-pink)] py-[10px]">
      <div className="flex gap-0 w-max" style={{ animation: 'ticker 25s linear infinite' }}>
        {items.map((item, i) => (
          <span key={i} className="whitespace-nowrap font-[family-name:var(--font-display)] text-base tracking-[0.1em] text-black px-8">
            {item}
            <span className="ml-8">⚡</span>
          </span>
        ))}
      </div>
    </div>
  );
}
