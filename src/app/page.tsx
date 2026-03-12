import Hero from '@/components/hero/Hero';
import NewsTicker from '@/components/ticker/NewsTicker';
import BentoGrid from '@/components/bento/BentoGrid';
import DatingTimeline from '@/components/timeline/DatingTimeline';
import PortfolioGrid from '@/components/portfolio/PortfolioGrid';
import ShopTheLook from '@/components/shop/ShopTheLook';
import EthicalScorecard from '@/components/scorecard/EthicalScorecard';
import { getCelebrityProfile } from '@/lib/api';
import { notFound } from 'next/navigation';

export default async function Home() {
  const featuredSlug = 'sabrina-carpenter';
  const profile = await getCelebrityProfile(featuredSlug);

  if (!profile) notFound();

  return (
    <main>
      <Hero />
      <NewsTicker />
      <BentoGrid profile={profile} />
      {profile.datingHistory?.length > 0 && <DatingTimeline entries={profile.datingHistory} />}
      {profile.portfolio?.length > 0 && <PortfolioGrid items={profile.portfolio} />}
      {profile.shopItems?.length > 0 && <ShopTheLook items={profile.shopItems} />}
      {profile.scorecard?.length > 0 && <EthicalScorecard items={profile.scorecard} />}
    </main>
  );
}
