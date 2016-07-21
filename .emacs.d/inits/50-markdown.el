;;; 50-markdown --- inits
;;; Commentary:

;;; Code:

;; Markdown

(when (functionp 'markdown-mode)
  (setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist)))

;; reStructuredText
(when (functionp 'rst-mode)
  (setq auto-mode-alist
        (append '(("\\.rst\\'" . rst-mode)
                  ("\\.rest\\'" . rst-mode)) auto-mode-alist))
  (with-eval-after-load "rst-mode"
    (define-key rst-mode-map (kbd "C-c .") 'rst-toc)))

;;; 50-markdown.el ends here
