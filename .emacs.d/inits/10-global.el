;;; 10-global --- inits
;;; Commentary:

;;; Code:

;; PATH
;; https://github.com/purcell/exec-path-from-shell
(when (require 'exec-path-from-shell nil t)
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

;; language
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; keybinds
(global-set-key [end] 'end-of-buffer)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key "\C-cn" 'narrow-to-region)
(global-set-key "\C-cw" 'widen)
(global-set-key "\C-c\C-r" 'revert-buffer)
(global-set-key "\C-cc" 'comment-region)

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

;; Highlight region
(setq transient-mark-mode t)

;; The width of tab/indent to 4.
(setq-default c-basic-offset 4
              tab-width 4
              standard-indent 4
              indent-tabs-mode nil)

;; flash nil
(setq visible-bell nil)

;; The boot image is non-displayed.
(setq inhibit-startup-message t)

;; "yes or no" => "y or n"
(fset 'yes-or-no-p 'y-or-n-p)

;; delete auto save files when quit Emacs
(setq delete-auto-save-files t)

;; dont create backup files
(setq backup-inhibited t)

;; Font-lock
(global-font-lock-mode t)
(setq font-lock-support-mode 'jit-lock-mode
      jit-lock-stealth-verbose nil
      font-lock-verbose nil
      font-lock-maximum-decoration t)

;; display date/time in mode line
(progn
  (setq display-time-string-forms
        '((let ((system-time-locale "en"))
            (format-time-string "%Y-%m-%d (%a) %H:%M" now))))
  (display-time))

;; default encoding
(set-default-coding-systems 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
;; (set-clipboard-coding-system 'utf-8-unix)
;; (set-file-name-coding-system 'utf-8-unix)

;; not display error message
(setq debug-on-error nil)

(put 'narrow-to-region 'disabled nil)

;; revert-mode
;; info: 自動的に最新に
(add-hook 'after-init-hook 'global-auto-revert-mode)

;; load .customized
(setq custom-file "~/.emacs.d/etc/.customized")
(add-hook 'after-init-hook
          (lambda ()
            (load custom-file t)))

;; recentf-mode
(when (require 'recentf nil t)
  (setq recentf-save-file "~/.emacs.d/tmp/.recentf"))

;;; 10-global.el ends here
