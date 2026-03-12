'use client';

import { useEffect, useRef } from 'react';

export default function CustomCursor() {
  const dotRef = useRef<HTMLDivElement>(null);
  const trailRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    let mx = 0, my = 0, tx = 0, ty = 0;

    const handleMouse = (e: MouseEvent) => {
      mx = e.clientX;
      my = e.clientY;
      if (dotRef.current) {
        dotRef.current.style.left = mx - 6 + 'px';
        dotRef.current.style.top = my - 6 + 'px';
      }
    };

    const animTrail = () => {
      tx += (mx - tx) * 0.15;
      ty += (my - ty) * 0.15;
      if (trailRef.current) {
        trailRef.current.style.left = tx - 16 + 'px';
        trailRef.current.style.top = ty - 16 + 'px';
      }
      requestAnimationFrame(animTrail);
    };

    document.addEventListener('mousemove', handleMouse);
    animTrail();

    return () => document.removeEventListener('mousemove', handleMouse);
  }, []);

  return (
    <>
      <div className="cursor-dot" ref={dotRef} />
      <div className="cursor-trail" ref={trailRef} />
    </>
  );
}
