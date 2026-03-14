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
  birth_year  INT,
  emoji       TEXT,
  tags        TEXT[],
  vibe_score  DECIMAL(3,1),
  sun_sign    TEXT,
  moon_sign   TEXT,
  rising_sign TEXT,
  image_url     TEXT,
  instagram_url TEXT,
  twitter_url   TEXT,
  created_at    TIMESTAMPTZ DEFAULT now()
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
  image_url     TEXT,
  product_url   TEXT,
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

  -- A. SABRINA CARPENTER (Met Gala attendee)
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (sabrina_id, 'sabrina-carpenter', 'Sabrina Carpenter', 1999, '💋', ARRAY['Pop Princess', 'Met Gala', 'Nonsense Queen'], 9.4, 'Taurus', 'Leo', 'Pisces', 'https://picsum.photos/seed/sabrina-carpenter/400/600', 'https://www.instagram.com/sabrinacarpenter/', 'https://twitter.com/SabrinaCarpenter');

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

  INSERT INTO shop_items (celebrity_id, name, price, emoji, gradient, image_url, product_url, sort_order) VALUES
  (sabrina_id, 'Vintage Platform Boots', '$120.00', '👢', 'linear-gradient(135deg, #2a1b38, #1a0b2e)', 'https://picsum.photos/seed/sabrina-boots/300/300', 'https://www.drmartens.com/', 1),
  (sabrina_id, 'Espresso Lip Gloss', '$22.00', '💄', 'linear-gradient(135deg, #3a1528, #2a0518)', 'https://picsum.photos/seed/sabrina-gloss/300/300', 'https://www.glossier.com/', 2),
  (sabrina_id, 'Heart Cutout Corset', '$68.00', '🎀', 'linear-gradient(135deg, #152a28, #051a18)', 'https://picsum.photos/seed/sabrina-corset/300/300', 'https://www.asos.com/', 3),
  (sabrina_id, 'Pleated Micro Skirt', '$45.00', '👗', 'linear-gradient(135deg, #2a2815, #1a1805)', 'https://picsum.photos/seed/sabrina-skirt/300/300', 'https://www.zara.com/', 4);


  -- B. ZENDAYA (Met Gala co-chair 2024)
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (zendaya_id, 'zendaya', 'Zendaya', 1996, '👑', ARRAY['Actress', 'Fashion Icon', 'Met Gala'], 9.8, 'Virgo', 'Aquarius', 'Aquarius', 'https://picsum.photos/seed/zendaya/400/600', 'https://www.instagram.com/zendaya/', 'https://twitter.com/Zendaya');

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

  INSERT INTO shop_items (celebrity_id, name, price, emoji, gradient, image_url, product_url, sort_order) VALUES
  (zendaya_id, 'Vintage Archive Dress', '$4,500.00', '👗', 'linear-gradient(135deg, #2a1b38, #1a0b2e)', 'https://picsum.photos/seed/zendaya-dress/300/300', 'https://www.valentino.com/', 1),
  (zendaya_id, 'Bulgari Necklace', 'Price Upon Request', '💎', 'linear-gradient(135deg, #152a28, #051a18)', 'https://picsum.photos/seed/zendaya-necklace/300/300', 'https://www.bulgari.com/', 2);


  -- C. TIMOTHÉE CHALAMET (Met Gala co-chair 2021)
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (timothee_id, 'timothee-chalamet', 'Timothée Chalamet', 1995, '🍑', ARRAY['Actor', 'Heartthrob', 'Met Gala'], 8.9, 'Capricorn', 'Pisces', 'Virgo', 'https://picsum.photos/seed/timothee-chalamet/400/600', 'https://www.instagram.com/timotheechalamet/', 'https://twitter.com/RealChalamet');

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

  INSERT INTO shop_items (celebrity_id, name, price, emoji, gradient, image_url, product_url, sort_order) VALUES
  (timothee_id, 'Harness (Custom)', '$1,200.00', '🦺', 'linear-gradient(135deg, #3a1528, #2a0518)', 'https://picsum.photos/seed/timothee-harness/300/300', 'https://www.gucci.com/', 1),
  (timothee_id, 'Messy Curls Gel', '$28.00', '🧴', 'linear-gradient(135deg, #152a28, #051a18)', 'https://picsum.photos/seed/timothee-gel/300/300', 'https://www.sephora.com/', 2);


  -- D. BILLIE EILISH (Met Gala co-chair 2021)
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (billie_id, 'billie-eilish', 'Billie Eilish', 2001, '🕷️', ARRAY['Singer', 'Oscar Winner', 'Met Gala'], 9.6, 'Sagittarius', 'Aquarius', 'Pisces', 'https://picsum.photos/seed/billie-eilish/400/600', 'https://www.instagram.com/billieeilish/', 'https://twitter.com/billieeilish');

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

  INSERT INTO shop_items (celebrity_id, name, price, emoji, gradient, image_url, product_url, sort_order) VALUES
  (billie_id, 'Oversized Anime Tee', '$45.00', '👕', 'linear-gradient(135deg, #152a28, #051a18)', 'https://picsum.photos/seed/billie-tee/300/300', 'https://www.blohsh.com/', 1),
  (billie_id, 'Chunky Silver Rings', '$85.00', '💍', 'linear-gradient(135deg, #2a2815, #1a1805)', 'https://picsum.photos/seed/billie-rings/300/300', 'https://www.etsy.com/', 2);

