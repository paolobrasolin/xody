(TeX-add-style-hook
 "test"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("xy" "all")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "xy"))
 :latex)

