import { supabase } from '@/lib/supabase';
import { CelebProfile, CelebStats } from '@/lib/types';
import { notFound } from 'next/navigation';

export async function getCelebrityProfile(slug: string): Promise<CelebProfile | null> {
  // 1. Fetch main celebrity data
  const { data: celeb, error: celebError } = await supabase
    .from('celebrities')
    .select('*')
    .eq('slug', slug)
    .single();

  if (celebError || !celeb) {
    if (celebError?.code !== 'PGRST116') {
      console.error('Error fetching celebrity:', celebError);
    }
    return null;
  }

  // 2. Fetch all related data in parallel
  const [
    { data: eras },
    { data: tea },
    { data: dating },
    { data: portfolio },
    { data: polls },
    { data: scorecard },
    { data: shopItems }
  ] = await Promise.all([
    supabase.from('eras').select('*').eq('celebrity_id', celeb.id).order('created_at', { ascending: false }),
    supabase.from('tea_items').select('*').eq('celebrity_id', celeb.id).order('created_at', { ascending: false }),
    supabase.from('dating_history').select('*').eq('celebrity_id', celeb.id).order('sort_order', { ascending: true }),
    supabase.from('portfolio').select('*').eq('celebrity_id', celeb.id).order('sort_order', { ascending: true }),
    supabase.from('polls').select('*').eq('celebrity_id', celeb.id).eq('is_active', true).order('created_at', { ascending: false }),
    supabase.from('scorecard').select('*').eq('celebrity_id', celeb.id).order('sort_order', { ascending: true }),
    supabase.from('shop_items').select('*').eq('celebrity_id', celeb.id).order('sort_order', { ascending: true })
  ]);

  const currentEra = eras?.find(e => e.is_current) || eras?.[0] || { name: 'Unknown', progress: 0 };
  const pastEras = eras?.filter(e => !e.is_current) || [];
  
  // Transform to the CelebrityProfile interface
  const stats: CelebStats = {
    sunMain: celeb.sun_sign || 'Unknown',
    moon: celeb.moon_sign || 'Unknown',
    rising: celeb.rising_sign || 'Unknown',
    activeScandals: tea?.length || 0
  };

  return {
    celeb,
    stats,
    currentEra,
    pastEras,
    teaItems: tea || [],
    datingHistory: dating || [],
    portfolio: portfolio || [],
    poll: polls?.[0] || null,
    scorecard: scorecard || [],
    shopItems: shopItems || []
  };
}

export async function getAllCelebritySlugs() {
  const { data } = await supabase.from('celebrities').select('slug');
  return data?.map(c => c.slug) || [];
}

export async function getLatestTea() {
  const { data } = await supabase
    .from('tea_items')
    .select('content, celebrities(name)')
    .order('created_at', { ascending: false })
    .limit(8);

  // Fallback if no db data yet
  if (!data || data.length === 0) {
    return [
      "ZENDAYA BREAKS THE INTERNET WITH NEW RED CARPET LOOK",
      "SABRINA CARPENTER ANNOUNCES SURPRISE ALBUM DROP",
      "TIMOTHÉE CHALAMET SPOTTED FILMING IN PARIS",
      "BILLIE EILISH TEASES NEW TRACK ON IG LIVE"
    ];
  }

  // Format: "Zendaya: Just dropped the hardest Challengers promo look yet..."
  return data.map(item => {
    // @ts-expect-error - Supabase join typing
    const celebName = item.celebrities?.name || 'Rumor';
    return `${celebName.toUpperCase()}: ${item.content}`;
  });
}
