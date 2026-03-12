import { notFound } from 'next/navigation';
import { getCelebrityProfile, getAllCelebritySlugs } from '@/lib/api';
import BentoGrid from '@/components/bento/BentoGrid';
import DatingTimeline from '@/components/timeline/DatingTimeline';
import PortfolioGrid from '@/components/portfolio/PortfolioGrid';
import ShopTheLook from '@/components/shop/ShopTheLook';
import EthicalScorecard from '@/components/scorecard/EthicalScorecard';
import type { Metadata } from 'next';

interface PageProps {
  params: Promise<{ slug: string }>;
}

export async function generateStaticParams() {
  const slugs = await getAllCelebritySlugs();
  return slugs.map(slug => ({ slug }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug } = await params;
  const profile = await getCelebrityProfile(slug);
  
  if (!profile) return { title: 'Celebrity Not Found | CelebPulse' };

  return {
    title: `${profile.celeb.name} | CelebPulse ⚡`,
    description: `${profile.celeb.name} — ${profile.currentEra.name} Era. Lore, aesthetics, and the tea. Vibe score: ${profile.celeb.vibe_score}`,
  };
}

export default async function CelebPage({ params }: PageProps) {
  const { slug } = await params;
  
  // Fetch real data from Supabase
  const profile = await getCelebrityProfile(slug);

  if (!profile) notFound();

  return (
    <main className="pt-20">
      {/* Celeb Hero Banner */}
      <div className="relative py-16 px-6 text-center overflow-hidden">
        <div className="absolute inset-0" style={{
          background: `
            radial-gradient(ellipse 80% 50% at 50% 40%, rgba(168,85,247,0.15) 0%, transparent 60%),
            radial-gradient(ellipse 60% 40% at 30% 60%, rgba(255,45,120,0.12) 0%, transparent 60%),
            radial-gradient(ellipse 40% 60% at 70% 20%, rgba(0,245,196,0.08) 0%, transparent 60%)
          `
        }} />
        <div className="relative z-10">
          <div className="text-6xl mb-4">{profile.celeb.emoji || '✨'}</div>
          <h1 className="font-[family-name:var(--font-display)] leading-[0.9] mb-3"
            style={{ fontSize: 'clamp(3rem, 10vw, 8rem)' }}>
            {profile.celeb.name.toUpperCase()}
          </h1>
          <div className="flex gap-3 justify-center flex-wrap mb-4">
            {profile.celeb.tags?.map((tag: string) => (
              <span key={tag} className="text-[0.75rem] text-[var(--muted)] border border-[var(--border)] px-3 py-1 rounded-md">{tag}</span>
            ))}
          </div>
          <div className="font-[family-name:var(--font-heading)] text-3xl text-[var(--accent-teal)]">
            {profile.celeb.vibe_score} ✦
          </div>
        </div>
      </div>

      <BentoGrid profile={profile} />
      {profile.datingHistory?.length > 0 && <DatingTimeline entries={profile.datingHistory} />}
      {profile.portfolio?.length > 0 && <PortfolioGrid items={profile.portfolio} />}
      {profile.shopItems?.length > 0 && <ShopTheLook items={profile.shopItems} />}
      {profile.scorecard?.length > 0 && <EthicalScorecard items={profile.scorecard} />}
    </main>
  );
}
