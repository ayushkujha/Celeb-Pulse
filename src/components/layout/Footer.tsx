export default function Footer() {
  return (
    <footer className="border-t border-[var(--border)] py-10 px-6 text-center">
      <span className="font-[family-name:var(--font-display)] text-[2.5rem] block mb-3"
        style={{ background: 'linear-gradient(135deg, var(--accent-pink), var(--accent-purple))', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
        Celeb<span style={{ WebkitTextFillColor: 'var(--accent-teal)' }}>Pulse</span>
      </span>
      <p className="text-[0.8rem] text-[var(--muted)]">Built for stans. Fueled by lore. © 2026 CelebPulse</p>
      <p className="mt-2 text-[0.7rem] text-[#333]">No celebrities were harmed in the making of this website. Probably.</p>
    </footer>
  );
}
