;;; inits --- macOS Cocoa Emacs Settings
;;; Commentary:

;;; Code:

(use-package use-package
  :no-require t
  :if window-system
  :init
  ;; Font
  (set-face-attribute 'default nil :family "Ricty Discord NF" :height 120)
  (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Ricty Discord NF" :height 120)))

;; C/Migemo
(use-package migemo
  :defer t
  :no-require t
  :init
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict"
        migemo-coding-system 'utf-8-unix))

;;; cocoa-emacs-env.el ends here
