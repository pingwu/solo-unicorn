// ============================================================
// CYBERLAUNCH AI — LANDING PAGE
// ============================================================
// Agentic Cybersecurity Career and Lab Coach
// Built for students and career changers entering cybersecurity
// ============================================================

import Image from "next/image";
import { MobileNav } from "@/components/MobileNav";
import { WaitlistForm } from "@/components/WaitlistForm";
import {
  ArrowRightIcon,
  CheckIcon,
  MailIcon,
  LinkedInIcon,
  GitHubIcon,
} from "@/components/Icons";

// ── Feature icons (inline SVGs reusing the IconProps pattern) ──

function MapIcon({ className = "w-7 h-7" }: { className?: string }) {
  return (
    <svg className={className} fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 20l-5.447-2.724A1 1 0 013 16.382V5.618a1 1 0 011.447-.894L9 7m0 13l6-3m-6 3V7m6 10l4.553 2.276A1 1 0 0021 18.382V7.618a1 1 0 00-.553-.894L15 4m0 13V4m0 0L9 7" />
    </svg>
  );
}

function BadgeIcon({ className = "w-7 h-7" }: { className?: string }) {
  return (
    <svg className={className} fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z" />
    </svg>
  );
}

function TerminalIcon({ className = "w-7 h-7" }: { className?: string }) {
  return (
    <svg className={className} fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 9l3 3-3 3m5 0h3M5 20h14a2 2 0 002-2V6a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
    </svg>
  );
}

function ClipboardIcon({ className = "w-7 h-7" }: { className?: string }) {
  return (
    <svg className={className} fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
    </svg>
  );
}

function CompassIcon({ className = "w-7 h-7" }: { className?: string }) {
  return (
    <svg className={className} fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 8l-4-4-4 4m0 8l4 4 4-4M12 4v16" />
    </svg>
  );
}

