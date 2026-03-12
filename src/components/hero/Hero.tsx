import SearchBar from './SearchBar';
import TrendingTags from './TrendingTags';

export default function Hero() {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center px-6 pt-[100px] pb-[60px] relative overflow-hidden">
      {/* Background gradients */}
      <div className="absolute inset-0" style={{
        background: `
          radial-gradient(ellipse 80% 50% at 20% 40%, rgba(168,85,247,0.15) 0%, transparent 60%),
          radial-gradient(ellipse 60% 40% at 80% 60%, rgba(255,45,120,0.12) 0%, transparent 60%),
          radial-gradient(ellipse 40% 60% at 50% 10%, rgba(0,245,196,0.08) 0%, transparent 60%)
        `
      }} />

      {/* Eyebrow */}
      <div className="relative text-[0.7rem] font-bold tracking-[0.25em] uppercase text-[var(--accent-teal)] border border-[var(--accent-teal)] px-4 py-[6px] rounded-full mb-7"
        style={{ animation: 'fadeDown 0.6s ease both' }}>
        ✦ The Lore Lives Here
      </div>

      {/* Title */}
      <h1 className="relative font-[family-name:var(--font-display)] text-center leading-[0.9] tracking-[0.02em] mb-3"
        style={{ fontSize: 'clamp(5rem, 15vw, 12rem)', animation: 'fadeUp 0.7s 0.1s ease both' }}>
        <div className="glitch" data-text="CELEB">CELEB</div>
        <div style={{ background: 'linear-gradient(135deg, var(--accent-pink) 0%, var(--accent-purple) 50%, var(--accent-teal) 100%)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
          PULSE
        </div>
      </h1>

      {/* Subtitle */}
      <p className="relative text-center text-[var(--muted)] max-w-[500px] mb-12 leading-[1.6]"
        style={{ fontSize: 'clamp(1rem, 2.5vw, 1.25rem)', animation: 'fadeUp 0.7s 0.2s ease both' }}>
        Your obsessive encyclopedia for celebrity lore, aesthetics, and the tea. Built for stans. No cap.
      </p>

      <SearchBar />
      <TrendingTags />
    </div>
  );
}
