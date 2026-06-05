import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({ subsets: ["latin"], display: "swap" });

// ============================================================
// METADATA - Update with your information
// Prompt: "Update the page title and description for SEO"
// ============================================================
export const metadata: Metadata = {
  title: "CyberLaunch AI — Launch Your Cybersecurity Career With Confidence",
  description: "Get a personalized cybersecurity roadmap, certification guidance, hands-on lab recommendations, and interview prep. Built for students and career changers.",
  keywords: [
    "cybersecurity career roadmap",
    "how to become a SOC analyst",
    "cybersecurity certifications for beginners",
    "cybersecurity career change",
    "TryHackMe roadmap",
    "Security+ study plan",
    "cybersecurity jobs no experience",
  ],
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={inter.className}>{children}</body>
    </html>
  );
}
