import Link from 'next/link';
import { supabase } from '@/lib/supabase';

export default async function TrendingTags() {
  const { data: trendingCelebs } = await supabase
    .from('celebrities')
    .select('slug, name, emoji')
    .order('vibe_score', { ascending: false })
    .limit(4);

  const celebs = trendingCelebs || [];

  return (
    <div className="flex gap-[10px] flex-wrap justify-center"
      style={{ animation: 'fadeUp 0.7s 0.35s ease both' }}>
      {celebs.map(c => (
        <Link key={c.slug} href={`/celeb/${c.slug}`}
          className="text-[0.75rem] font-semibold tracking-[0.05em] uppercase px-[14px] py-[6px] rounded-full cursor-pointer transition-all duration-200 no-underline hover:border-[var(--accent-pink)] hover:text-[var(--accent-pink)]"
          style={{
            background: 'var(--surface2)',
            border: '1px solid var(--border)',
            color: 'var(--muted)',
          }}>
          {c.emoji || '✨'} {c.name}
        </Link>
      ))}
    </div>
  );
}
