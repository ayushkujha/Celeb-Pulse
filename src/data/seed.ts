import { CelebProfile, Celebrity, ShopItem } from '@/lib/types';

// Shop items (shared across celebs for now)
export const shopItems: ShopItem[] = [
  { id: '1', name: 'Vintage Lace Corset', price: '$128', emoji: '👗', gradient: 'linear-gradient(135deg, #1a0e28, #280e28)' },
  { id: '2', name: 'Platform Mary Janes', price: '$89', emoji: '👠', gradient: 'linear-gradient(135deg, #0e1a0e, #0e2818)' },
  { id: '3', name: 'Gold Stacking Rings', price: '$45', emoji: '💍', gradient: 'linear-gradient(135deg, #281808, #201408)' },
  { id: '4', name: 'Cat-Eye Sunglasses', price: '$62', emoji: '🕶️', gradient: 'linear-gradient(135deg, #0e0e28, #181028)' },
  { id: '5', name: 'Mini Rhinestone Bag', price: '$74', emoji: '👜', gradient: 'linear-gradient(135deg, #281414, #280e20)' },
];

// Full celebrity profiles
export const celebProfiles: Record<string, CelebProfile> = {
  'sabrina-carpenter': {
    celeb: {
      id: '1',
      slug: 'sabrina-carpenter',
      name: 'Sabrina Carpenter',
      birth_year: 1999,
      tags: ['Singer', 'Actress'],
      vibe_score: 9.4,
      sun_sign: 'Virgo ♍',
      moon_sign: 'Taurus ♉',
      rising_sign: 'Libra ♎',
      emoji: '🎤',
      gradient: 'linear-gradient(135deg, #ff6b9d, #c44569)',
    },
    currentEra: {
      id: '1',
      celebrity_id: '1',
      name: 'ESPRESSO',
      description: 'Vintage-glam, coquette aesthetics. Short blonde hair, old Hollywood references, and unhinged confidence.',
      progress: 68,
      is_current: true,
    },
    teaItems: [
      { id: '1', celebrity_id: '1', date_label: 'Mar 2026', content: 'Dropped "Espresso Pt. II" with zero warning. Stans lost their entire minds.', share_count: '2.1M shares', emoji: '🔥' },
      { id: '2', celebrity_id: '1', date_label: 'Feb 2026', content: 'Her SNL cold open became the most-rewatched clip of the year in 48hrs.', share_count: '890K shares', emoji: '⚡' },
      { id: '3', celebrity_id: '1', date_label: 'Jan 2026', content: 'Outfits at Grammys sparked 47K TikTok recreations overnight. Iconic.', share_count: '1.4M shares', emoji: '💫' },
    ],
    datingHistory: [
      { id: '1', celebrity_id: '1', partner_name: 'Bradley Steven Perry', date_range: '2016 – 2018', description: 'Disney Channel co-stars. Very cute, very low-key.', status: 'past', sort_order: 1 },
      { id: '2', celebrity_id: '1', partner_name: 'Griffin Gluck', date_range: '2019 – 2021', description: 'Met on set. Kept it mostly private.', status: 'past', sort_order: 2 },
      { id: '3', celebrity_id: '1', partner_name: 'Joshua Bassett', date_range: '2021 – 2022', description: 'The one that launched a thousand Olivia Rodrigo songs. The Drama™.', status: 'drama', sort_order: 3 },
      { id: '4', celebrity_id: '1', partner_name: 'Shawn Mendes', date_range: '2022 – 2023', description: 'Short-lived but high-profile. Paps had a field day.', status: 'past', sort_order: 4 },
      { id: '5', celebrity_id: '1', partner_name: 'Barry Keoghan', date_range: '2024 – Now', description: 'The internet\'s favorite couple. "Please Please Please" coded relationship.', status: 'current', sort_order: 5 },
      { id: '6', celebrity_id: '1', partner_name: 'Next Chapter', date_range: '???', description: 'The lore continues...', status: 'future', sort_order: 6 },
    ],
    portfolio: [
      { id: '1', celebrity_id: '1', title: 'Girl Meets World', year: '2014–2017', type: 'TV Series', energy_label: 'Chaotic Good', emoji: '🎬', gradient: 'linear-gradient(135deg, #1a0e2a, #2d1040)' },
      { id: '2', celebrity_id: '1', title: 'emails i can\'t send', year: '2022', type: 'Album', energy_label: 'Main Character', emoji: '🎵', gradient: 'linear-gradient(135deg, #0a1a14, #142d20)' },
      { id: '3', celebrity_id: '1', title: 'Short n\' Sweet', year: '2024', type: 'Album', energy_label: 'Chaotic Neutral', emoji: '☕', gradient: 'linear-gradient(135deg, #1a1208, #2d2014)' },
      { id: '4', celebrity_id: '1', title: 'Anyone But You', year: '2023', type: 'Film', energy_label: 'Lawful Evil', emoji: '🕵️', gradient: 'linear-gradient(135deg, #120a1a, #1e1028)' },
    ],
    poll: {
      id: '1',
      celebrity_id: '1',
      event_name: 'Oscars 2026 Red Carpet',
      serve_count: 11083,
      flop_count: 3126,
      is_active: true,
    },
    scorecard: [
      { id: '1', celebrity_id: '1', category: 'Environmental', emoji: '🌍', description: 'Partnered with REVERB on sustainable touring. Carbon neutral Espresso Tour confirmed.', score: 88 },
      { id: '2', celebrity_id: '1', category: 'LGBTQ+ Advocacy', emoji: '🏳️‍🌈', description: 'Vocal ally. Donated proceeds from two singles to The Trevor Project. Consistent.', score: 95 },
      { id: '3', celebrity_id: '1', category: 'Youth Education', emoji: '📚', description: '$500K donated to arts education programs in underfunded US public schools.', score: 79 },
      { id: '4', celebrity_id: '1', category: 'Mental Health', emoji: '🤝', description: 'Partnered with BetterHelp for fan mental wellness initiatives. Speaks openly about therapy.', score: 82 },
      { id: '5', celebrity_id: '1', category: 'Industry Ethics', emoji: '💼', description: 'Advocates for fair streaming royalties. Signed open letter with 200+ artists to Spotify.', score: 71 },
      { id: '6', celebrity_id: '1', category: 'Body Positivity', emoji: '🌸', description: 'Refuses brand deals with diet culture products. Raw, unfiltered posts about self-image.', score: 90 },
    ],
    shopItems,
  },

  'zendaya': {
    celeb: {
      id: '2',
      slug: 'zendaya',
      name: 'Zendaya',
      birth_year: 1996,
      tags: ['Actress', 'Fashion Icon'],
      vibe_score: 9.8,
      sun_sign: 'Virgo ♍',
      moon_sign: 'Aquarius ♒',
      rising_sign: 'Aquarius ♒',
      emoji: '👑',
      gradient: 'linear-gradient(135deg, #00b894, #00cec9)',
    },
    currentEra: {
      id: '2',
      celebrity_id: '2',
      name: 'FASHION GODDESS',
      description: 'Met Gala domination, Valentino muse, every red carpet is her runway. Effortlessly iconic.',
      progress: 85,
      is_current: true,
    },
    teaItems: [
      { id: '4', celebrity_id: '2', date_label: 'Mar 2026', content: 'Her Dune: Part Three premiere look broke Instagram. Most liked photo by an actress ever.', share_count: '4.2M shares', emoji: '🔥' },
      { id: '5', celebrity_id: '2', date_label: 'Feb 2026', content: 'Launched her own fashion label "Daya" with zero fast fashion. Everything sustainable.', share_count: '1.8M shares', emoji: '⚡' },
      { id: '6', celebrity_id: '2', date_label: 'Jan 2026', content: 'Won Golden Globe for Best Actress. Speech went viral for radical vulnerability.', share_count: '3.1M shares', emoji: '💫' },
    ],
    datingHistory: [
      { id: '7', celebrity_id: '2', partner_name: 'Jacob Elordi', date_range: '2019 – 2020', description: 'Euphoria chemistry that bled into real life. Brief but memorable.', status: 'past', sort_order: 1 },
      { id: '8', celebrity_id: '2', partner_name: 'Tom Holland', date_range: '2021 – Now', description: 'Spider-Man to real life. The internet\'s most protected couple. Endgame energy.', status: 'current', sort_order: 2 },
      { id: '9', celebrity_id: '2', partner_name: 'Next Chapter', date_range: '???', description: 'The lore continues...', status: 'future', sort_order: 3 },
    ],
    portfolio: [
      { id: '5', celebrity_id: '2', title: 'Euphoria', year: '2019–2024', type: 'TV Series', energy_label: 'Chaotic Good', emoji: '🎭', gradient: 'linear-gradient(135deg, #1a0e2a, #2d1040)' },
      { id: '6', celebrity_id: '2', title: 'Dune: Part Two', year: '2024', type: 'Film', energy_label: 'Lawful Neutral', emoji: '🏜️', gradient: 'linear-gradient(135deg, #0a1a14, #142d20)' },
      { id: '7', celebrity_id: '2', title: 'Challengers', year: '2024', type: 'Film', energy_label: 'Chaotic Neutral', emoji: '🎾', gradient: 'linear-gradient(135deg, #1a1208, #2d2014)' },
      { id: '8', celebrity_id: '2', title: 'The Greatest Showman', year: '2017', type: 'Film', energy_label: 'Lawful Good', emoji: '🎪', gradient: 'linear-gradient(135deg, #120a1a, #1e1028)' },
    ],
    poll: {
      id: '2',
      celebrity_id: '2',
      event_name: 'Met Gala 2026 Look',
      serve_count: 18420,
      flop_count: 890,
      is_active: true,
    },
    scorecard: [
      { id: '7', celebrity_id: '2', category: 'Environmental', emoji: '🌍', description: 'Sustainable fashion label. Refuses fast fashion collabs. Green carpet pioneer.', score: 94 },
      { id: '8', celebrity_id: '2', category: 'LGBTQ+ Advocacy', emoji: '🏳️‍🌈', description: 'Euphoria role broke barriers. Consistent ally at events and through donations.', score: 92 },
      { id: '9', celebrity_id: '2', category: 'Youth Education', emoji: '📚', description: 'Scholarships for young Black creatives. Active mentor in entertainment industry.', score: 88 },
      { id: '10', celebrity_id: '2', category: 'Mental Health', emoji: '🤝', description: 'Open about anxiety. Uses platform to normalize therapy for young fans.', score: 85 },
      { id: '11', celebrity_id: '2', category: 'Industry Ethics', emoji: '💼', description: 'Advocates for diverse casting. Producer credits ensure representation behind camera.', score: 90 },
      { id: '12', celebrity_id: '2', category: 'Body Positivity', emoji: '🌸', description: 'Pushes back on unrealistic beauty standards. Uses minimal retouching in campaigns.', score: 93 },
    ],
    shopItems,
  },

  'timothee-chalamet': {
    celeb: {
      id: '3',
      slug: 'timothee-chalamet',
      name: 'Timothée Chalamet',
      birth_year: 1995,
      tags: ['Actor', 'Style Icon'],
      vibe_score: 9.1,
      sun_sign: 'Capricorn ♑',
      moon_sign: 'Leo ♌',
      rising_sign: 'Virgo ♍',
      emoji: '🎬',
      gradient: 'linear-gradient(135deg, #6c5ce7, #a29bfe)',
    },
    currentEra: {
      id: '3',
      celebrity_id: '3',
      name: 'WONKA KING',
      description: 'Post-Wonka glow up. Fashion risk-taker. Every premiere is a streetwear-meets-couture moment.',
      progress: 55,
      is_current: true,
    },
    teaItems: [
      { id: '7', celebrity_id: '3', date_label: 'Mar 2026', content: 'Wore a full leather jumpsuit to the Oscars. Fashion Twitter had a full meltdown.', share_count: '1.9M shares', emoji: '🔥' },
      { id: '8', celebrity_id: '3', date_label: 'Feb 2026', content: 'Cast as young Bob Dylan biopic lead. Method acting era incoming.', share_count: '2.4M shares', emoji: '⚡' },
      { id: '9', celebrity_id: '3', date_label: 'Jan 2026', content: 'His "no stylist needed" GQ cover became the most-shared magazine cover of 2026.', share_count: '1.1M shares', emoji: '💫' },
    ],
    datingHistory: [
      { id: '10', celebrity_id: '3', partner_name: 'Lily-Rose Depp', date_range: '2018 – 2020', description: 'The yacht kissing photos. Peak paparazzi chaos.', status: 'past', sort_order: 1 },
      { id: '11', celebrity_id: '3', partner_name: 'Eiza González', date_range: '2020 – 2021', description: 'Cabo vibes. Brief summer fling that launched 1000 fan theories.', status: 'past', sort_order: 2 },
      { id: '12', celebrity_id: '3', partner_name: 'Kylie Jenner', date_range: '2023 – Now', description: 'The crossover nobody predicted. Front row at every fashion week together.', status: 'current', sort_order: 3 },
      { id: '13', celebrity_id: '3', partner_name: 'Next Chapter', date_range: '???', description: 'The lore continues...', status: 'future', sort_order: 4 },
    ],
    portfolio: [
      { id: '9', celebrity_id: '3', title: 'Call Me by Your Name', year: '2017', type: 'Film', energy_label: 'Lawful Good', emoji: '🍑', gradient: 'linear-gradient(135deg, #1a0e2a, #2d1040)' },
      { id: '10', celebrity_id: '3', title: 'Dune: Part Two', year: '2024', type: 'Film', energy_label: 'Chaotic Neutral', emoji: '🏜️', gradient: 'linear-gradient(135deg, #0a1a14, #142d20)' },
      { id: '11', celebrity_id: '3', title: 'Wonka', year: '2023', type: 'Film', energy_label: 'Chaotic Good', emoji: '🍫', gradient: 'linear-gradient(135deg, #1a1208, #2d2014)' },
      { id: '12', celebrity_id: '3', title: 'A Complete Unknown', year: '2025', type: 'Film', energy_label: 'Main Character', emoji: '🎸', gradient: 'linear-gradient(135deg, #120a1a, #1e1028)' },
    ],
    poll: {
      id: '3',
      celebrity_id: '3',
      event_name: 'Venice Film Festival Fit',
      serve_count: 9210,
      flop_count: 4100,
      is_active: true,
    },
    scorecard: [
      { id: '13', celebrity_id: '3', category: 'Environmental', emoji: '🌍', description: 'Quiet supporter. Donated to environmental causes but not a vocal champion yet.', score: 62 },
      { id: '14', celebrity_id: '3', category: 'LGBTQ+ Advocacy', emoji: '🏳️‍🌈', description: 'CMBYN elevated queer cinema. Consistently allies at events and in interviews.', score: 84 },
      { id: '15', celebrity_id: '3', category: 'Youth Education', emoji: '📚', description: 'LaGuardia High School advocate. Supports arts programs in New York City.', score: 73 },
      { id: '16', celebrity_id: '3', category: 'Mental Health', emoji: '🤝', description: 'Has spoken about the pressure of early fame. Advocates for breaks and boundaries.', score: 70 },
      { id: '17', celebrity_id: '3', category: 'Industry Ethics', emoji: '💼', description: 'Chooses indie over blockbuster consistently. Supports first-time directors.', score: 86 },
      { id: '18', celebrity_id: '3', category: 'Body Positivity', emoji: '🌸', description: 'Defies masculine fashion norms. Championed gender-fluid fashion on red carpets.', score: 88 },
    ],
    shopItems,
  },

  'billie-eilish': {
    celeb: {
      id: '4',
      slug: 'billie-eilish',
      name: 'Billie Eilish',
      birth_year: 2001,
      tags: ['Singer', 'Songwriter'],
      vibe_score: 9.2,
      sun_sign: 'Sagittarius ♐',
      moon_sign: 'Pisces ♓',
      rising_sign: 'Cancer ♋',
      emoji: '🖤',
      gradient: 'linear-gradient(135deg, #2d3436, #636e72)',
    },
    currentEra: {
      id: '4',
      celebrity_id: '4',
      name: 'HIT ME HARD',
      description: 'Soft grunge renaissance. Vulnerability as power. Brown hair, confessional lyrics, raw and unfiltered.',
      progress: 72,
      is_current: true,
    },
    teaItems: [
      { id: '10', celebrity_id: '4', date_label: 'Mar 2026', content: 'Announced a surprise stadium tour for summer 2026. Pre-sales crashed Ticketmaster again.', share_count: '3.5M shares', emoji: '🔥' },
      { id: '11', celebrity_id: '4', date_label: 'Feb 2026', content: 'Debuted a new song at Coachella that had the crowd in tears. Unreleased track leaked.', share_count: '1.7M shares', emoji: '⚡' },
      { id: '12', celebrity_id: '4', date_label: 'Jan 2026', content: 'Came out with a gen-Z climate change documentary. Streaming on all platforms.', share_count: '2.2M shares', emoji: '💫' },
    ],
    datingHistory: [
      { id: '14', celebrity_id: '4', partner_name: 'Matthew Tyler Vorce', date_range: '2021', description: 'Brief, controversial. Fans dug up old posts. Drama ensued.', status: 'drama', sort_order: 1 },
      { id: '15', celebrity_id: '4', partner_name: 'Jesse Rutherford', date_range: '2022 – 2023', description: 'The Neighbourhood frontman. Halloween couple costume broke the internet.', status: 'past', sort_order: 2 },
      { id: '16', celebrity_id: '4', partner_name: 'Next Chapter', date_range: '???', description: 'The lore continues...', status: 'future', sort_order: 3 },
    ],
    portfolio: [
      { id: '13', celebrity_id: '4', title: 'WHEN WE ALL FALL ASLEEP', year: '2019', type: 'Album', energy_label: 'Chaotic Good', emoji: '💚', gradient: 'linear-gradient(135deg, #1a0e2a, #2d1040)' },
      { id: '14', celebrity_id: '4', title: 'Happier Than Ever', year: '2021', type: 'Album', energy_label: 'Lawful Neutral', emoji: '💛', gradient: 'linear-gradient(135deg, #0a1a14, #142d20)' },
      { id: '15', celebrity_id: '4', title: 'HIT ME HARD AND SOFT', year: '2024', type: 'Album', energy_label: 'Chaotic Neutral', emoji: '🖤', gradient: 'linear-gradient(135deg, #1a1208, #2d2014)' },
      { id: '16', celebrity_id: '4', title: 'No Time to Die', year: '2021', type: 'Single (Bond)', energy_label: 'Main Character', emoji: '🔫', gradient: 'linear-gradient(135deg, #120a1a, #1e1028)' },
    ],
    poll: {
      id: '4',
      celebrity_id: '4',
      event_name: 'Grammys 2026 Performance',
      serve_count: 14300,
      flop_count: 2100,
      is_active: true,
    },
    scorecard: [
      { id: '19', celebrity_id: '4', category: 'Environmental', emoji: '🌍', description: 'Climate activist since 15. Overhaul Your Closet initiative is industry-leading.', score: 97 },
      { id: '20', celebrity_id: '4', category: 'LGBTQ+ Advocacy', emoji: '🏳️‍🌈', description: 'Came out publicly. Normalizes queerness for millions of young fans daily.', score: 96 },
      { id: '21', celebrity_id: '4', category: 'Youth Education', emoji: '📚', description: 'Supports music education in public schools. Donates instruments through programs.', score: 80 },
      { id: '22', celebrity_id: '4', category: 'Mental Health', emoji: '🤝', description: 'One of the most open Gen-Z artists about depression, self-harm, and body issues.', score: 95 },
      { id: '23', celebrity_id: '4', category: 'Industry Ethics', emoji: '💼', description: 'Called out industry ageism and exploitation. Advocates for young artist protections.', score: 88 },
      { id: '24', celebrity_id: '4', category: 'Body Positivity', emoji: '🌸', description: 'Landmark Vogue cover. Sparked massive conversation about body image and clothing choice.', score: 96 },
    ],
    shopItems,
  },
};

