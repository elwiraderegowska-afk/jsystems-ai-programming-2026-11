"""Extract the text layer of a PDF, page by page, for verbatim table checks.

Usage: <venv-python> -I pdf_extract.py <input.pdf> <output.txt>
Needs pypdf in the interpreter's environment (see SKILL.md, step 1).
"""
import sys

import pypdf


def main() -> None:
    if len(sys.argv) != 3:
        sys.exit("usage: pdf_extract.py <input.pdf> <output.txt>")
    reader = pypdf.PdfReader(sys.argv[1])
    with open(sys.argv[2], "w", encoding="utf-8") as out:
        for number, page in enumerate(reader.pages, 1):
            out.write(f"\n===== PAGE {number} =====\n")
            out.write(page.extract_text() or "")
    print(f"pages: {len(reader.pages)} -> {sys.argv[2]}")


if __name__ == "__main__":
    main()
