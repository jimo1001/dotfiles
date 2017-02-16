;;; inits --- Emacs Lisp
;;; Commentary:

;;; Code:

(use-package elisp-mode
  :defer t
  :mode ("\\.el\\'" . emacs-lisp-mode)
  :config
  (dolist (hook '(emacs-lisp-mode-hook lisp-interaction-mode-hook))
    (add-hook hook #'(lambda () (eldoc-mode +1)))))

(use-package eldoc
  :defer t
  :diminish (eldoc-mode global-eldoc-mode)
  :init
  (setq eldoc-idle-delay 0.5
        eldoc-echo-area-use-multiline-p t)
  :config
  (add-hook 'after-init-hook #'(lambda () (global-eldoc-mode +1))))

;;; 50-elisp.el ends here
