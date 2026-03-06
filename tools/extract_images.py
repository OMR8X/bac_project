#!/usr/bin/env python3
"""
Extract all embedded images from a PDF file.

Usage:
    python3 tools/extract_images.py <pdf_path> [--output <dir>] [--min-size <px>]

Examples:
    python3 tools/extract_images.py "./my_quiz.pdf"
    python3 tools/extract_images.py "./my_quiz.pdf" --output ./out
    python3 tools/extract_images.py "./my_quiz.pdf" --min-size 100



    
# Basic — creates a folder next to the PDF with the same name
python3 tools/extract_images.py "./path/to/quiz.pdf"

# Custom output folder
python3 tools/extract_images.py "./quiz.pdf" --output ./my_folder

# Filter out small icons/logos (recommended)
python3 tools/extract_images.py "./quiz.pdf" --min-size 150

# Help
python3 tools/extract_images.py --help



"""

import argparse
import os
import sys
from typing import Optional

try:
    import fitz  # PyMuPDF
except ImportError:
    print("Error: PyMuPDF is not installed. Run: pip3 install PyMuPDF")
    sys.exit(1)


def extract_images(pdf_path: str, output_dir: Optional[str] = None, min_size: int = 0):
    if not os.path.isfile(pdf_path):
        print(f"Error: File not found: {pdf_path}")
        sys.exit(1)

    pdf_name = os.path.splitext(os.path.basename(pdf_path))[0]

    if output_dir is None:
        output_dir = os.path.join(os.path.dirname(os.path.abspath(pdf_path)), pdf_name)

    os.makedirs(output_dir, exist_ok=True)

    doc = fitz.open(pdf_path)
    total_pages = len(doc)
    total_extracted = 0
    total_skipped = 0

    print(f"PDF:    {os.path.basename(pdf_path)}")
    print(f"Pages:  {total_pages}")
    print(f"Output: {output_dir}")
    if min_size > 0:
        print(f"Filter: Skipping images smaller than {min_size}x{min_size}px")
    print("-" * 50)

    for page_num in range(total_pages):
        page = doc[page_num]
        images = page.get_images(full=True)

        for img_index, img in enumerate(images):
            xref = img[0]
            base_image = doc.extract_image(xref)
            image_bytes = base_image["image"]
            image_ext = base_image["ext"]
            width = base_image["width"]
            height = base_image["height"]

            # Filter small images (icons, logos, decorative)
            if min_size > 0 and (width < min_size or height < min_size):
                total_skipped += 1
                continue

            filename = f"p{page_num + 1}_img{img_index + 1}.{image_ext}"
            filepath = os.path.join(output_dir, filename)

            with open(filepath, "wb") as f:
                f.write(image_bytes)

            total_extracted += 1
            print(f"  ✓ {filename}  ({width}x{height})")

    doc.close()

    print("-" * 50)
    print(f"Extracted: {total_extracted} images")
    if total_skipped > 0:
        print(f"Skipped:   {total_skipped} images (below {min_size}x{min_size}px)")
    print(f"Saved to:  {output_dir}")


def main():
    parser = argparse.ArgumentParser(
        description="Extract all embedded images from a PDF file.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python3 tools/extract_images.py "./quiz.pdf"
  python3 tools/extract_images.py "./quiz.pdf" --output ./my_images
  python3 tools/extract_images.py "./quiz.pdf" --min-size 150
        """,
    )
    parser.add_argument(
        "pdf",
        help="Path to the PDF file",
    )
    parser.add_argument(
        "--output", "-o",
        help="Output directory (default: folder named after the PDF, next to it)",
        default=None,
    )
    parser.add_argument(
        "--min-size", "-m",
        type=int,
        default=0,
        help="Minimum width/height in pixels. Images smaller than this are skipped (useful to filter icons/logos). Default: 0 (no filter)",
    )

    args = parser.parse_args()
    extract_images(args.pdf, args.output, args.min_size)


if __name__ == "__main__":
    main()