END $$;

-------------------------------------------------------------------------------
-- 4. MET GALA ATTENDEES (real celebrities who have attended since the start)
-------------------------------------------------------------------------------

DO $$
DECLARE
  u UUID;
BEGIN
  -- Rihanna (co-chair 2018, iconic looks)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'rihanna', 'Rihanna', 1988, '💄', ARRAY['Singer', 'Fenty', 'Met Gala', 'Fashion Icon'], 9.7, 'Pisces', 'Scorpio', 'Leo', 'https://picsum.photos/seed/rihanna/400/600', 'https://www.instagram.com/rihanna/', 'https://twitter.com/rihanna');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'FENTY EMPIRE', 'Billionaire mogul, Savage x Fenty, and the Met Gala papal look that broke the internet.', 95, true);

  -- Beyoncé (honorary chair 2013, multiple appearances)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'beyonce', 'Beyoncé', 1981, '🐝', ARRAY['Singer', 'Met Gala', 'Icon'], 9.9, 'Virgo', 'Capricorn', 'Gemini', 'https://picsum.photos/seed/beyonce/400/600', 'https://www.instagram.com/beyonce/', 'https://twitter.com/Beyonce');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'RENAISSANCE', 'Cowboy Carter, world tours, and undisputed queen of the Met red carpet.', 90, true);

  -- Lady Gaga (co-chair 2019 Camp theme)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'lady-gaga', 'Lady Gaga', 1986, '👠', ARRAY['Singer', 'Actress', 'Met Gala', 'Camp'], 9.5, 'Aries', 'Cancer', 'Sagittarius', 'https://picsum.photos/seed/lady-gaga/400/600', 'https://www.instagram.com/ladygaga/', 'https://twitter.com/ladygaga');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'CHROMATICA TO JOKER', 'Four outfit changes on the 2019 carpet. Need we say more?', 88, true);

  -- Anna Wintour (chair since 1995)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'anna-wintour', 'Anna Wintour', 1949, '🕶️', ARRAY['Vogue', 'Met Gala', 'Fashion'], 9.8, 'Scorpio', 'Capricorn', 'Leo', 'https://picsum.photos/seed/anna-wintour/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'EDITOR-IN-CHIEF', 'The woman who made the Met Gala fashion''s biggest night. Chair since 1995.', 100, true);

  -- Cher (early Met Gala attendee, 1970s–80s)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'cher', 'Cher', 1946, '✨', ARRAY['Singer', 'Actress', 'Met Gala', 'Legend'], 9.6, 'Taurus', 'Leo', 'Leo', 'https://picsum.photos/seed/cher/400/600', 'https://www.instagram.com/cher/', 'https://twitter.com/cher');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'ETERNAL ICON', 'From Sonny & Cher to the Met Gala since the Diana Vreeland era. Timeless.', 98, true);

  -- Diana Ross (Met Gala attendee 1970s)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'diana-ross', 'Diana Ross', 1944, '🌟', ARRAY['Singer', 'Met Gala', 'Legend'], 9.7, 'Pisces', 'Libra', 'Leo', 'https://picsum.photos/seed/diana-ross/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'SUPREME', 'Motown royalty and Met Gala guest since the Vreeland years.', 92, true);

  -- Madonna (Met Gala attendee)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'madonna', 'Madonna', 1958, '🔥', ARRAY['Singer', 'Met Gala', 'Icon'], 9.5, 'Leo', 'Aquarius', 'Gemini', 'https://picsum.photos/seed/madonna/400/600', 'https://www.instagram.com/madonna/', 'https://twitter.com/Madonna');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'REINVENTION', 'Queen of the Met red carpet and pop culture since the ''80s.', 90, true);

  -- Blake Lively (co-chair 2022)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'blake-lively', 'Blake Lively', 1987, '👗', ARRAY['Actress', 'Met Gala', 'Fashion Icon'], 9.4, 'Virgo', 'Pisces', 'Libra', 'https://picsum.photos/seed/blake-lively/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'GILDED GLAMOUR', 'Co-chaired 2022 Met Gala. That copper dress lives in our minds rent-free.', 88, true);

  -- Taylor Swift (co-chair energy, multiple appearances)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'taylor-swift', 'Taylor Swift', 1989, '🐍', ARRAY['Singer', 'Met Gala', 'Fashion'], 9.6, 'Sagittarius', 'Cancer', 'Sagittarius', 'https://picsum.photos/seed/taylor-swift/400/600', 'https://www.instagram.com/taylorswift/', 'https://twitter.com/taylorswift13');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'THE ERAS TOUR', 'From country to Met Gala regular. Manus x Machina 2016 and beyond.', 95, true);

  -- Jennifer Lawrence (co-chair 2015 China theme)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'jennifer-lawrence', 'Jennifer Lawrence', 1990, '🏹', ARRAY['Actress', 'Met Gala', 'Oscar Winner'], 9.3, 'Leo', 'Aquarius', 'Taurus', 'https://picsum.photos/seed/jennifer-lawrence/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'RED SPARROW TO NO HARD FEELINGS', 'Co-chaired Met Gala 2015. That red Dior is iconic.', 85, true);

  -- Harry Styles (co-chair 2019 Camp)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'harry-styles', 'Harry Styles', 1994, '🎀', ARRAY['Singer', 'Met Gala', 'Fashion'], 9.5, 'Aquarius', 'Gemini', 'Libra', 'https://picsum.photos/seed/harry-styles/400/600', 'https://www.instagram.com/harrystyles/', 'https://twitter.com/Harry_Styles');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'HARRY''S HOUSE', 'Gucci gown at Camp Met Gala 2019. Gender-fluid fashion king.', 90, true);

  -- Kate Moss (co-chair 2009 Model as Muse)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'kate-moss', 'Kate Moss', 1974, '📸', ARRAY['Model', 'Met Gala', 'Icon'], 9.6, 'Capricorn', 'Scorpio', 'Virgo', 'https://picsum.photos/seed/kate-moss/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'SUPERMODEL', 'Co-chaired 2009 Met Gala. The Model as Muse.', 88, true);

  -- Naomi Campbell (Met Gala regular)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'naomi-campbell', 'Naomi Campbell', 1970, '👑', ARRAY['Model', 'Met Gala', 'Legend'], 9.7, 'Taurus', 'Capricorn', 'Leo', 'https://picsum.photos/seed/naomi-campbell/400/600', 'https://www.instagram.com/naomi/', NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'LEGEND', 'Walked the Met carpet for decades. Unmatched presence.', 95, true);

  -- Kim Kardashian (Met Gala 2022 Marilyn dress)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'kim-kardashian', 'Kim Kardashian', 1980, '💎', ARRAY['Reality TV', 'Met Gala', 'Entrepreneur'], 9.2, 'Libra', 'Pisces', 'Cancer', 'https://picsum.photos/seed/kim-kardashian/400/600', 'https://www.instagram.com/kimkardashian/', 'https://twitter.com/KimKardashian');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'SKIMS & MET', 'Wore Marilyn Monroe''s 1962 dress to the 2022 Gilded Glamour Met Gala.', 82, true);

  -- Kylie Jenner (Met Gala regular, bathroom selfie tradition)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'kylie-jenner', 'Kylie Jenner', 1997, '💋', ARRAY['Reality TV', 'Met Gala', 'Kylie Cosmetics'], 9.0, 'Leo', 'Sagittarius', 'Libra', 'https://picsum.photos/seed/kylie-jenner/400/600', 'https://www.instagram.com/kyliejenner/', 'https://twitter.com/Kyliejenner');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'BEAUTY MOGUL', 'Part of the iconic Met bathroom selfie crew with Billie and Dakota.', 85, true);

  -- Jennifer Lopez (co-chair 2024)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'jennifer-lopez', 'Jennifer Lopez', 1969, '💃', ARRAY['Singer', 'Actress', 'Met Gala'], 9.4, 'Leo', 'Cancer', 'Taurus', 'https://picsum.photos/seed/jennifer-lopez/400/600', 'https://www.instagram.com/jlo/', 'https://twitter.com/JLo');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'THIS IS ME... NOW', 'Co-chaired 2024 Met Gala. Sleeping Beauties: Reawakening Fashion.', 88, true);

  -- Dua Lipa (co-chair 2023 Karl Lagerfeld)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'dua-lipa', 'Dua Lipa', 1995, '🦋', ARRAY['Singer', 'Met Gala', 'Fashion'], 9.3, 'Leo', 'Scorpio', 'Gemini', 'https://picsum.photos/seed/dua-lipa/400/600', 'https://www.instagram.com/dualipa/', 'https://twitter.com/dualipa');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'RADICAL OPTIMISM', 'Co-chaired 2023 Met Gala. Karl Lagerfeld: A Line of Beauty.', 87, true);

  -- Bad Bunny (co-chair 2024)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'bad-bunny', 'Bad Bunny', 1994, '🐰', ARRAY['Singer', 'Met Gala', 'Reggaeton'], 9.4, 'Pisces', 'Aries', 'Leo', 'https://picsum.photos/seed/bad-bunny/400/600', 'https://www.instagram.com/badboybunny/', 'https://twitter.com/sanbenito');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'UN VERANO SIN TI', 'Co-chaired 2024 Met Gala. Garden of Time theme.', 90, true);

  -- Priyanka Chopra (Met Gala, Bollywood crossover)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'priyanka-chopra', 'Priyanka Chopra', 1982, '✨', ARRAY['Actress', 'Met Gala', 'Bollywood'], 9.2, 'Cancer', 'Libra', 'Sagittarius', 'https://picsum.photos/seed/priyanka-chopra/400/600', 'https://www.instagram.com/priyankachopra/', 'https://twitter.com/priyankachopra');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'CITIZEN OF THE WORLD', 'Bollywood to Hollywood to the Met steps. Multiple appearances.', 86, true);

  -- Deepika Padukone (Met Gala attendee)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'deepika-padukone', 'Deepika Padukone', 1986, '🌺', ARRAY['Actress', 'Met Gala', 'Bollywood'], 9.1, 'Capricorn', 'Pisces', 'Virgo', 'https://picsum.photos/seed/deepika-padukone/400/600', 'https://www.instagram.com/deepikapadukone/', NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'GLOBAL STAR', 'Indian cinema icon and Met Gala red carpet regular.', 84, true);

  -- Billy Porter (Met Gala 2019 angel, iconic looks)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'billy-porter', 'Billy Porter', 1969, '👼', ARRAY['Actor', 'Met Gala', 'Fashion'], 9.6, 'Virgo', 'Leo', 'Gemini', 'https://picsum.photos/seed/billy-porter/400/600', 'https://www.instagram.com/thebillyporter/', 'https://twitter.com/thebillyporter');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'POSE TO MET', 'That golden winged entrance at Camp 2019. Fashion has no gender.', 92, true);

  -- Oprah Winfrey (co-chair 2010 American Woman)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'oprah-winfrey', 'Oprah Winfrey', 1954, '🎙️', ARRAY['Media', 'Met Gala', 'Philanthropist'], 9.8, 'Aquarius', 'Capricorn', 'Sagittarius', 'https://picsum.photos/seed/oprah-winfrey/400/600', 'https://www.instagram.com/oprah/', 'https://twitter.com/Oprah');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'OWN & MET', 'Co-chaired 2010 Met Gala. American Woman: Fashioning a National Identity.', 98, true);

  -- Nicole Kidman (co-chair 2003, 2005, 2026)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'nicole-kidman', 'Nicole Kidman', 1967, '🎬', ARRAY['Actress', 'Met Gala', 'Oscar Winner'], 9.3, 'Gemini', 'Pisces', 'Libra', 'https://picsum.photos/seed/nicole-kidman/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'HOLLYWOOD ROYALTY', 'Multiple Met Gala co-chair appearances. Goddess theme 2003.', 90, true);

  -- Cate Blanchett (co-chair 2007 Poiret)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'cate-blanchett', 'Cate Blanchett', 1969, '🏛️', ARRAY['Actress', 'Met Gala', 'Oscar Winner'], 9.4, 'Taurus', 'Aquarius', 'Scorpio', 'https://picsum.photos/seed/cate-blanchett/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'TÁR TO MET', 'Co-chaired 2007 Met Gala. Poiret: King of Fashion.', 88, true);

  -- Sarah Jessica Parker (Met Gala regular, 2014 co-chair)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'sarah-jessica-parker', 'Sarah Jessica Parker', 1965, '👠', ARRAY['Actress', 'Met Gala', 'SATC'], 9.2, 'Aries', 'Libra', 'Cancer', 'https://picsum.photos/seed/sarah-jessica-parker/400/600', 'https://www.instagram.com/sjp/', NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'CARRIE BRADSHAW', 'Charles James 2014 co-chair. Head-to-toe fashion risk-taker.', 85, true);

  -- Amal Clooney (co-chair 2018 Heavenly Bodies)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'amal-clooney', 'Amal Clooney', 1978, '⚖️', ARRAY['Lawyer', 'Met Gala', 'Human Rights'], 9.5, 'Pisces', 'Virgo', 'Capricorn', 'https://picsum.photos/seed/amal-clooney/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'HUMAN RIGHTS & HAUTE COUTURE', 'Co-chaired 2018 Met Gala. Heavenly Bodies theme.', 90, true);

  -- Serena Williams (co-chair 2019 Camp)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'serena-williams', 'Serena Williams', 1981, '🎾', ARRAY['Tennis', 'Met Gala', 'Legend'], 9.7, 'Libra', 'Sagittarius', 'Aries', 'https://picsum.photos/seed/serena-williams/400/600', 'https://www.instagram.com/serenawilliams/', 'https://twitter.com/serenawilliams');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'GOAT', '23 Grand Slams and Camp Met Gala 2019 co-chair. Icon.', 95, true);

  -- Gisele Bündchen (co-chair 2017)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'gisele-bundchen', 'Gisele Bündchen', 1980, '🌿', ARRAY['Model', 'Met Gala', 'Sustainability'], 9.4, 'Cancer', 'Taurus', 'Leo', 'https://picsum.photos/seed/gisele-bundchen/400/600', 'https://www.instagram.com/gisele/', NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'SUPERMODEL & ACTIVIST', 'Co-chaired 2017 Met Gala. Rei Kawakubo/Comme des Garçons.', 88, true);

  -- Pharrell Williams (co-chair 2017, 2025)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'pharrell-williams', 'Pharrell Williams', 1973, '🎩', ARRAY['Producer', 'Designer', 'Met Gala'], 9.5, 'Aries', 'Gemini', 'Libra', 'https://picsum.photos/seed/pharrell-williams/400/600', 'https://www.instagram.com/pharrell/', 'https://twitter.com/Pharrell');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'LOUIS VUITTON & MET', 'Co-chaired 2017 and 2025 Met Galas. Superfine: Tailoring Black Style.', 92, true);

  -- ASAP Rocky (co-chair 2025)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'asap-rocky', 'A$AP Rocky', 1988, '🌹', ARRAY['Rapper', 'Met Gala', 'Fashion'], 9.2, 'Libra', 'Scorpio', 'Aquarius', 'https://picsum.photos/seed/asap-rocky/400/600', 'https://www.instagram.com/asaprocky/', 'https://twitter.com/asvpxrocky');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'RIHANNA & MET', 'Co-chaired 2025 Met Gala. Tailoring Black Style.', 86, true);

  -- Lewis Hamilton (co-chair 2025)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'lewis-hamilton', 'Lewis Hamilton', 1985, '🏎️', ARRAY['F1', 'Met Gala', 'Fashion'], 9.3, 'Capricorn', 'Leo', 'Libra', 'https://picsum.photos/seed/lewis-hamilton/400/600', 'https://www.instagram.com/lewishamilton/', 'https://twitter.com/LewisHamilton');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'F1 LEGEND & STYLE', 'Co-chaired 2025 Met Gala. Seven-time F1 world champion.', 90, true);

  -- Colman Domingo (co-chair 2025)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'colman-domingo', 'Colman Domingo', 1969, '🎭', ARRAY['Actor', 'Met Gala', 'Rustin'], 9.1, 'Sagittarius', 'Cancer', 'Leo', 'https://picsum.photos/seed/colman-domingo/400/600', 'https://www.instagram.com/colmandomingo/', 'https://twitter.com/colmandomingo');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'EUPHORIA TO MET', 'Co-chaired 2025 Met Gala. Superfine: Tailoring Black Style.', 85, true);

  -- Elton John (Met Gala attendee since 1970s)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'elton-john', 'Elton John', 1947, '🎹', ARRAY['Singer', 'Met Gala', 'Legend'], 9.6, 'Aries', 'Pisces', 'Gemini', 'https://picsum.photos/seed/elton-john/400/600', 'https://www.instagram.com/eltonjohn/', 'https://twitter.com/eltonofficial');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'FAREWELL YELLOW BRICK ROAD', 'Met Gala guest since the Diana Vreeland era. Glasses and glamour.', 94, true);

  -- Liza Minnelli (Met Gala 1970s)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'liza-minnelli', 'Liza Minnelli', 1946, '🎤', ARRAY['Actress', 'Singer', 'Met Gala'], 9.5, 'Pisces', 'Leo', 'Leo', 'https://picsum.photos/seed/liza-minnelli/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'CABARET LEGEND', 'Broadway and Met Gala icon. Vreeland-era regular.', 90, true);

  -- Bianca Jagger (Met Gala 1970s)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'bianca-jagger', 'Bianca Jagger', 1945, '🕴️', ARRAY['Activist', 'Met Gala', 'Style Icon'], 9.4, 'Taurus', 'Aquarius', 'Libra', 'https://picsum.photos/seed/bianca-jagger/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'STUDIO 54 ERA', 'That white suit. Met Gala and disco royalty.', 88, true);

  -- Barbra Streisand (Met Gala attendee)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'barbra-streisand', 'Barbra Streisand', 1942, '🎭', ARRAY['Singer', 'Actress', 'Met Gala'], 9.6, 'Taurus', 'Capricorn', 'Virgo', 'https://picsum.photos/seed/barbra-streisand/400/600', 'https://www.instagram.com/barbrastreisand/', 'https://twitter.com/BarbraStreisand');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'LEGEND', 'EGOT and Met Gala guest since the ''70s.', 95, true);

  -- Elizabeth Taylor (Met Gala 1970s–80s)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'elizabeth-taylor', 'Elizabeth Taylor', 1932, '💜', ARRAY['Actress', 'Met Gala', 'Legend'], 9.8, 'Pisces', 'Scorpio', 'Sagittarius', 'https://picsum.photos/seed/elizabeth-taylor/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'HOLLYWOOD ROYALTY', 'Diamond-loving icon. Met Gala in the Vreeland years.', 98, true);

  -- Andy Warhol (Met Gala attendee)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'andy-warhol', 'Andy Warhol', 1928, '🍅', ARRAY['Artist', 'Met Gala', 'Pop Art'], 9.7, 'Leo', 'Aquarius', 'Gemini', 'https://picsum.photos/seed/andy-warhol/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'FACTORY ERA', 'Artist and Met Gala guest. Blurred the line between art and fashion.', 95, true);

  -- Dakota Johnson (Met bathroom selfie crew)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'dakota-johnson', 'Dakota Johnson', 1989, '🦋', ARRAY['Actress', 'Met Gala', 'Fifty Shades'], 9.0, 'Libra', 'Pisces', 'Cancer', 'https://picsum.photos/seed/dakota-johnson/400/600', NULL, NULL);
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'MET BATHROOM SELFIE', 'Part of the viral annual Met bathroom selfie with Billie and Kylie.', 82, true);

  -- Shah Rukh Khan (first male Bollywood star at Met Gala 2025)
  u := gen_random_uuid();
  INSERT INTO celebrities (id, slug, name, birth_year, emoji, tags, vibe_score, sun_sign, moon_sign, rising_sign, image_url, instagram_url, twitter_url)
  VALUES (u, 'shah-rukh-khan', 'Shah Rukh Khan', 1965, '🌟', ARRAY['Actor', 'Met Gala', 'Bollywood'], 9.6, 'Scorpio', 'Leo', 'Libra', 'https://picsum.photos/seed/shah-rukh-khan/400/600', 'https://www.instagram.com/iamsrk/', 'https://twitter.com/iamsrk');
  INSERT INTO eras (celebrity_id, name, description, progress, is_current)
  VALUES (u, 'KING KHAN', 'First male Bollywood star to ascend the Met steps. 2025 Met Gala.', 90, true);

END $$;
