# LaTeX templates for thesis and its proceeding

Unofficial LaTeX templates for graduation thesis and its proceeding in School of Informatics and Data Science and Graduate School of Advanced Science and Engineering, Hiroshima University.

## Usage

- `bachelor-proc` (in preparation): LaTeX template for writing 2-page proceeding of graduation thesis for bachelor students
- `bachelor-thesis` : LaTeX template for writing graduation thesis for bachelor students
- `master-proc` (in preparation): LaTeX template for writing 5-page proceeding (plus up to 1 page of references) of graduation thesis for master students
- `master-thesis` (in preparation): LaTeX template for writing graduation thesis for master students


## How to build

### With BibTeX

- `ptex2pdf -> pbibtex -> ptex2pdf`


### Without BibTeX

- `ptex2pdf * 2`

## Recommendation

Add the following to the `setting.json` in VSCode:

```json
{
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.latex.autoBuild.run": "never",
    "latex-workshop.latex.clean.fileTypes": [
        "*.blg", "*.idx", "*.ind", "*.lof", "*.lot", "*.out", "*.toc", "*.acn", "*.acr", "*.alg", "*.glg", "*.glo", "*.gls", "*.ist", "*.fls", "*.log", "*.fdb_latexmk", "*.synctex.gz",
        // for Beamer files
        "_minted*", "*.nav", "*.snm", "*.vrb",
    ],
    "latex-workshop.latex.tools": [
        {
            "name": "latexmk",
            "command": "latexmk",
        },
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        },
        {
            "name": "bibtex",
            "command": "bibtex",
            "args": [
                "%DOCFILE%"
            ]
        },
        {
            "name":"ptex2pdf",
            "command": "ptex2pdf",
            "args": [
                "-l",
                "-ot",
                "-kanji=utf8 -synctex=1",
                "%DOC%"
            ]
        },
        {
            "name": "pbibtex",
            "command": "pbibtex",
            "args": [
                "-kanji=utf8",
                "%DOCFILE%"
            ]
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "pdflatex -> bibtex -> pdflatex*2",
            "tools": [
                "pdflatex",
                "bibtex",
                "pdflatex",
                "pdflatex"
            ]
        },
        {
            "name": "pdflatex*2",
            "tools": [
                "pdflatex",
                "pdflatex"
            ]
        },
        {
            "name": "ptex2pdf -> pbibtex -> ptex2pdf*2",
            "tools": [
                "ptex2pdf",
                "pbibtex",
                "ptex2pdf",
                "ptex2pdf"
            ]
        },
        {
            "name": "latexmk",
            "tools": [
                "latexmk"
            ]
        },
        {
            "name": "ptex2pdf*2",
            "tools": [
                "ptex2pdf",
                "ptex2pdf"
            ]
        },
    ]
}
```
