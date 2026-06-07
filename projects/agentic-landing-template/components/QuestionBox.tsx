"use client";

import { useState } from "react";

export default function QuestionBox() {
  const [question, setQuestion] = useState("");
  const [answer, setAnswer] = useState("");
  const [loading, setLoading] = useState(false);

  async function askQuestion() {
    if (!question) return;

    setLoading(true);

    try {
      const response = await fetch("/api/ask", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          question,
        }),
      });

      const data = await response.json();

      setAnswer(data.answer);
    } catch (error) {
      setAnswer("Something went wrong.");
    }

    setLoading(false);
  }

  return (
    <section className="max-w-4xl mx-auto px-6 py-16">
      <div className="bg-slate-900 rounded-2xl border border-cyan-500 p-8">
        <h2 className="text-3xl font-bold mb-4 text-cyan-400">
          Ask CyberLaunch AI
        </h2>

        <p className="text-gray-300 mb-6">
          Ask cybersecurity career questions and get guidance powered by Gemini.
        </p>

        <textarea
          value={question}
          onChange={(e) => setQuestion(e.target.value)}
          placeholder="Example: What certification should I take first for a SOC Analyst role?"
          className="w-full p-4 rounded-lg bg-slate-800 border border-slate-700 text-white"
          rows={4}
        />

        <button
          onClick={askQuestion}
          className="mt-4 px-6 py-3 rounded-lg bg-cyan-500 text-black font-semibold"
        >
          {loading ? "Thinking..." : "Ask AI"}
        </button>

        {answer && (
          <div className="mt-6 p-4 rounded-lg bg-slate-800 text-white">
            {answer}
          </div>
        )}
      </div>
    </section>
  );
}