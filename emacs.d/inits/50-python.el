;;; inits --- Python
;;; Commentary:

;;; Code:

(use-package python-mode
  :mode ("\\.py\\'" . python-mode)
  :bind (:map python-mode-map ("C-a" . move-beginning-of-line))
  :config
  (setq expand-region-preferred-python-mode 'python-mode)
  (pyvenv-workon "default")
  (pyvenv-tracking-mode t)
  (add-hook 'python-mode-hook
            #'(lambda ()
                (py-autopep8-enable-on-save)
                (make-local-variable 'company-backends)
                (push '(company-jedi :with company-yasnippet) company-backends))))

(use-package python-environment
  :defer t
  :config
  (setq python-environment-directory (getenv "WORKON_HOME")))

(use-package pyvenv
  :defer t
  :config
  (setq pyvenv-tracking-mode t))

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
