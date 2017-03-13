;;; inits --- Emacs Basic Settings
;;; Commentary:

;;; Code:

;; key bindings
(bind-key "C-c n" 'narrow-to-region)
(bind-key "C-c w" 'widen)
(bind-key "C-c r" 'revert-buffer)
(bind-key "C-c c" 'comment-region)
(bind-key "C-h" 'backward-delete-char)

;; simplify message on the scratch buffer at startup.
(setq initial-scratch-message ";;; *scratch*\n\n")

;; use space when indent
(setq indent-tabs-mode nil)

;; yes/no -> y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; Disable backup file creation
(setq backup-inhibited t
      make-backup-files nil)

;; Disable auto-save files
(setq auto-save-list-file-name nil
      auto-save-list-file-prefix nil
      auto-save-default nil
      delete-auto-save-files t)

(use-package abbrev-mode
  :defer t
  :init
  (setq abbrev-file-name "~/tmp/abbrev_defs"))

;; recent files
(use-package recentf
  :config
  (setq recentf-max-saved-items 1000))

;; undo/redo
(use-package undo-tree
  :diminish (undo-tree-mode global-undo-tree-mode)
  :bind (("C-/" . undo-tree-undo)
         ("M-/" . undo-tree-redo))
  :config
  (global-undo-tree-mode t))

;; Auto revert buffer
(use-package autorevert
  :diminish (auto-revert-mode global-auto-revert-mode)
  :config
  (global-auto-revert-mode))

(use-package smartparens
  :diminish (smartparens-mode smartparens-global-mode)
  :config
  (smartparens-global-mode t))

;; C/Migemo -- incremental searches by ro-maji
(use-package migemo
  :defer t
  :if (executable-find "cmigemo")
  :init
  (setq migemo-command "cmigemo"
        migemo-options '("-q" "--emacs")
        migemo-user-dictionary nil
        migemo-regex-dictionary nil
        migemo-coding-system 'utf-8-unix
        search-whitespace-regexp nil)
  :config
  (setq anzu-use-migemo t)
  (eval-after-load "migemo"
    #'(progn
        (migemo-init))))


;;; Region

(use-package cua-base
  :init
  (setq cua-keep-region-after-copy nil)
  (setq cua-enable-cua-keys nil)
  :config
  (custom-set-faces
   '(cua-rectangle ((t (:inherit region :background "#af005f" :foreground "#e5e5e5" :underline nil :weight normal)))))
  (cua-mode +1)
  (transient-mark-mode 1))

(use-package expand-region
  :bind (("C-SPC" . er/expand-region)
         ("C-M-@" . er/contract-region))
  :init
  (defun ad-er/expand-region (orig-fun &rest args)
    (if mark-active
        (apply orig-fun args)
      (cua-set-mark)))
  (advice-add 'er/expand-region :around #'ad-er/expand-region))


;;; 10-basic.el ends here
