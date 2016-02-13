;;; 50-textmodes --- inits
;;; Commentary:

;;; Code:

;; YAML
(when (autoload-if-found 'yaml-mode "yaml-mode" "Major mode to edit SGML files." t)
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

;; SCSS
(when (autoload-if-found 'scss-mode "scss-mode" "SCSS mode" t)
  (add-to-list 'auto-mode-alist '("\\.\\(css\\|scss\\)\\'" . scss-mode)))

;; JSON
(when (autoload-if-found 'json-mode "json-mode" "JSON mode" t)
  (add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
  (eval-after-load "json-mode"
    (add-hook 'json-mode-hook
              '(lambda ()
                 (auto-complete-mode t)
                 (make-local-variable 'js-indent-level)
                 (setq js-indent-level 2)))))


;;; 50-textmodes.el ends here
