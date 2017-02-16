;;; inits --- JSON
;;; Commentary:

;;; Code:

(use-package json-mode
  :defer t
  :mode ("\\.json\\'" . json-mode)
  :config
  (add-hook 'json-mode-hook
            (lambda ()
              (make-local-variable 'js-indent-level)
              (setq-local js-indent-level 2))))

;;; 50-json.el ends here