// Ticker headlines
export const tickerItems = [
  "Sabrina Carpenter's Espresso Tour Kicks Off",
  "Zendaya Stuns at Met Gala",
  "Chalamet's New Era Incoming",
  "Charli XCX Drops Brat Summer II",
  "Paul Mescal Goes Viral Again",
  "Billie Eilish's Hit Me Hard Tour Sells Out",
];

// Trending celebs for homepage tags and search
export const trendingCelebs: { name: string; slug: string; emoji: string; sub: string; badge: string; gradient: string }[] = [
  { name: 'Sabrina Carpenter', slug: 'sabrina-carpenter', emoji: '🎤', sub: 'Pop · Espresso Era', badge: '🔥 Trending', gradient: 'linear-gradient(135deg, #ff6b9d, #c44569)' },
  { name: 'Timothée Chalamet', slug: 'timothee-chalamet', emoji: '🎬', sub: 'Actor · Wonka King Era', badge: '🌙 Rising', gradient: 'linear-gradient(135deg, #6c5ce7, #a29bfe)' },
  { name: 'Zendaya', slug: 'zendaya', emoji: '👑', sub: 'Actor · Fashion Goddess Era', badge: '⭐ #1', gradient: 'linear-gradient(135deg, #00b894, #00cec9)' },
  { name: 'Billie Eilish', slug: 'billie-eilish', emoji: '🖤', sub: 'Pop · Hit Me Hard Era', badge: '', gradient: 'linear-gradient(135deg, #2d3436, #636e72)' },
];

// Featured celeb of the week (homepage main character)
export const featuredCelebSlug = 'sabrina-carpenter';
