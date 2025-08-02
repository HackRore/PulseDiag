# SmartDiag OS

This is a bootable USB toolkit for laptop technicians. It includes hardware diagnostics, performance testing, AI-assisted troubleshooting, and automated reporting.

## How to Use

1.  Boot from the SmartDiag OS USB drive.
2.  The main menu will appear. Choose a diagnostic scan to run.
3.  Reports will be saved to the `logs` directory on the USB drive.
4.  After a `deepcheck` scan, an AI-powered analysis will be automatically appended to the report.

## AI-Assisted Troubleshooting

The `deepcheck.sh` script now includes an AI-powered troubleshooter. This feature analyzes the diagnostic report and provides suggestions for resolving any issues that are found.

### How it Works

The `ai_troubleshooter.py` script is called at the end of the `deepcheck.sh` script. It takes the generated report as input and uses a language model to generate suggestions.

### Offline Mode

If the AI model is not available (e.g., no internet connection), the script will fall back to a rule-based system to provide basic suggestions.

## Dependencies

The AI features in SmartDiag OS rely on the following:

*   **Python 3**: The `ai_troubleshooter.py` script is written in Python 3.
*   **AI Model**: The script is designed to work with a large language model. By default, it uses a placeholder. To use a real AI model, you will need to configure the `ai_troubleshooter.py` script with your API key and endpoint.
*   **`requests` library**: If you are using a cloud-based AI model, you will need to install the `requests` library.

```bash
pip install requests
```

## Licensing

SmartDiag OS is an open-source project. The scripts and documentation are licensed under the MIT License.

The diagnostic tools included in this distribution are licensed under their respective licenses. Please consult the documentation for each tool for more information.
