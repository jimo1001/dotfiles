;;; inits --- Auto Completion
;;; Commentary:

;;; Code:

(use-package company
  :defer 1
  :diminish company-mode
  :bind (("C-c . c" . company-mode-on)
         :map company-active-map
         ("C-h" . nil)
         ("C-n" . company-select-next-or-abort)
         ("C-p" . company-select-previous-or-abort)
         ("C-s" . company-filter-candidates)
         ("C-i" . company-complete-selection)
         :map company-search-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         :map emacs-lisp-mode-map
         ("C-M-i" . company-complete))
  :init
  (setq company-minimum-prefix-length 2
        company--auto-completion t
        company-tooltip-align-annotations t)

  :config
  (custom-set-faces
   '(company-preview ((t (:background "##8a0f00" :foreground "#90ee90"))))
   '(company-preview-common ((t (:inherit company-preview :foreground "#1e90ff"))))
   '(company-scrollbar-bg ((t (:background "#121212"))))
   '(company-scrollbar-fg ((t (:background "#1e90ff"))))
   '(company-template-field ((t (:background "#e5e5e5" :foreground "#5f0000"))))
   '(company-tooltip ((t (:background "#262626" :foreground "#e5e5e5"))))
   '(company-tooltip-annotation ((t (:foreground "#90ee90"))))
   '(company-tooltip-common ((t (:foreground "#1e90ff"))))
   '(company-tooltip-selection ((t (:background "#5f0000")))))
  (yas-global-mode +1)
  (defun my-elisp-company-backends ()
    "Custom company backend for `emacs-lisp-mode`."
    (set (make-local-variable 'company-backends)
         '((company-yasnippet
            company-capf
            company-elisp
            company-dabbrev-code
            company-gtags
            company-etags
            company-keywords))))
  (add-hook 'emacs-lisp-mode-hook 'my-elisp-company-backends)
  (add-hook 'lisp-interaction-mode-hook 'my-elisp-company-backends)
  (setq company-backends '((company-semantic :with company-yasnippet)
                           company-capf
                           company-files
                           (company-dabbrev-code
                            company-gtags company-etags
                            company-keywords)
                           company-oddmuse
                           company-dabbrev))

  ;; enable company-mode
  (global-company-mode)
  (company-statistics-mode))

(use-package company-etags
  :defer t
  :init
  (setq company-etags-everywhere t))

(use-package company-gtags :defer t)

(use-package company-elisp :defer t)

(use-package company-dabbrev
  :defer t
  :init
  (setq company-dabbrev-minimum-length 2
        company-dabbrev-downcase nil))

(use-package company-dabbrev-code
  :defer t
  :init
  (setq company-dabbrev-code-modes t
        company-dabbrev-code-everywhere t))

(use-package company-statistics
  :defer t
  :config
  (setq company-transformers
        '(company-sort-by-statistics
          company-sort-by-backend-importance)))

(use-package company-yasnippet :defer t)

;;; 30-completion.el ends here
