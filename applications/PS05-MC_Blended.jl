### A Pluto.jl notebook ###
# v0.20.13

using Markdown
using InteractiveUtils

# ╔═╡ 993ef63e-c094-11f1-05ba-55dc4d04e34c
md"""
# 🎲 The Monte Carlo AI Sandbox

### 🎯 Your Goal
Build a functional Monte Carlo simulation in **Julia** to model uncertainty and optimize a decision in a domain of your choice.

To complete this assignment within the blended learning window, **you are explicitly encouraged to use AI tools** (ChatGPT, Claude, Copilot, Gemini) as a coding assistant, brainstorming partner, and debugging tool.

### 🛠️️ The Workflow (4 Steps)

> **[1. Define System]** $\rightarrow$  **[2. AI Co-Pilot Coding]** $\rightarrow$  **[3. Run & Experiment]** $\rightarrow$  **[4. Synthesis]**

!!! info "Workflow"
	1. **Pick a Domain:** Choose an area below or invent your own. Define what is random (input) and what you want to measure (output).
	2. **AI-Assisted Implementation:** Prompt an AI to generate the baseline Julia code, test it in this notebook, and refine it.
	3. **Run & Analyze (40 mins):** Run $N \ge 10,000$ iterations. Plot distributions (histograms/ECDFs) and evaluate risk metrics (mean, 95th percentile, tail risks).
	4. **Synthesis & Pitch (30 mins):** Document your findings directly below.

## 💡 Choose Your Domain

Pick **one** of these application ideas, or create your own:

* **🎮 Game Strategy & Odds:** Model 10,000 games/turns of a game (e.g., Monopoly movement probabilities, Battleship optimal firing patterns, Poker hand win rates, or board game combat resolution).
* **🚀 Mission & Project Schedules:** Simulate a multi-stage project pipeline (e.g., satellite launch window, software sprint, or supply chain route) where step durations follow random distributions (PERT/Beta/LogNormal) to calculate on-time completion probability.
* **🏥 Queueing Systems & Operations:** Model peak-hour congestion at an airport security checkpoint, hospital emergency room, or EV charging plaza to find the minimum capacity needed to prevent long wait times (see also DES).
* **🎯 Geometric Monte Carlo & Physics:** Estimate an irregular 2D/3D surface area, volume, or spatial coverage (e.g., satellite field of view over ground targets, orbital collision risk geometry) using uniform spatial sampling.

## 📝 Worksheet

### Step 1: System Definition
* **Selected Problem:** *[Write 1-2 sentences describing the problem]*
* **Input Random Variables (Uncertainty):** *[e.g., $X \sim \text{Normal}(\mu, \sigma)$]*
* **Decision Metric / Output:** *[e.g., 95th percentile worst-case wait time]*

### Step 2: Implementation & Plotting
*(Write your simulation function and plot code in the code cells directly below this block)*

### Step 3: Key Results & AI Reflection

* **Key Insights:**  
  *[What non-obvious insight did the distribution reveal that simply taking the average values would miss?]*

* **AI Collaboration Reflection:**  
  *[How did you use AI during this task? What was one prompt that worked well, and one error/misunderstanding the AI made that you had to fix?]*
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.3"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─993ef63e-c094-11f1-05ba-55dc4d04e34c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
