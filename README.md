Salesforce Opportunity Insights – Apex + LWC

A Salesforce CRM Engineering project that scores Opportunities and surfaces actionable insights for sales teams using Apex, Lightning Web Components (LWC), and unit tests.
This project demonstrates real-world CRM engineering patterns aligned with modern Salesforce development practices.

🚩 Overview

Sales teams often struggle to prioritize deals effectively. This project introduces a lightweight scoring engine that evaluates an Opportunity based on:

Deal size

Sales stage

Lead source

Time to close

CRM funnel risk patterns

It then surfaces:

Score (0–100)

Risk level (High/Medium/Low)

Recommended next step

All displayed dynamically through an LWC on the Opportunity Record Page.

🧠 Core Features
🔹 Apex Backend Logic

Custom scoring algorithm

Business-rule mapping

Risk classification

Actionable recommendations

Fully testable with 90%+ code coverage

🔹 Lightning Web Component (LWC)

Fetches live Opportunity data

Shows score, risk level, and recommendations

Recalculate button refreshes data

Record-aware + responsive

🔹 Apex Unit Tests

High-score scenario

Low-score scenario

Assertions for:

Score

Risk level

Recommendation

Non-null return

🔹 Metadata + Deployable Structure

Full Salesforce DX project format

Works in any Dev Org / Sandbox
