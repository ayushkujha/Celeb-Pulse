'use client';

import { useState, useRef, useEffect } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

// Define the shape of our search result based on what we will fetch
interface SearchResult {
  slug: string;
  name: string;
  emoji: string;
  tags: string[];
  image_url?: string | null;
}

export default function SearchBar() {
  const [query, setQuery] = useState('');
  const [visible, setVisible] = useState(false);
  const [results, setResults] = useState<SearchResult[]>([]);
  const containerRef = useRef<HTMLDivElement>(null);

  // Debounce the search query to avoid spamming the database on every keystroke
  useEffect(() => {
    if (!query.trim()) {
      setResults([]);
      return;
    }

    const timer = setTimeout(async () => {
      const { data, error } = await supabase
        .from('celebrities')
        .select('slug, name, emoji, tags, image_url')
        .ilike('name', `%${query}%`)
        .limit(5);

      if (!error && data) {
        setResults(data);
      }
    }, 300);

    return () => clearTimeout(timer);
  }, [query]);

  // Handle clicks outside the dropdown to close it
  useEffect(() => {
    const handleClick = (e: MouseEvent) => {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setVisible(false);
      }
    };
    document.addEventListener('click', handleClick);
    return () => document.removeEventListener('click', handleClick);
  }, []);

  return (
    <div className="w-full max-w-[640px] relative mb-12" ref={containerRef}
      style={{ animation: 'fadeUp 0.7s 0.3s ease both' }}>
      <input
        type="text"
        className="w-full rounded-2xl px-6 py-[18px] pr-16 text-base outline-none transition-all duration-200 font-[family-name:var(--font-body)]"
        style={{
          background: 'var(--surface2)',
          border: '1.5px solid var(--border)',
          color: 'var(--foreground)',
        }}
        placeholder="Search a celeb, vibe, or era..."
        value={query}
        onChange={e => { setQuery(e.target.value); setVisible(e.target.value.length > 0); }}
        onFocus={() => setVisible(query.length > 0)}
      />
      <div className="absolute right-5 top-1/2 -translate-y-1/2 text-[var(--accent-teal)] text-xl">⌕</div>

      {visible && results.length > 0 && (
        <div className="absolute top-[calc(100%+8px)] left-0 right-0 rounded-[14px] overflow-hidden z-50 shadow-2xl"
          style={{ background: 'var(--surface2)', border: '1.5px solid var(--border)' }}>
          {results.map(c => (
            <Link key={c.slug} href={`/celeb/${c.slug}`}
              className="flex items-center gap-3 px-4 py-3 cursor-pointer transition-colors duration-150 no-underline text-[var(--foreground)] hover:bg-white/[.04]"
              style={{ borderBottom: '1px solid var(--border)' }}
              onClick={() => setVisible(false)}>
              <div className="w-9 h-9 rounded-full flex items-center justify-center text-lg shrink-0 overflow-hidden"
                style={{ background: 'linear-gradient(135deg, rgba(168,85,247,0.2), rgba(0,245,196,0.2))' }}>
                {c.image_url ? <img src={c.image_url} alt="" className="w-full h-full object-cover" /> : (c.emoji || '✨')}
              </div>
              <div>
                <div className="font-semibold text-[0.9rem] text-white">{c.name}</div>
                <div className="text-[0.75rem] text-[var(--muted)] mt-px">
                  {c.tags && c.tags.length > 0 ? c.tags.join(' • ') : 'Celebrity'}
                </div>
              </div>
              <div className="ml-auto text-[0.8rem] text-[var(--muted)]">→</div>
            </Link>
          ))}
        </div>
      )}
    </div>
  );
}