export default function Home() {
  return (
    <>
      {/* Skip link for accessibility */}
      <a
        href="#main-content"
        className="sr-only focus:not-sr-only focus:absolute focus:top-4 focus:left-4 focus:z-[100] focus:px-4 focus:py-2 focus:bg-cyan-600 focus:text-white focus:rounded-lg focus:outline-none"
      >
        Skip to main content
      </a>

      <main id="main-content" className="min-h-screen bg-slate-950 font-sans">

        {/* ============================================================ */}
        {/* NAVIGATION                                                    */}
        {/* ============================================================ */}
        <nav aria-label="Main navigation" className="fixed top-0 left-0 right-0 z-50 bg-slate-950/80 backdrop-blur-md border-b border-slate-800">
          <div className="container mx-auto px-4 md:px-6 flex items-center justify-between h-16">
            {/* Logo */}
            <div className="flex items-center gap-2">
              <div className="w-8 h-8 rounded-lg bg-gradient-to-br from-cyan-500 to-blue-600 flex items-center justify-center text-white font-bold text-sm">
                CL
              </div>
              <span className="text-xl font-bold tracking-tight text-white">
                CyberLaunch <span className="text-cyan-400">AI</span>
              </span>
            </div>

            {/* Desktop nav */}
            <div className="hidden md:flex items-center gap-8">
              <a href="#about" className="text-sm font-medium text-slate-400 hover:text-cyan-400 transition-colors">
                About
              </a>
              <a href="#features" className="text-sm font-medium text-slate-400 hover:text-cyan-400 transition-colors">
                Features
              </a>
              <a href="#how-it-works" className="text-sm font-medium text-slate-400 hover:text-cyan-400 transition-colors">
                How It Works
              </a>
              <a href="#waitlist" className="bg-cyan-500 hover:bg-cyan-400 text-slate-950 px-4 py-2 rounded-lg text-sm font-semibold transition-colors">
                Join Waitlist
              </a>
            </div>

            {/* Mobile nav */}
            <MobileNav />
          </div>
        </nav>

        {/* ============================================================ */}
        {/* SECTION 1 — HERO                                             */}
        {/* ============================================================ */}
        <section className="relative pt-32 pb-24 md:pt-44 md:pb-36 overflow-hidden">
          {/* Background glow blobs */}
          <div className="absolute top-0 right-0 -z-10 w-[700px] h-[700px] bg-cyan-500/10 rounded-full blur-3xl opacity-60 translate-x-1/3 -translate-y-1/4" />
          <div className="absolute bottom-0 left-0 -z-10 w-[500px] h-[500px] bg-blue-600/10 rounded-full blur-3xl opacity-60 -translate-x-1/3 translate-y-1/4" />

          <div className="container mx-auto px-4 md:px-6">
            <div className="max-w-4xl mx-auto text-center">
              {/* Badge */}
              <div className="inline-flex items-center gap-2 bg-cyan-950/60 border border-cyan-800 text-cyan-400 px-4 py-1.5 rounded-full text-sm font-medium mb-6">
                <span className="relative flex h-2 w-2">
                  <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-cyan-400 opacity-75" />
                  <span className="relative inline-flex rounded-full h-2 w-2 bg-cyan-500" />
                </span>
                Now Accepting Early Access — Join the Waitlist
              </div>

              {/* Headline */}
              <h1 className="text-4xl md:text-6xl lg:text-7xl font-bold tracking-tight text-white mb-6 leading-tight">
                Launch Your{" "}
                <span className="text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-blue-500">
                  Cybersecurity Career
                </span>{" "}
                With Confidence
              </h1>

              {/* Subheadline */}
              <p className="text-lg md:text-xl text-slate-400 mb-4 max-w-2xl mx-auto">
                Get a personalized cybersecurity roadmap, recommended certifications, hands-on labs, and clear next steps — tailored to your goals.
              </p>

              {/* Trust line */}
              <p className="text-sm text-slate-500 mb-10">
                Built for students and career changers who are tired of guessing what to do next.
              </p>

              {/* CTAs */}
              <div className="flex flex-col sm:flex-row gap-4 justify-center">
                <a
                  href="#waitlist"
                  className="inline-flex items-center justify-center px-8 py-4 text-base font-semibold text-slate-950 bg-cyan-400 hover:bg-cyan-300 rounded-xl transition-all shadow-lg shadow-cyan-500/25"
                >
                  Get My Free Roadmap
                  <ArrowRightIcon className="w-5 h-5 ml-2" />
                </a>
                <a
                  href="#how-it-works"
                  className="inline-flex items-center justify-center px-8 py-4 text-base font-semibold text-slate-300 bg-slate-800 hover:bg-slate-700 border border-slate-700 rounded-xl transition-all"
                >
                  See How It Works
                </a>
              </div>
            </div>
          </div>
        </section>

        {/* ============================================================ */}
        {/* SECTION 2 — PROBLEM                                          */}
        {/* ============================================================ */}
        <section className="py-20 bg-slate-900">
          <div className="container mx-auto px-4 md:px-6">
            <div className="max-w-4xl mx-auto">
              <div className="text-center mb-12">
                <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">
                  Sound familiar?
                </h2>
                <p className="text-slate-400 text-lg max-w-xl mx-auto">
                  Most people trying to break into cybersecurity face the same three problems.
                </p>
              </div>

              <div className="grid md:grid-cols-3 gap-6 mb-12">
                <div className="bg-slate-800/60 border border-slate-700 rounded-2xl p-6">
                  <div className="text-2xl mb-3">🤔</div>
                  <p className="text-slate-300 font-medium">
                    &ldquo;I don&apos;t know which certification to get first.&rdquo;
                  </p>
                </div>
                <div className="bg-slate-800/60 border border-slate-700 rounded-2xl p-6">
                  <div className="text-2xl mb-3">😩</div>
                  <p className="text-slate-300 font-medium">
                    &ldquo;I&apos;ve watched hours of videos but still don&apos;t know where to start.&rdquo;
                  </p>
                </div>
                <div className="bg-slate-800/60 border border-slate-700 rounded-2xl p-6">
                  <div className="text-2xl mb-3">😰</div>
                  <p className="text-slate-300 font-medium">
                    &ldquo;I&apos;m scared I&apos;m wasting time learning the wrong things.&rdquo;
                  </p>
                </div>
              </div>

              <div className="text-center">
                <p className="text-cyan-400 font-semibold text-lg">
                  CyberLaunch AI was built for exactly this moment.
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* ============================================================ */}
        {/* SECTION 3 — ABOUT ROD                                        */}
        {/* ============================================================ */}
        <section id="about" className="py-20 bg-slate-950">
          <div className="container mx-auto px-4 md:px-6">
            <div className="max-w-5xl mx-auto">
              <div className="text-center mb-12">
                <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">
                  Built by a graduate Computer Science student navigating the cybersecurity journey.
                </h2>
              </div>

              <div className="flex flex-col md:flex-row items-center gap-10 bg-slate-900 border border-slate-800 rounded-2xl p-8 md:p-12">
                {/* Profile photo */}
                <div className="flex-shrink-0">
                  <div className="w-40 h-40 rounded-full overflow-hidden border-4 border-cyan-500/40 shadow-xl shadow-cyan-500/10">
                    <Image
                      src="/images/rod-profile.jpeg"
                      alt="Rod Raemon Alvero"
                      width={160}
                      height={160}
                      className="w-full h-full object-cover"
                      priority
                    />
                  </div>
                </div>

                {/* Bio */}
                <div className="flex-1 text-center md:text-left">
                  <h3 className="text-2xl font-bold text-white mb-1">
                    Rod Raemon Alvero
                  </h3>
                  <p className="text-cyan-400 font-medium mb-2">
                    Graduate Computer Science Student
                  </p>

                  {/* Email — directly below title */}
                  <a
                    href="mailto:rodraemon.alvero@cstu.edu"
                    className="inline-flex items-center gap-2 text-slate-400 hover:text-cyan-400 text-sm transition-colors mb-4"
                  >
                    <MailIcon className="w-4 h-4 flex-shrink-0" />
                    rodraemon.alvero@cstu.edu
                  </a>

                  <p className="text-slate-400 text-sm mb-5">
                    Focused on Cybersecurity, AI, and Cloud Technologies
                  </p>
                  <p className="text-slate-300 leading-relaxed">
                    I am a graduate Computer Science student focused on cybersecurity, AI, cloud technologies, and hands-on security projects. I created CyberLaunch AI to help students and career changers avoid the confusion I experienced when navigating certifications, labs, projects, and cybersecurity career paths. This is the guidance I wish I had when I started.
                  </p>

                  {/* Social links */}
                  <div className="flex items-center gap-4 mt-4 justify-center md:justify-start">
                    <a
                      href="https://linkedin.com/in/rodraemonalvero"
                      target="_blank"
                      rel="noopener noreferrer"
                      aria-label="LinkedIn profile"
                      className="w-9 h-9 rounded-full bg-slate-800 flex items-center justify-center text-slate-400 hover:text-cyan-400 hover:bg-slate-700 transition-colors"
                    >
                      <LinkedInIcon className="w-4 h-4" />
                    </a>
                    <a
                      href="https://github.com/rodraemon"
                      target="_blank"
                      rel="noopener noreferrer"
                      aria-label="GitHub profile"
                      className="w-9 h-9 rounded-full bg-slate-800 flex items-center justify-center text-slate-400 hover:text-cyan-400 hover:bg-slate-700 transition-colors"
                    >
                      <GitHubIcon className="w-4 h-4" />
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* ============================================================ */}
        {/* SECTION 4 — FEATURES                                         */}
        {/* ============================================================ */}
        <section id="features" className="py-20 bg-slate-900">
          <div className="container mx-auto px-4 md:px-6">
            <div className="max-w-6xl mx-auto">
              <div className="text-center mb-16">
                <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">
                  Everything you need. In one place.
                </h2>
                <p className="text-slate-400 text-lg max-w-2xl mx-auto">
                  CyberLaunch AI replaces weeks of scattered research with a single guided session and a clear, personalized action plan.
                </p>
              </div>

              <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
                {/* Feature 1 */}
                <div className="bg-slate-800/50 border border-slate-700 hover:border-cyan-600 rounded-2xl p-6 transition-all hover:shadow-lg hover:shadow-cyan-500/10">
                  <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-cyan-500 to-blue-600 flex items-center justify-center text-white mb-4">
                    <MapIcon className="w-6 h-6" />
                  </div>
                  <h3 className="text-lg font-bold text-white mb-2">Personalized Cybersecurity Roadmap</h3>
                  <p className="text-slate-400 text-sm">
                    Your 30-, 60-, and 90-day learning plan built around your background, goals, and available time.
                  </p>
                </div>

                {/* Feature 2 */}
                <div className="bg-slate-800/50 border border-slate-700 hover:border-cyan-600 rounded-2xl p-6 transition-all hover:shadow-lg hover:shadow-cyan-500/10">
                  <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center text-white mb-4">
                    <BadgeIcon className="w-6 h-6" />
                  </div>
                  <h3 className="text-lg font-bold text-white mb-2">Certification Advisor</h3>
                  <p className="text-slate-400 text-sm">
                    Know exactly which certifications to pursue — Security+, CySA+, Google Cybersecurity, and more — and why each one matters for your path.
                  </p>
                </div>

                {/* Feature 3 */}
                <div className="bg-slate-800/50 border border-slate-700 hover:border-cyan-600 rounded-2xl p-6 transition-all hover:shadow-lg hover:shadow-cyan-500/10">
                  <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center text-white mb-4">
                    <TerminalIcon className="w-6 h-6" />
                  </div>
                  <h3 className="text-lg font-bold text-white mb-2">Homelab &amp; Project Recommendations</h3>
                  <p className="text-slate-400 text-sm">
                    Hands-on labs and beginner-friendly projects on TryHackMe, Hack The Box, Splunk, Wazuh, and Kali Linux that build real, resume-worthy skills.
                  </p>
                </div>

                {/* Feature 4 */}
                <div className="bg-slate-800/50 border border-slate-700 hover:border-cyan-600 rounded-2xl p-6 transition-all hover:shadow-lg hover:shadow-cyan-500/10">
                  <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-purple-500 to-pink-600 flex items-center justify-center text-white mb-4">
                    <ClipboardIcon className="w-6 h-6" />
                  </div>
                  <h3 className="text-lg font-bold text-white mb-2">Interview Preparation Coach</h3>
                  <p className="text-slate-400 text-sm">
                    Practice SOC Analyst and Cybersecurity Analyst interview questions. Technical scenarios, behavioral prep, and role-specific coaching.
                  </p>
                </div>

                {/* Feature 5 */}
                <div className="bg-slate-800/50 border border-slate-700 hover:border-cyan-600 rounded-2xl p-6 transition-all hover:shadow-lg hover:shadow-cyan-500/10 md:col-span-2 lg:col-span-1">
                  <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-amber-500 to-orange-500 flex items-center justify-center text-white mb-4">
                    <CompassIcon className="w-6 h-6" />
                  </div>
                  <h3 className="text-lg font-bold text-white mb-2">Career Guidance Assistant</h3>
                  <p className="text-slate-400 text-sm">
                    Understand cybersecurity roles, career paths, and what employers actually want — so you can build experience that moves the needle.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* ============================================================ */}
        {/* SECTION 5 — HOW IT WORKS                                     */}
        {/* ============================================================ */}
        <section id="how-it-works" className="py-20 bg-slate-950">
          <div className="container mx-auto px-4 md:px-6">
            <div className="max-w-4xl mx-auto">
              <div className="text-center mb-16">
                <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">
                  From confusion to clarity in one session.
                </h2>
                <p className="text-slate-400 text-lg max-w-xl mx-auto">
                  No more scattered research. No more guessing. Just a clear, personalized plan.
                </p>
              </div>

              <div className="grid md:grid-cols-3 gap-8 mb-14">
                {/* Step 1 */}
                <div className="text-center">
                  <div className="w-14 h-14 rounded-2xl bg-cyan-950 border border-cyan-800 flex items-center justify-center text-cyan-400 text-xl font-bold mx-auto mb-4">
                    1
                  </div>
                  <h3 className="text-white font-semibold text-lg mb-2">Tell us about yourself</h3>
                  <p className="text-slate-400 text-sm">
                    Answer a few questions about your background, experience level, career goals, and available time for learning.
                  </p>
                </div>

                {/* Step 2 */}
                <div className="text-center">
                  <div className="w-14 h-14 rounded-2xl bg-cyan-950 border border-cyan-800 flex items-center justify-center text-cyan-400 text-xl font-bold mx-auto mb-4">
                    2
                  </div>
                  <h3 className="text-white font-semibold text-lg mb-2">Get your personalized roadmap</h3>
                  <p className="text-slate-400 text-sm">
                    CyberLaunch AI generates your roadmap — target role, certifications, labs, projects, and a 30/60/90-day action plan.
                  </p>
                </div>

                {/* Step 3 */}
                <div className="text-center">
                  <div className="w-14 h-14 rounded-2xl bg-cyan-950 border border-cyan-800 flex items-center justify-center text-cyan-400 text-xl font-bold mx-auto mb-4">
                    3
                  </div>
                  <h3 className="text-white font-semibold text-lg mb-2">Follow your plan</h3>
                  <p className="text-slate-400 text-sm">
                    Execute step by step — certifications, labs, projects, and interview prep — with a clear answer to &ldquo;What should I do next?&rdquo;
                  </p>
                </div>
              </div>

              {/* What you receive */}
              <div className="bg-slate-900 border border-slate-800 rounded-2xl p-8">
                <h3 className="text-white font-bold text-lg mb-5 text-center">What you receive — free</h3>
                <div className="grid sm:grid-cols-2 gap-3">
                  {[
                    "Personalized cybersecurity career roadmap",
                    "Recommended certifications with explanations",
                    "Hands-on lab and project recommendations",
                    "Suggested learning resources",
                    "30-, 60-, and 90-day action plan",
                    "Clear answer to: What should I do next?",
                  ].map((item) => (
                    <div key={item} className="flex items-center gap-3 text-sm text-slate-300">
                      <CheckIcon className="w-4 h-4 text-cyan-400 flex-shrink-0" />
                      {item}
                    </div>
                  ))}
                </div>
              </div>

              <div className="text-center mt-10">
                <a
                  href="#waitlist"
                  className="inline-flex items-center justify-center px-8 py-4 text-base font-semibold text-slate-950 bg-cyan-400 hover:bg-cyan-300 rounded-xl transition-all shadow-lg shadow-cyan-500/25"
                >
                  Get My Free Roadmap
                  <ArrowRightIcon className="w-5 h-5 ml-2" />
                </a>
              </div>
            </div>
          </div>
        </section>

        {/* ============================================================ */}
        {/* SECTION 6 — COMING SOON / WAITLIST                           */}
        {/* ============================================================ */}
        <section id="waitlist" className="py-20 bg-slate-900">
          <div className="container mx-auto px-4 md:px-6">
            <div className="max-w-2xl mx-auto text-center">
              {/* Coming soon badge */}
              <div className="inline-flex items-center gap-2 bg-cyan-950/60 border border-cyan-800 text-cyan-400 px-4 py-1.5 rounded-full text-sm font-medium mb-6">
                <span className="relative flex h-2 w-2">
                  <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-cyan-400 opacity-75" />
                  <span className="relative inline-flex rounded-full h-2 w-2 bg-cyan-500" />
                </span>
                Coming Soon
              </div>

              <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">
                Be First In Line
              </h2>
              <p className="text-slate-400 text-lg mb-10">
                Join the waitlist to get early access to CyberLaunch AI and receive updates as new features are released.
              </p>

              {/* Waitlist form — client component handles onSubmit */}
              <WaitlistForm />

              <p className="text-slate-500 text-xs">
                No spam. Just updates on CyberLaunch AI progress and early access invitations.
              </p>
            </div>
          </div>
        </section>

        {/* ============================================================ */}
        {/* SECTION 7 — CTA FOOTER                                       */}
        {/* ============================================================ */}
        <section className="py-20 bg-slate-950 relative overflow-hidden">
          <div className="absolute inset-0 -z-10">
            <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[300px] bg-cyan-500/5 rounded-full blur-3xl" />
          </div>
          <div className="container mx-auto px-4 md:px-6">
            <div className="max-w-3xl mx-auto text-center">
              <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">
                Stop guessing your cybersecurity path.
              </h2>
              <p className="text-slate-400 text-lg mb-10">
                Get a personalized roadmap built for your goals — free.
              </p>
              <a
                href="#waitlist"
                className="inline-flex items-center justify-center px-10 py-4 text-base font-semibold text-slate-950 bg-cyan-400 hover:bg-cyan-300 rounded-xl transition-all shadow-lg shadow-cyan-500/25"
              >
                Get My Free Roadmap
                <ArrowRightIcon className="w-5 h-5 ml-2" />
              </a>
            </div>
          </div>
        </section>

        {/* ============================================================ */}
        {/* CONTACT SECTION                                               */}
        {/* ============================================================ */}
        <section id="contact" className="py-16 bg-slate-900 border-t border-slate-800">
          <div className="container mx-auto px-4 md:px-6">
            <div className="max-w-2xl mx-auto text-center">
              <h2 className="text-2xl md:text-3xl font-bold text-white mb-2">
                Get in Touch
              </h2>
              <p className="text-slate-400 text-sm mb-8">
                Questions about CyberLaunch AI? Reach out directly.
              </p>

              <div className="bg-slate-800/60 border border-slate-700 rounded-2xl p-8 inline-block text-left w-full">
                <p className="text-white font-bold text-lg mb-1">Rod Raemon Alvero</p>
                <p className="text-slate-400 text-sm mb-4">
                  Graduate Computer Science Student | Aspiring Cybersecurity Analyst
                </p>
                <a
                  href="mailto:rodraemon.alvero@cstu.edu"
                  className="inline-flex items-center gap-2 text-cyan-400 hover:text-cyan-300 text-sm font-medium transition-colors"
                >
                  <MailIcon className="w-4 h-4 flex-shrink-0" />
                  rodraemon.alvero@cstu.edu
                </a>
              </div>
            </div>
          </div>
        </section>

        {/* ============================================================ */}
        {/* FOOTER                                                        */}
        {/* ============================================================ */}
        <footer className="py-8 bg-slate-950 border-t border-slate-800">
          <div className="container mx-auto px-4 md:px-6">
            <div className="flex flex-col md:flex-row items-center justify-between gap-4">
              <div className="flex items-center gap-2">
                <div className="w-6 h-6 rounded bg-gradient-to-br from-cyan-500 to-blue-600 flex items-center justify-center text-white font-bold text-xs">
                  CL
                </div>
                <span className="text-sm text-slate-400">
                  © {new Date().getFullYear()} CyberLaunch AI · Rod Raemon Alvero
                </span>
              </div>
              <div className="flex items-center gap-6">
                <a
                  href="mailto:rodraemon.alvero@cstu.edu"
                  className="text-sm text-slate-500 hover:text-cyan-400 transition-colors"
                >
                  rodraemon.alvero@cstu.edu
                </a>
                <a href="#" className="text-sm text-slate-500 hover:text-slate-300 transition-colors">
                  Privacy Policy
                </a>
              </div>
            </div>
          </div>
        </footer>

      </main>
    </>
  );
}
