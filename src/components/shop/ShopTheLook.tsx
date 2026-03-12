import { ShopItem } from '@/lib/types';

interface Props { items: ShopItem[]; }

export default function ShopTheLook({ items }: Props) {
  return (
    <section id="shop" className="pt-0 pb-20 px-6 max-w-[1280px] mx-auto">
      <div className="text-[0.7rem] font-bold tracking-[0.2em] uppercase text-[var(--accent-pink)] mb-2">🛍️ Aesthetic & Style</div>
      <div className="font-[family-name:var(--font-heading)] leading-none mb-10"
        style={{ fontSize: 'clamp(2rem, 5vw, 3.5rem)' }}>
        Shop The Look
      </div>
      <div className="flex gap-4 overflow-x-auto pb-4" style={{ scrollbarWidth: 'none' }}>
        {items.map(item => (
          <div key={item.id} className="flex-shrink-0 rounded-2xl overflow-hidden cursor-pointer transition-transform duration-200 hover:scale-[1.04]"
            style={{ width: 200, background: 'var(--surface)', border: '1px solid var(--border)' }}>
            <div className="h-[160px] flex items-center justify-center text-[2.5rem]" style={{ background: item.gradient }}>
              {item.emoji}
            </div>
            <div className="px-[14px] py-3">
              <div className="text-[0.85rem] font-semibold mb-[2px]">{item.name}</div>
              <div className="text-[0.8rem] text-[var(--accent-teal)] font-bold">{item.price}</div>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}
