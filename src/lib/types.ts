export interface Celebrity {
  id: string;
  slug: string;
  name: string;
  birth_year?: number;
  tags: string[];
  vibe_score: number;
  image_url?: string;
  instagram_url?: string;
  twitter_url?: string;
  sun_sign: string;
  moon_sign: string;
  rising_sign: string;
  emoji: string;
  gradient?: string;
}

export interface Era {
  id: string;
  celebrity_id: string;
  name: string;
  description: string;
  progress: number;
  is_current: boolean;
}

export interface TeaItem {
  id: string;
  celebrity_id: string;
  date_label: string;
  content: string;
  share_count: string;
  emoji: string;
}

export interface DatingEntry {
  id: string;
  celebrity_id: string;
  partner_name: string;
  date_range: string;
  description: string;
  status: 'past' | 'drama' | 'current' | 'future';
  sort_order: number;
}

export interface PortfolioItem {
  id: string;
  celebrity_id: string;
  title: string;
  year: string;
  type: string;
  energy_label: string;
  emoji: string;
  gradient: string;
}

export interface Poll {
  id: string;
  celebrity_id: string;
  event_name: string;
  serve_count: number;
  flop_count: number;
  is_active: boolean;
}

export interface ScorecardItem {
  id: string;
  celebrity_id: string;
  category: string;
  emoji: string;
  description: string;
  score: number;
}

export interface ShopItem {
  id: string;
  celebrity_id: string;
  name: string;
  price: string;
  emoji: string;
  gradient: string;
  image_url?: string;
  product_url?: string;
}

export interface CelebStats {
  sunMain: string;
  moon: string;
  rising: string;
  activeScandals: number;
}

export interface CelebProfile {
  celeb: Celebrity;
  stats?: CelebStats;
  currentEra: Era;
  pastEras?: Era[];
  teaItems: TeaItem[];
  datingHistory: DatingEntry[];
  portfolio: PortfolioItem[];
  poll: Poll | null;
  scorecard: ScorecardItem[];
  shopItems: ShopItem[];
}
