

# ai_troubleshooter.py
#
# This script provides AI-assisted troubleshooting suggestions based on a diagnostic report.
# It can interact with an external AI model or fall back to rule-based suggestions if offline.

import argparse
import json
import os
import re

# --- AI Model Interaction ---
def call_ai_model(report_content):
    """
    Calls an AI model to get troubleshooting suggestions.
    This is a placeholder and should be replaced with a real API call.
    """
    print("Attempting to get suggestions from AI model...")

    if os.getenv("AI_OFFLINE") == "true":
        print("AI model is offline. Returning None.")
        return None

    # A more sophisticated prompt for the AI
    prompt = f"""
    As a Level 3 IT Support Technician, analyze the following PulseDiag OS diagnostic report.
    Provide a concise, expert analysis of the potential issues and recommend specific, actionable steps for a field technician.
    Structure your response with the following Markdown headings:
    - ### Summary of Issues
    - ### Recommended Actions

    If no significant issues are found, state that clearly.

    Here is the report:
    ---
    {report_content}
    ---
    """

    # MOCK RESPONSE: In a real implementation, you would send the prompt to a model API.
    # This mock logic simulates a response based on keywords.
    if re.search(r"fail|error|critical|reallocated_sector_ct", report_content, re.IGNORECASE):
        return """### Summary of Issues
The diagnostic report indicates a critical failure of the primary storage device (`/dev/sda`). The SMART self-assessment has failed, and there are multiple uncorrectable errors and reallocated sectors. This suggests the drive is physically failing.

### Recommended Actions
1.  **Immediate Data Backup**: Before proceeding, back up all user data from the drive if possible.
2.  **Drive Replacement**: The drive is not reliable and must be replaced.
3.  **Verify New Drive**: After installation, run a `quickcheck` on the new drive to ensure it is functioning correctly.
"""
    else:
        return """### Summary of Issues
No critical hardware failures were automatically detected by the AI model. The system appears to be in a healthy state based on the provided diagnostics.

### Recommended Actions
- If the user is still reporting issues, consider running software-level diagnostics or checking for OS-level corruption.
- A manual review of the full report is always recommended for subtle issues.
"""

# --- Rule-Based Fallback Logic ---
def get_rule_based_suggestions(report_content):
    """
    Provides suggestions based on a predefined set of rules.
    """
    print("AI model unavailable. Using rule-based fallback.")
    suggestions = []
    
    # Rule 1: Storage Drive Failure (SMART)
    if "SMART overall-health self-assessment test result: FAILED" in report_content:
        suggestions.append("- **Critical Storage Failure**: The SMART self-assessment failed. The drive is likely failing. Prioritize data backup and replace the drive.")
    elif "Reallocated_Sector_Ct" in report_content and int(re.search(r"Reallocated_Sector_Ct\s+.*\s+(\d+)", report_content).group(1)) > 5:
        suggestions.append("- **Storage Drive Warning**: The drive has reallocated sectors, which is an early sign of degradation. Monitor the drive closely and recommend a backup.")

    # Rule 2: Overheating
    if re.search(r"temperature.*(critical|high)", report_content, re.IGNORECASE):
        suggestions.append("- **Overheating Detected**: System temperatures are high. Check cooling system (fans, vents) for dust and proper function. Verify fan rotation.")

    # Rule 3: Memory Errors
    if "memtester" in report_content and "ok" not in report_content.lower():
         suggestions.append("- **Memory Errors**: The memory test reported errors. Reseat the RAM modules. If errors persist, test modules individually to identify the faulty stick.")

    # Rule 4: Filesystem Almost Full
    if re.search(r"(\d+)%\s+/", report_content):
        for match in re.finditer(r"(\d+)%\s+/", report_content):
            if int(match.group(1)) > 95:
                suggestions.append("- **Filesystem Capacity**: The root filesystem is over 95% full, which can cause performance issues and prevent the OS from booting. Free up disk space.")

    # Rule 5: Kernel I/O Errors
    if re.search(r"ata.*(error|failed command)", report_content, re.IGNORECASE):
        suggestions.append("- **Disk I/O Errors**: The kernel log shows read/write errors for a storage device. This often confirms a hardware issue. Check cable connections and the drive itself.")

    if not suggestions:
        return "### Basic Troubleshooting Suggestions\n\nNo specific issues were flagged by the automated rules. Please review the report manually."

    return "### Basic Troubleshooting Suggestions\n\n" + "\n".join(suggestions)


def main():
    parser = argparse.ArgumentParser(description="Analyzes a SmartDiag report and provides troubleshooting suggestions.")
    parser.add_argument("report_path", help="The absolute path to the diagnostic report file.")
    args = parser.parse_args()

    if not os.path.exists(args.report_path):
        print(f"Error: Report file not found at {args.report_path}")
        return

    with open(args.report_path, 'r') as f:
        report_content = f.read()

    ai_suggestions = call_ai_model(report_content);

    if ai_suggestions:
        final_suggestions = "## AI Analysis\n" + ai_suggestions
    else:
        final_suggestions = get_rule_based_suggestions(report_content)
    
    print("\n--- Analysis Complete ---")
    print(final_suggestions)
    
    with open(args.report_path, 'a') as f:
        f.write('\n\n---\n')
        f.write(final_suggestions)


if __name__ == "__main__":
    main()

