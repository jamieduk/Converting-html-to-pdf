# HTML to PDF Converter

A lightweight Linux command-line script for converting HTML files to PDF using **Chromium, Google Chrome or Brave**.

The conversion is performed using a real Chromium-based browser engine, helping preserve the original HTML appearance including:

* CSS styling
* Tables
* Borders and boxes
* Rounded corners
* Gradients
* Colours
* Images
* SVG graphics
* Flexbox
* CSS Grid
* Web fonts
* JavaScript-rendered content
* Print CSS
* A4 page layouts

## Features

* Simple command-line interface
* Automatically detects an installed Chromium-based browser
* Automatically generates the PDF filename
* Preserves the original filename
* Removes the input file extension automatically
* Adds `.pdf`
* No output filename needs to be specified
* Uses headless browser rendering
* Supports local HTML files
* Suitable for invoices, reports, forms and other styled documents

## Requirements

One of the following browsers must be installed:

* Chromium
* Google Chrome
* Brave

The script checks for them in this order:

1. Google Chrome
2. Google Chrome Stable
3. Chromium
4. Chromium Browser
5. Brave

### Install Chromium on Ubuntu/Debian

```bash
sudo apt install -y chromium
```

## Installation

Make the script executable:

```bash
chmod +x convert-html-to-pdf.sh
```

You can then run it directly:

```bash
./convert-html-to-pdf.sh invoice.html
```

## Usage

```text
./convert-html-to-pdf.sh filename
```

The output filename is generated automatically.

### Example

Input:

```text
invoice.html
```

Command:

```bash
./convert-html-to-pdf.sh invoice.html
```

Output:

```text
invoice.pdf
```

Another example:

```text
monthly-report.html
```

becomes:

```text
monthly-report.pdf
```

The script removes whatever extension is present and replaces it with `.pdf`.

## Directory Example

Given:

```text
documents/
├── invoice.html
├── report.html
├── convert-html-to-pdf.sh
└── stylesheet.css
```

Running:

```bash
./convert-html-to-pdf.sh invoice.html
```

produces:

```text
documents/
├── invoice.html
├── invoice.pdf
├── report.html
├── convert-html-to-pdf.sh
└── stylesheet.css
```

## HTML and CSS

For the best visual results, use print-specific CSS.

For example:

```css
@page{
    size:A4;
    margin:0;
}

@media print{
    body{
        margin:0;
    }
}
```

It is also recommended to include:

```css
*{
    box-sizing:border-box;
}

html,
body{
    -webkit-print-color-adjust:exact;
    print-color-adjust:exact;
}
```

This helps ensure that backgrounds, colours and other visual elements are retained in the generated PDF.

## Browser Rendering

The script uses Chromium's headless PDF renderer rather than attempting to interpret HTML itself.

This means the document is rendered using a browser engine before being converted to PDF.

The following options are used:

```text
--headless=new
--disable-gpu
--disable-dev-shm-usage
--print-to-pdf
--no-pdf-header-footer
--run-all-compositor-stages-before-draw
--virtual-time-budget=3000
```

The virtual time budget gives JavaScript and dynamically generated content time to render before the PDF is created.

## Local Files

Local HTML files can be converted directly:

```bash
./convert-html-to-pdf.sh invoice.html
```

Images referenced by the HTML can also be loaded when they are accessible from the local document.

For example:

```html
<img src="images/logo.png" alt="Company Logo">
```

A local stylesheet can similarly be referenced:

```html
<link rel="stylesheet" href="css/invoice.css">
```

## Output Location

The PDF is created in the same directory as the input HTML file.

For example:

```text
/home/jay/Documents/invoice.html
```

becomes:

```text
/home/jay/Documents/invoice.pdf
```

The script resolves both paths to absolute paths before starting the browser.

## Filename Handling

The output filename is generated with:

```bash
OUTPUT="${INPUT%.*}.pdf"
```

This removes the final extension from the input filename and adds `.pdf`.

Examples:

| Input            | Output          |
| ---------------- | --------------- |
| `invoice.html`   | `invoice.pdf`   |
| `report.htm`     | `report.pdf`    |
| `document.xhtml` | `document.pdf`  |
| `page.test.html` | `page.test.pdf` |

## Error Handling

The script checks that:

1. An input filename was supplied.
2. The input file exists.
3. A supported browser is installed.
4. The PDF was successfully created.

Example:

```text
Error: HTML file not found: invoice.html
```

or:

```text
Error: Chromium, Chrome or Brave was not found.
Install Chromium with:
sudo apt install -y chromium
```

## Example Workflow

Create an HTML document:

```bash
gedit invoice.html
```

Make the converter executable:

```bash
chmod +x convert-html-to-pdf.sh
```

Convert it:

```bash
./convert-html-to-pdf.sh invoice.html
```

Result:

```text
PDF created:
/path/to/invoice.pdf
```

## Licence

Copyright (c) J~Net 2026.

Provided for personal and commercial use.

---

**J~Net HTML to PDF Converter**

Simple HTML → PDF conversion using a real Chromium-based rendering engine.
