;;; 10-global --- inits
;;; Commentary:

;;; Code:

;; not display error message
(setq debug-on-error nil)

;; PATH
;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Language
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; Global Keybinds
(global-set-key [end] 'end-of-buffer)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key (kbd "C-c n") 'narrow-to-region)
(global-set-key (kbd "C-c w") 'widen)
(global-set-key (kbd "C-c C-r") 'revert-buffer)
(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-h") 'backward-delete-char)

;; non-displayed tool bar
(when (featurep 'tool-bar)
  (when tool-bar-mode
    (tool-bar-mode 0)))

;; non-displayed menu bar
(when (featurep 'menu-bar)
  (when (not window-system)
    (menu-bar-mode 0)))

;; show column number at mode-line
(when (not column-number-mode)
  (column-number-mode t))

;; delete region (C-d)
(when (not delete-selection-mode)
  (delete-selection-mode t))

;; The scroll bar is non-displayed.
(when (featurep 'scroll-bar)
    (scroll-bar-mode 0))

;; auto-save-list saved path.
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)

;; not make backup file
(setq make-backup-files nil)

;; highlight region
(setq transient-mark-mode t)

;; tab/indent width
(setq-default c-basic-offset 4
              tab-width 4
              standard-indent 4
              indent-tabs-mode nil)

;; flash nil
(setq visible-bell nil)

;; Emacs startup message
(setq inhibit-startup-message t)

;; yes/no -> y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; delete auto save files when quit Emacs
(setq delete-auto-save-files t)

;; dont create backup files
(setq backup-inhibited t)

;; enable font-lock-mode
(global-font-lock-mode t)
(setq font-lock-support-mode 'jit-lock-mode
      jit-lock-stealth-verbose nil
      font-lock-verbose nil
      font-lock-maximum-decoration t)

;; display date/time in mode line
(setq display-time-string-forms
      '((let ((system-time-locale "en"))
          (format-time-string "%Y-%m-%d (%a) %H:%M" now))))
(display-time)

;; default encoding
(set-default-coding-systems 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
;; (set-clipboard-coding-system 'utf-8-unix)
;; (set-file-name-coding-system 'utf-8-unix)

(put 'narrow-to-region 'disabled nil)

;; revert-mode
;; auto-revert
(add-hook 'after-init-hook 'global-auto-revert-mode)

;; load .customized
(setq custom-file "~/.emacs.d/etc/.customized")
(add-hook 'after-init-hook
          (lambda ()
            (load custom-file t)))

;; recent files
(setq recentf-max-saved-items 1000)
(setq recentf-save-file "~/.emacs.d/tmp/.recentf")

;;; 10-global.el ends here
