;;; 50-python --- inits
;;; Commentary:

;;; Code:
(when (locate-library "python")
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))

  (with-eval-after-load "python-mode"
    ;; jedi
    (when (locate-library "jedi")
      (setq jedi:complete-on-dot t)
      (add-hook 'python-mode-hook 'jedi:setup))

    ;; pylint
    (when (executable-find "pylint")
      (load-library "pylint")
      ;; http://pylint-messages.wikidot.com/all-messages
      ;; C0103: Invalid name "%s" (should match %s)
      ;; C0111: Missing docstring
      ;; E1101: %s %r has no %r member
      (setq pylint-options "-f parseable -d C0103,C0111,E1101,C0301"))

    ;; mode-hook
    (add-hook 'python-mode-hook
              (lambda ()
                (local-unset-key (kbd "C-c :"))))
    (define-key python-mode-map (kbd "C-a") 'move-beginning-of-line)
    (set-face-attribute 'py-pseudo-keyword-face nil :foreground "#5faf5f")
    (set-face-attribute 'py-builtins-face nil :foreground "#5fafd7")
    (set-face-attribute 'py-class-name-face nil :foreground "#d7875f")))

;;; 50-python.el ends here
