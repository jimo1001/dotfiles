;;; inits --- Golang
;;; Commentary:

;;; Code:

(use-package go-mode
  :defer t
  :mode ("\\.go\\'" . go-mode)
  :bind (:map go-mode-map
              ("M-." . godef-jump)
              ("C-c %" . go-rename))
  :init
  (setq gofmt-command "goimports")
  :config
  (use-package company-go)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook
            '(lambda ()
               (go-eldoc-setup)
               (make-local-variable 'company-backends)
               (push '(company-go :with company-yasnippet) company-backends))))

(use-package go-eldoc :defer t)

;;; 50-go.el ends here
