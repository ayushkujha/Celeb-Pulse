-- CelebPulse Database Schema & Initial Seed Data
-- Run this script in the Supabase SQL Editor (https://supabase.com/dashboard/project/_/sql/new)

-------------------------------------------------------------------------------
-- 1. DROP EXISTING TABLES (If any, for clean slate)
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS scorecard CASCADE;
DROP TABLE IF EXISTS polls CASCADE;
DROP TABLE IF EXISTS portfolio CASCADE;
DROP TABLE IF EXISTS dating_history CASCADE;
DROP TABLE IF EXISTS tea_items CASCADE;
DROP TABLE IF EXISTS eras CASCADE;
DROP TABLE IF EXISTS shop_items CASCADE;
DROP TABLE IF EXISTS celebrities CASCADE;

-------------------------------------------------------------------------------
-- 2. CREATE TABLES
-------------------------------------------------------------------------------

-- Core celebrity table
CREATE TABLE celebrities (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug        TEXT UNIQUE NOT NULL,
  name        TEXT NOT NULL,
  emoji       TEXT,
  tags        TEXT[],
  vibe_score  DECIMAL(3,1),
  sun_sign    TEXT,
  moon_sign   TEXT,
  rising_sign TEXT,
  created_at  TIMESTAMPTZ DEFAULT now()
);

-- Era tracking
CREATE TABLE eras (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  celebrity_id  UUID NOT NULL REFERENCES celebrities(id) ON DELETE CASCADE,
  name          TEXT NOT NULL,
  description   TEXT,
  progress      INT DEFAULT 0 CHECK (progress >= 0 AND progress <= 100),
  is_current    BOOLEAN DEFAULT false,
  created_at    TIMESTAMPTZ DEFAULT now()
);

-- The Tea (gossip/news)
CREATE TABLE tea_items (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  celebrity_id  UUID NOT NULL REFERENCES celebrities(id) ON DELETE CASCADE,
  date_label    TEXT,
  content       TEXT NOT NULL,
  share_count   TEXT,
  emoji         TEXT DEFAULT '🔥',
  created_at    TIMESTAMPTZ DEFAULT now()
);

-- Dating history
CREATE TABLE dating_history (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  celebrity_id  UUID NOT NULL REFERENCES celebrities(id) ON DELETE CASCADE,
  partner_name  TEXT NOT NULL,
  date_range    TEXT,
  description   TEXT,
  status        TEXT CHECK (status IN ('past', 'drama', 'current', 'future')),
  sort_order    INT DEFAULT 0
);

-- Portfolio/filmography
CREATE TABLE portfolio (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  celebrity_id  UUID NOT NULL REFERENCES celebrities(id) ON DELETE CASCADE,
  title         TEXT NOT NULL,
  year          TEXT,
  type          TEXT,
  energy_label  TEXT,
  emoji         TEXT DEFAULT '🎬',
  gradient      TEXT,
  sort_order    INT DEFAULT 0
);

-- Serve or Flop polls
CREATE TABLE polls (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  celebrity_id  UUID NOT NULL REFERENCES celebrities(id) ON DELETE CASCADE,
  event_name    TEXT NOT NULL,
  serve_count   INT DEFAULT 0,
  flop_count    INT DEFAULT 0,
  is_active     BOOLEAN DEFAULT true,
  created_at    TIMESTAMPTZ DEFAULT now()
);

-- Ethical scorecard
CREATE TABLE scorecard (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  celebrity_id  UUID NOT NULL REFERENCES celebrities(id) ON DELETE CASCADE,
  category      TEXT NOT NULL,
  emoji         TEXT,
  description   TEXT,
  score         INT CHECK (score >= 0 AND score <= 100),
  sort_order    INT DEFAULT 0
);

-- Shop The Look
CREATE TABLE shop_items (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  celebrity_id  UUID NOT NULL REFERENCES celebrities(id) ON DELETE CASCADE,
  name          TEXT NOT NULL,
  price         TEXT,
  emoji         TEXT,
  gradient      TEXT,
  sort_order    INT DEFAULT 0
);

-------------------------------------------------------------------------------
-- 3. INSERT SEED DATA
-------------------------------------------------------------------------------

DO $$
DECLARE
  sabrina_id UUID := gen_random_uuid();
  zendaya_id UUID := gen_random_uuid();
  timothee_id UUID := gen_random_uuid();
  billie_id UUID := gen_random_uuid();
BEGIN

  -- A. SABRINA CARPENTER
  INSERT INTO celebrities (id, slug, name, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign)
  VALUES (sabrina_id, 'sabrina-carpenter', 'Sabrina Carpenter', '💋', ARRAY['Pop Princess', 'Nonsense Queen'], 9.4, 'Taurus', 'Leo', 'Pisces');

  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (sabrina_id, 'SHORT N'' SWEET', 'Espresso dominance, Polly Pocket vibes, and unhinged outro lyrics. The world is her stage and we are just living in it.', 78, true);

  INSERT INTO tea_items (celebrity_id, date_label, content, share_count, emoji) VALUES
  (sabrina_id, '2 HOURS AGO', ' Barry Keoghan spotted wearing "Please Please Please" merch at Coachella. The PR relationship allegations are officially dead.', '1.2M shares', '👀'),
  (sabrina_id, 'YESTERDAY', 'SKIMS campaign drops. Internet universally agrees she is the moment. Sales up 400% in one hour.', '850K shares', '📸'),
  (sabrina_id, 'LAST WEEK', 'Taylor Swift brings her out for a surprise acoustic set. The crowd registered on the Richter scale.', '2.4M shares', '🎸');

  INSERT INTO dating_history (celebrity_id, partner_name, date_range, description, status, sort_order) VALUES
  (sabrina_id, 'Barry Keoghan', '2023 – NOW', 'The "Please Please Please" muse. High fashion gremlin meets pop princess.', 'current', 1),
  (sabrina_id, 'Shawn Mendes', '2023', 'Briefly spotted together opening a car door. The internet wrote 10,000 fanfics.', 'past', 2),
  (sabrina_id, 'Joshua Bassett', '2020 – 2021', 'The Driver''s License triangle. Skin was written. We all grieved. We all grew.', 'drama', 3);

  INSERT INTO portfolio (celebrity_id, title, year, type, energy_label, emoji, gradient, sort_order) VALUES
  (sabrina_id, 'Short n'' Sweet', '2024 · Album', 'Album', 'CHAOTIC GOOD', '☕️', 'linear-gradient(135deg, rgba(255,214,0,0.1), rgba(255,45,120,0.1))', 1),
  (sabrina_id, 'Emails I Can''t Send', '2022 · Album', 'Album', 'TRUE NEUTRAL', '✉️', 'linear-gradient(135deg, rgba(168,85,247,0.1), rgba(0,245,196,0.1))', 2),
  (sabrina_id, 'Mean Girls', '2020 · Broadway', 'Broadway', 'CHAOTIC EVIL', '🎭', 'linear-gradient(135deg, rgba(255,45,120,0.1), rgba(255,214,0,0.1))', 3),
  (sabrina_id, 'Girl Meets World', '2014 - 2017', 'TV Series', 'LAWFUL GOOD', '🌎', 'linear-gradient(135deg, rgba(0,245,196,0.1), rgba(168,85,247,0.1))', 4);

  INSERT INTO polls (celebrity_id, event_name, serve_count, flop_count)
  VALUES (sabrina_id, 'Met Gala 2024 Look (Alice in Wonderland vibes)', 85400, 12000);

  INSERT INTO scorecard (celebrity_id, category, emoji, description, score, sort_order) VALUES
  (sabrina_id, 'CLIMATE IMPACT', '🌍', 'Charter flights are minimal, but tour bus fleet is massive. Merch is not sustainably sourced.', 45, 1),
  (sabrina_id, 'LABOR PRACTICES', '👷', 'Dancers and crew report excellent working conditions. Known for paying above union rates.', 92, 2),
  (sabrina_id, 'PHILANTHROPY', '💎', 'Quiet donations to women''s shelters. Performed charity sets for children''s hospitals.', 78, 3);

  INSERT INTO shop_items (celebrity_id, name, price, emoji, gradient, sort_order) VALUES
  (sabrina_id, 'Vintage Platform Boots', '$120.00', '👢', 'linear-gradient(135deg, #2a1b38, #1a0b2e)', 1),
  (sabrina_id, 'Espresso Lip Gloss', '$22.00', '💄', 'linear-gradient(135deg, #3a1528, #2a0518)', 2),
  (sabrina_id, 'Heart Cutout Corset', '$68.00', '🎀', 'linear-gradient(135deg, #152a28, #051a18)', 3),
  (sabrina_id, 'Pleated Micro Skirt', '$45.00', '👗', 'linear-gradient(135deg, #2a2815, #1a1805)', 4);


  -- B. ZENDAYA
  INSERT INTO celebrities (id, slug, name, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign)
  VALUES (zendaya_id, 'zendaya', 'Zendaya', '👑', ARRAY['Actress', 'Fashion Icon'], 9.8, 'Virgo', 'Aquarius', 'Aquarius');

  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (zendaya_id, 'FASHION GODDESS', 'Met Gala domination, Valentino muse, every red carpet is her runway. Effortlessly iconic.', 85, true);

  INSERT INTO tea_items (celebrity_id, date_label, content, share_count, emoji) VALUES
  (zendaya_id, '1 DAY AGO', 'Just dropped the hardest Challengers promo look yet. Tennis core is officially back.', '2.8M shares', '🎾'),
  (zendaya_id, '3 DAYS AGO', 'Her Dune: Part Two premiere look broke the internet. Most liked photo by an actress ever.', '4.2M shares', '🔥'),
  (zendaya_id, '1 MONTH AGO', 'Launched her own fashion label "Daya" with zero fast fashion. Everything sustainable.', '1.8M shares', '⚡');

  INSERT INTO dating_history (celebrity_id, partner_name, date_range, description, status, sort_order) VALUES
  (zendaya_id, 'Tom Holland', '2021 – NOW', 'Spider-Man to real life. The internet''s most protected couple. Endgame energy.', 'current', 1),
  (zendaya_id, 'Jacob Elordi', '2019 – 2020', 'Euphoria chemistry that bled into real life. Brief but memorable.', 'past', 2);

  INSERT INTO portfolio (celebrity_id, title, year, type, energy_label, emoji, gradient, sort_order) VALUES
  (zendaya_id, 'Challengers', '2024 · Film', 'Film', 'CHAOTIC NEUTRAL', '🎾', 'linear-gradient(135deg, rgba(255,214,0,0.1), rgba(0,245,196,0.1))', 1),
  (zendaya_id, 'Dune: Part Two', '2024 · Film', 'Film', 'LAWFUL NEUTRAL', '🏜️', 'linear-gradient(135deg, rgba(168,85,247,0.1), rgba(0,245,196,0.1))', 2),
  (zendaya_id, 'Euphoria', '2019–2024 · TV Series', 'TV Series', 'CHAOTIC GOOD', '🎭', 'linear-gradient(135deg, rgba(255,45,120,0.1), rgba(168,85,247,0.1))', 3),
  (zendaya_id, 'The Greatest Showman', '2017 · Film', 'Film', 'LAWFUL GOOD', '🎪', 'linear-gradient(135deg, rgba(255,45,120,0.1), rgba(255,214,0,0.1))', 4);

  INSERT INTO polls (celebrity_id, event_name, serve_count, flop_count)
  VALUES (zendaya_id, 'Met Gala 2025 Look', 145000, 3000);

  INSERT INTO scorecard (celebrity_id, category, emoji, description, score, sort_order) VALUES
  (zendaya_id, 'CLIMATE IMPACT', '🌍', 'Advocates for sustainable fashion, refuses fast-fashion sponsorships.', 88, 1),
  (zendaya_id, 'LABOR PRACTICES', '👷', 'Known for ensuring diverse hiring on sets and advocating for equal pay.', 95, 2),
  (zendaya_id, 'PHILANTHROPY', '💎', 'Supports numerous educational and racial justice initiatives.', 90, 3);

  INSERT INTO shop_items (celebrity_id, name, price, emoji, gradient, sort_order) VALUES
  (zendaya_id, 'Vintage Archive Dress', '$4,500.00', '👗', 'linear-gradient(135deg, #2a1b38, #1a0b2e)', 1),
  (zendaya_id, 'Bulgari Necklace', 'Price Upon Request', '💎', 'linear-gradient(135deg, #152a28, #051a18)', 2);


  -- C. TIMOTHÉE CHALAMET
  INSERT INTO celebrities (id, slug, name, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign)
  VALUES (timothee_id, 'timothee-chalamet', 'Timothée Chalamet', '🍑', ARRAY['Actor', 'Heartthrob'], 8.9, 'Capricorn', 'Pisces', 'Virgo');

  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (timothee_id, 'BLOCKBUSTER BOY', 'Transitioning from indie darling to leading man of billion-dollar franchises. He is the Lisan al Gaib.', 65, true);

  INSERT INTO tea_items (celebrity_id, date_label, content, share_count, emoji) VALUES
  (timothee_id, '5 HOURS AGO', 'Spotted at a secretive dinner in Paris. Fans speculate a new French film role.', '950K shares', '👀'),
  (timothee_id, '2 DAYS AGO', 'Kylie Jenner posts a cryptic photo with a familiar-looking jawline in the background.', '3.1M shares', '🔥');

  INSERT INTO dating_history (celebrity_id, partner_name, date_range, description, status, sort_order) VALUES
  (timothee_id, 'Kylie Jenner', '2023 – NOW', 'The unexpected crossover event of the century. Still going strong.', 'current', 1),
  (timothee_id, 'Lily-Rose Depp', '2018 – 2020', 'The iconic boat kiss. The ultimate French-American indie couple aesthetic.', 'past', 2);

  INSERT INTO portfolio (celebrity_id, title, year, type, energy_label, emoji, gradient, sort_order) VALUES
  (timothee_id, 'Dune: Part Two', '2024 · Film', 'Film', 'LAWFUL NEUTRAL', '🏜️', 'linear-gradient(135deg, rgba(255,214,0,0.1), rgba(168,85,247,0.1))', 1),
  (timothee_id, 'Wonka', '2023 · Film', 'Film', 'CHAOTIC GOOD', '🍫', 'linear-gradient(135deg, rgba(168,85,247,0.1), rgba(255,45,120,0.1))', 2),
  (timothee_id, 'Call Me By Your Name', '2017 · Film', 'Film', 'TRUE NEUTRAL', '🍑', 'linear-gradient(135deg, rgba(0,245,196,0.1), rgba(168,85,247,0.1))', 3);

  INSERT INTO polls (celebrity_id, event_name, serve_count, flop_count)
  VALUES (timothee_id, 'Wonka Premiere Velvet Suit', 72000, 15000);

  INSERT INTO scorecard (celebrity_id, category, emoji, description, score, sort_order) VALUES
  (timothee_id, 'CLIMATE IMPACT', '🌍', 'Average footprint for an actor his size; takes commercial flights occasionally.', 60, 1),
  (timothee_id, 'LABOR PRACTICES', '👷', 'No negative reports, standard industry practices.', 75, 2);

  INSERT INTO shop_items (celebrity_id, name, price, emoji, gradient, sort_order) VALUES
  (timothee_id, 'Harness (Custom)', '$1,200.00', '🦺', 'linear-gradient(135deg, #3a1528, #2a0518)', 1),
  (timothee_id, 'Messy Curls Gel', '$28.00', '🧴', 'linear-gradient(135deg, #152a28, #051a18)', 2);


  -- D. BILLIE EILISH
  INSERT INTO celebrities (id, slug, name, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign)
  VALUES (billie_id, 'billie-eilish', 'Billie Eilish', '🕷️', ARRAY['Singer', 'Oscar Winner'], 9.6, 'Sagittarius', 'Aquarius', 'Pisces');

  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (billie_id, 'HIT ME HARD AND SOFT', 'Return to her roots but evolved. Soft vocals, hard beats, unapologetic authenticity.', 45, true);

  INSERT INTO tea_items (celebrity_id, date_label, content, share_count, emoji) VALUES
  (billie_id, '10 HOURS AGO', 'Previewed a new track on IG Live. Sounds suspiciously like a diss track.', '1.5M shares', '🎵'),
  (billie_id, '3 DAYS AGO', 'Won her second Oscar. Needs a bigger mantlepiece.', '5.2M shares', '🏆');

  INSERT INTO dating_history (celebrity_id, partner_name, date_range, description, status, sort_order) VALUES
  (billie_id, 'Jesse Rutherford', '2022 – 2023', 'The controversial age gap. They broke up amicably.', 'past', 1),
  (billie_id, 'Matthew Tyler Vorce', '2021 – 2022', 'Keep it moving. Nothing to see here.', 'past', 2);

  INSERT INTO portfolio (celebrity_id, title, year, type, energy_label, emoji, gradient, sort_order) VALUES
  (billie_id, 'Hit Me Hard and Soft', '2024 · Album', 'Album', 'CHAOTIC NEUTRAL', '🌊', 'linear-gradient(135deg, rgba(0,245,196,0.1), rgba(168,85,247,0.1))', 1),
  (billie_id, 'Happier Than Ever', '2021 · Album', 'Album', 'TRUE NEUTRAL', '☁️', 'linear-gradient(135deg, rgba(255,214,0,0.1), rgba(168,85,247,0.1))', 2),
  (billie_id, 'When We All Fall Asleep', '2019 · Album', 'Album', 'CHAOTIC EVIL', '🕷️', 'linear-gradient(135deg, rgba(168,85,247,0.1), rgba(255,45,120,0.1))', 3);

  INSERT INTO polls (celebrity_id, event_name, serve_count, flop_count)
  VALUES (billie_id, 'Grammys Oversized Suit', 98000, 45000);

  INSERT INTO scorecard (celebrity_id, category, emoji, description, score, sort_order) VALUES
  (billie_id, 'CLIMATE IMPACT', '🌍', 'Strictly vegan, champions climate action, uses eco-friendly vinyl for albums.', 98, 1),
  (billie_id, 'LABOR PRACTICES', '👷', 'High standards for tour crew treatment and fair pay.', 90, 2),
  (billie_id, 'PHILANTHROPY', '💎', 'Founding member of Support + Feed to combat food insecurity and climate change.', 95, 3);

  INSERT INTO shop_items (celebrity_id, name, price, emoji, gradient, sort_order) VALUES
  (billie_id, 'Oversized Anime Tee', '$45.00', '👕', 'linear-gradient(135deg, #152a28, #051a18)', 1),
  (billie_id, 'Chunky Silver Rings', '$85.00', '💍', 'linear-gradient(135deg, #2a2815, #1a1805)', 2);

END $$;
