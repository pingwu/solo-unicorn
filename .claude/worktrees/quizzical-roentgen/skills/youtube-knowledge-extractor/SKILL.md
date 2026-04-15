---
name: youtube-knowledge-extractor
description: Extracts key ideas, summaries, and actionable insights from YouTube video links. Use when the user asks to summarize, extract knowledge, analyze content, or get instructions from a YouTube video.
---

# YouTube Knowledge Extractor

## Core Principle

This skill transforms raw YouTube video content into structured, actionable knowledge by distinguishing between general informational content and precise step-by-step instructions. It aims to provide concise summaries and detailed procedural guides as needed.

## Workflow

1.  **Receive Request:** The agent receives a user request to extract knowledge or instructions from a YouTube video URL.
2.  **Fetch Content:** Utilize the `web_fetch` tool to get a summary or transcript of the YouTube video content. The prompt for `web_fetch` should explicitly ask for both a general summary and any step-by-step instructions.
    *   **Example `web_fetch` prompt:** "Summarize the main ideas and extract any step-by-step instructions from this YouTube video: [link]"
3.  **Analyze Content:**
    *   **General Knowledge:** Identify overarching themes, key concepts, theories, and informational content.
    *   **Step-by-Step Instructions:** Look for numbered lists, procedural language (e.g., "first, then, next"), software commands, or any sequence of actions designed to achieve a specific outcome.
4.  **Structure Output:** Based on the analysis, format the output clearly for the user, distinguishing between general knowledge and precise instructions.

## Output Structure

The output should be a Markdown file, suitable for a knowledge base, with distinct sections:

### For General Knowledge

*   **Title:** Derived from the video title or main topic.
*   **Source:** Original YouTube URL.
*   **Summary:** A concise overview of the video's main points.
*   **Key Ideas/Concepts:** Bullet points or a brief section detailing the most important insights or concepts presented.
*   **Context/Application:** (Optional) If applicable, how this knowledge can be used or its broader context.

### For Step-by-Step Instructions

*   **Title:** Clear title indicating the procedure (e.g., "How to [do something]").
*   **Source:** Original YouTube URL.
*   **Prerequisites:** (If mentioned) Any tools, software, or prior knowledge required.
*   **Steps:** A numbered list of actions, each as precise as possible, including specific commands, UI interactions, or configurations.
*   **Expected Outcome:** What should happen after following the steps.
*   **Troubleshooting/Notes:** (If mentioned) Any common issues or additional tips.

### Combined Output

If a video contains both, provide both sections clearly delineated.

## Anti-Patterns

| Anti-Pattern                     | Why It Hurts                                         | Do This Instead                                                                       |
| :------------------------------- | :--------------------------------------------------- | :------------------------------------------------------------------------------------ |
| Generic Summary for Instructions | Misses critical details for execution                 | Explicitly request and parse for numbered steps, commands, and prerequisites.         |
| Overly Verbose Output            | Hard to consume; defeats purpose of knowledge extraction | Be concise. Use bullet points and numbered lists. Summarize rather than transcribe.   |
| Ignoring Video Nuances           | Fails to capture the "why" behind instructions         | Note down context, prerequisites, and expected outcomes when extracting instructions. |

## Power Move

"Extract all key knowledge and any step-by-step instructions from this YouTube video: [link]. Organize the output into distinct sections for general knowledge and procedural steps, suitable for adding directly to my `my_knowledge` folder as a Markdown file."