import type { Metadata } from "next";
import { Bebas_Neue, Archivo_Black, DM_Sans } from "next/font/google";
import "./globals.css";
import Navbar from "@/components/layout/Navbar";
import Footer from "@/components/layout/Footer";
import CustomCursor from "@/components/layout/CustomCursor";

const bebasNeue = Bebas_Neue({
  weight: "400",
  variable: "--font-bebas-neue",
  subsets: ["latin"],
});

const archivoBlack = Archivo_Black({
  weight: "400",
  variable: "--font-archivo-black",
  subsets: ["latin"],
});

const dmSans = DM_Sans({
  variable: "--font-dm-sans",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "CelebPulse ⚡ The Lore Lives Here",
  description:
    "Your obsessive encyclopedia for celebrity lore, aesthetics, and the tea. Built for stans. No cap.",
  keywords: ["celebrity", "pop culture", "gossip", "entertainment", "trending"],
  openGraph: {
    title: "CelebPulse ⚡",
    description: "Your obsessive encyclopedia for celebrity lore, aesthetics, and the tea.",
    url: 'https://celebpulse.com',
    siteName: 'CelebPulse',
    images: [
      {
        url: 'https://celebpulse.com/og-image.jpg',
        width: 1200,
        height: 630,
        alt: 'CelebPulse Open Graph Image',
      },
    ],
    locale: 'en_US',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'CelebPulse ⚡',
    description: 'Your obsessive encyclopedia for celebrity lore and the tea.',
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body
        className={`${bebasNeue.variable} ${archivoBlack.variable} ${dmSans.variable}`}
        style={{ fontFamily: "var(--font-dm-sans), sans-serif" }}
      >
        <CustomCursor />
        <Navbar />
        {children}
        <Footer />
      </body>
    </html>
  );
}
