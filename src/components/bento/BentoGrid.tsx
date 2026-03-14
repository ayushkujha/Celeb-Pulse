'use client';

import { motion } from 'framer-motion';
import { CelebProfile } from '@/lib/types';
import CelebCard from './CelebCard';
import BigThreeCard from './BigThreeCard';
import EraTracker from './EraTracker';
import TeaFeed from './TeaFeed';
import ServeOrFlop from './ServeOrFlop';

interface Props { profile: CelebProfile; }

const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: { staggerChildren: 0.1 }
  }
};

const item = {
  hidden: { opacity: 0, y: 20 },
  show: { opacity: 1, y: 0, transition: { type: 'spring' as const, stiffness: 300, damping: 24 } }
};

export default function BentoGrid({ profile }: Props) {
  return (
    <section id="trending" className="py-20 px-6 max-w-[1280px] mx-auto overflow-hidden">
      <motion.div 
        initial={{ opacity: 0, y: 20 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true, margin: "-50px" }}
        transition={{ duration: 0.6 }}
        className="text-[0.7rem] font-bold tracking-[0.2em] uppercase text-[var(--accent-pink)] mb-2"
      >
        ⚡ Featured Profile
      </motion.div>
      <motion.div 
        initial={{ opacity: 0, y: 20 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true, margin: "-50px" }}
        transition={{ duration: 0.6, delay: 0.1 }}
        className="font-[family-name:var(--font-heading)] leading-none mb-10"
        style={{ fontSize: 'clamp(2rem, 5vw, 3.5rem)' }}
      >
        This Week&apos;s Main Character
      </motion.div>

      <motion.div 
        variants={container}
        initial="hidden"
        whileInView="show"
        viewport={{ once: true, margin: "-50px" }}
        className="flex flex-col md:grid md:grid-cols-12 gap-4 md:auto-rows-auto"
      >
        <motion.div variants={item} className="col-span-12 md:col-span-8 md:row-span-2 flex">
          <CelebCard celeb={profile.celeb} era={profile.currentEra} />
        </motion.div>
        
        <motion.div variants={item} className="col-span-12 md:col-span-4 flex">
          <BigThreeCard celeb={profile.celeb} />
        </motion.div>
        
        <motion.div variants={item} className="col-span-12 md:col-span-4 flex">
          <EraTracker era={profile.currentEra} />
        </motion.div>
        
        <motion.div variants={item} className="col-span-12 md:col-span-8 flex">
          <TeaFeed items={profile.teaItems} />
        </motion.div>
        
        <motion.div variants={item} className="col-span-12 md:col-span-4 flex">
          <ServeOrFlop poll={profile.poll} />
        </motion.div>
      </motion.div>
    </section>
  );
}
