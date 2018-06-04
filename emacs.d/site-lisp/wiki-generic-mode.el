;;; wiki-generic-mode --- Generic major-mode for wiki files.
;;; Commentary:

;;; Code:

(require 'generic-x)

;; Wiki text files
;;;###autoload
(define-generic-mode wiki-generic-mode
  nil
  '("{{>toc}}" "<pre>" "</pre>" "<code>" "</code>")
  '(("^\\(\*+\\)" 1 font-lock-builtin-face)
    ("^\\(#\\) " 1 font-lock-function-name-face)
    ("\\(|\\)" 1 font-lock-keyword-face)
    ("\\({{>toc}}\\)" 1 font-lock-keyword-face)
    ("\\(\#[0-9]+\\) " 1 font-lock-keyword-face)
    ("^\\(h1\.\\) " 1 font-lock-constant-face)
    ("^\\(h2\.\\) " 1 font-lock-type-face)
    ("^\\(h3\.\\) " 1 font-lock-function-name-face)
    ("^\\(h4\.\\) " 1 font-lock-constant-face)
    ("^\\(h5\.\\) " 1 font-lock-keyword-face))
  '("\\.wiki$")
  nil
  "Generic mode for wiki text files.")
(add-to-list 'generic-extras-enable-list 'wiki-generic-mode t)

;;; wiki-generic-mode.el ends here
