# Specification to Markdown Converter

This tool fetches web-based identity specifications (W3C, DIF) and converts them into clean, LLM-friendly Markdown files. It is explicitly configured to bypass SSL certificate verification to work seamlessly behind corporate proxies.

## Setup (Linux)

**Create and activate a virtual environment:**
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
  ```


**Install dependencies:**

   ```bash
   pip install markitdown requests
  ```

**Usage:**

Ensure your virtual environment is active, then run:

   ```bash
   python3 converter.py
  ```

The script will download and parse the specifications, creating .md files in your current directory.