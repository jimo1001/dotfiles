;;; 50-textmodes --- inits
;;; Commentary:

;;; Code:

;; YAML
(when (locate-library "yaml-mode")
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

;; SCSS
(when (locate-library "scss-mode")
  (add-to-list 'auto-mode-alist '("\\.\\(css\\|scss\\)\\'" . scss-mode)))

;; JSON
(when (locate-library "json-mode")
  (add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
  (with-eval-after-load "json-mode"
    (add-hook 'json-mode-hook
              '(lambda ()
                 (auto-complete-mode t)
                 (make-local-variable 'js-indent-level)
                 (setq-local js-indent-level 2)))))

;;; 50-textmodes.el ends here
