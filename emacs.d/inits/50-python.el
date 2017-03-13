;;; inits --- Python
;;; Commentary:

;;; Code:

(use-package python-mode
  :mode ("\\.py\\'" . python-mode)
  :bind (:map python-mode-map ("C-a" . move-beginning-of-line))
  :init
  ;;(setq expand-region-preferred-python-mode 'python-mode)
  (setq python-environment-directory "~/.pyenv/versions")
  (setq python-environment-default-root-name "py2")
  (setq virtualenv-name "py2")
  :config
  (add-hook 'python-mode-hook
            #'(lambda ()
                (setq pyenv-mode t)
                (py-autopep8-enable-on-save)
                (make-local-variable 'company-backends)
                (push '(company-jedi :with company-yasnippet) company-backends)))
  (add-to-list 'helm-boring-buffer-regexp-list "\\*Python Completions\\*")
  (push '("*Python Completions*" :align below :size 0.2) shackle-rules))

(use-package pyenv-mode
  :defer t
  :init
  (setq py-complete-function nil))

(use-package pyenv-mode-auto
  :defer t
  :functions pyenv-mode-auto)

(use-package py-autopep8 :defer t)

(use-package pylint
  :defer t
  :init
  ;; http://pylint-messages.wikidot.com/all-messages
  ;; C0103: Invalid name "%s" (should match %s)
  ;; C0111: Missing docstring
  ;; W0142: Used * or ** magic
  (setq pylint-options '("--reports=n" "--output-format=parseable" "--disable=W0142,C0103,C0111")))

(use-package company-jedi :defer t)

;;; 50-python.el ends here
