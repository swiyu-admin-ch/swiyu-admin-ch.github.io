import os
import requests
import urllib3
from markitdown import MarkItDown

# Suppress InsecureRequestWarning caused by bypassing SSL verification
# This is necessary for environments with corporate proxies.
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# Define the specifications to process
SPECS = [
    {
        "name": "W3C DID Core v1.0",
        "url": "https://www.w3.org/TR/did-core/",
        "output": "did-core-v1.0.md"
    },
    {
        "name": "W3C Digital Credentials",
        "url": "https://www.w3.org/TR/digital-credentials/",
        "output": "digital-credentials.md"
    },
    {
        "name": "did:webvh Method Specification",
        "url": "https://identity.foundation/didwebvh/v1.0/",
        "output": "did-webvh-v1.0.md"
    }
]

def main():
    print("Initializing Markdown Converter...\n")
    md_converter = MarkItDown()
    temp_html_file = "temp_spec.html"

    for spec in SPECS:
        print(f"Processing: {spec['name']}")

        try:
            # 1. Download the HTML directly, bypassing SSL verification
            print(f"  -> Downloading from {spec['url']}")
            response = requests.get(spec['url'], verify=False)
            response.raise_for_status() # Ensure we got a successful HTTP response

            # 2. Save the HTML to a temporary local file
            with open(temp_html_file, "w", encoding="utf-8") as f:
                f.write(response.text)

            # 3. Convert the local HTML file to Markdown using MarkItDown
            print("  -> Converting to Markdown...")
            result = md_converter.convert(temp_html_file)

            # 4. Save the final Markdown output
            with open(spec['output'], "w", encoding="utf-8") as f:
                f.write(result.text_content)

            print(f"  -> Success! Saved as {spec['output']}\n")

        except Exception as e:
            print(f"  -> Error processing {spec['name']}: {e}\n")

    # Clean up the temporary HTML file after processing all specs
    if os.path.exists(temp_html_file):
        os.remove(temp_html_file)

    print("Batch conversion completed!")

if __name__ == "__main__":
    main()