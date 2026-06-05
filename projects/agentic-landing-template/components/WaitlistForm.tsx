"use client";

export function WaitlistForm() {
  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const form = e.currentTarget;
    const email = (form.elements.namedItem("email") as HTMLInputElement)?.value;
    // Placeholder — wire up to your email service (Resend, Mailchimp, etc.)
    alert(`Thanks! We'll reach out to ${email} when CyberLaunch AI launches.`);
    form.reset();
  };

  return (
    <form
      className="flex flex-col sm:flex-row gap-3 max-w-md mx-auto mb-4"
      onSubmit={handleSubmit}
    >
      <input
        type="email"
        name="email"
        placeholder="Enter your email address"
        className="flex-1 px-4 py-3 rounded-xl bg-slate-800 border border-slate-700 text-white placeholder-slate-500 focus:outline-none focus:border-cyan-500 transition-colors text-sm"
        required
        aria-label="Email address"
      />
      <button
        type="submit"
        className="px-6 py-3 bg-cyan-500 hover:bg-cyan-400 text-slate-950 font-semibold rounded-xl transition-colors text-sm whitespace-nowrap"
      >
        Join the Waitlist
      </button>
    </form>
  );
}
