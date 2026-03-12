import { CelebProfile } from '@/lib/types';
import CelebCard from './CelebCard';
import BigThreeCard from './BigThreeCard';
import EraTracker from './EraTracker';
import TeaFeed from './TeaFeed';
import ServeOrFlop from './ServeOrFlop';

interface Props { profile: CelebProfile; }

export default function BentoGrid({ profile }: Props) {
  return (
    <section id="trending" className="py-20 px-6 max-w-[1280px] mx-auto">
      <div className="text-[0.7rem] font-bold tracking-[0.2em] uppercase text-[var(--accent-pink)] mb-2">
        ⚡ Featured Profile
      </div>
      <div className="font-[family-name:var(--font-heading)] leading-none mb-10"
        style={{ fontSize: 'clamp(2rem, 5vw, 3.5rem)' }}>
        This Week&apos;s Main Character
      </div>

      <div className="flex flex-col md:grid md:grid-cols-12 gap-4 md:auto-rows-auto">
        <CelebCard celeb={profile.celeb} era={profile.currentEra} />
        <BigThreeCard celeb={profile.celeb} />
        <EraTracker era={profile.currentEra} />
        <TeaFeed items={profile.teaItems} />
        <ServeOrFlop poll={profile.poll} />
      </div>
    </section>
  );
}
