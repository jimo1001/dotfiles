;;; 50-markdown --- inits
;;; Commentary:

;;; Code:

;; Markdown
(when (autoload-if-found 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
  (setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist)))

;; reStructuredText
(when (autoload-if-found 'rst-mode "rst" "reStructuredText mode" t)
  (setq auto-mode-alist
        (append '(("\\.rst\\'" . rst-mode)
                  ("\\.rest\\'" . rst-mode)) auto-mode-alist))
  (eval-after-load "rst"
    '(progn
       (local-set-key (kbd "C-c .") 'rst-toc))))

;;; 50-markdown.el ends here
