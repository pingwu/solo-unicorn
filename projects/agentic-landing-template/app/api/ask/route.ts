import { GoogleGenerativeAI } from "@google/generative-ai";

const genAI = new GoogleGenerativeAI(
  process.env.GEMINI_API_KEY || ""
);

export async function POST(req: Request) {
  try {
    const { question } = await req.json();

    const model = genAI.getGenerativeModel({
      model: "gemini-1.5-flash",
    });

    const prompt = `
You are CyberLaunch AI.

Only answer cybersecurity career questions.

Topics:
- SOC Analyst
- Security+
- Network+
- Splunk
- SIEM
- Blue Team
- TryHackMe
- Cybersecurity career roadmap
- Certifications
- Entry-level cybersecurity jobs

Keep responses under 150 words.
`;

    const result = await model.generateContent(
      `${prompt}\n\nQuestion: ${question}`
    );

    const response = result.response.text();

    return Response.json({
      answer: response,
    });
  } catch (error) {
    console.error(error);

    return Response.json({
      answer:
        "CyberLaunch AI is temporarily unavailable. For beginners, Security+ and hands-on labs such as TryHackMe are excellent starting points."
    });
  }
}