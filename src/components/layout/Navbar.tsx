import Link from 'next/link';

export default function Navbar() {
  return (
    <nav className="fixed top-0 left-0 right-0 z-100 px-6 py-4 flex items-center justify-between"
      style={{ background: 'linear-gradient(to bottom, rgba(8,8,8,0.95), transparent)', backdropFilter: 'blur(12px)' }}>
      <Link href="/" className="font-[family-name:var(--font-display)] text-[2rem] tracking-[0.05em] no-underline"
        style={{ background: 'linear-gradient(135deg, var(--accent-pink), var(--accent-purple))', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
        Celeb<span style={{ WebkitTextFillColor: 'var(--accent-teal)' }}>Pulse</span>
      </Link>
      <ul className="hidden md:flex gap-8 list-none text-[0.8rem] font-bold tracking-[0.12em] uppercase">
        <li><a href="#trending" className="text-[var(--muted)] no-underline transition-colors duration-200 hover:text-[var(--accent-teal)]">Trending</a></li>
        <li><a href="/#portfolio" className="text-[var(--muted)] no-underline transition-colors duration-200 hover:text-[var(--accent-teal)]">Portfolio</a></li>
        <li><a href="/#shop" className="text-[var(--muted)] no-underline transition-colors duration-200 hover:text-[var(--accent-teal)]">Shop the Look</a></li>
        <li><a href="/#scorecard" className="text-[var(--muted)] no-underline transition-colors duration-200 hover:text-[var(--accent-teal)]">Scorecard</a></li>
      </ul>
      <button className="bg-[var(--accent-pink)] text-black font-bold text-[0.75rem] tracking-[0.1em] uppercase px-5 py-2 rounded-full border-none cursor-pointer transition-all duration-200 hover:scale-105 hover:shadow-[0_0_20px_rgba(255,45,120,0.5)]">
        ⚡ Get Notified
      </button>
    </nav>
  );
}
