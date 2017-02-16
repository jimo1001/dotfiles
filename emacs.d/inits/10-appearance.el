;;; inits --- Emacs Appearance Settings
;;; Commentary:

;;; Code:

(use-package use-package
  :no-require t
  :init
  ;; Emacs startup message
  (setq inhibit-startup-screen t)
  ;; Ignore ring-bell
  (setq ring-bell-function 'ignore)
  ;; Enable region highlighting
  (setq transient-mark-mode t)

  :config
  (delete-selection-mode t)
  ;; Display column number
  (column-number-mode t))


;; non-displayed tool bar
(use-package tool-bar
  :if window-system
  :config
  (tool-bar-mode 0))

;; non-displayed menu bar
(use-package menu-bar
  :config
  (menu-bar-mode 0))

;; The scroll bar is non-displayed.
(use-package scroll-bar
  :if window-system
  :config
  (scroll-bar-mode 0))

;; Enable syntax highlighting
(use-package font-lock
  :no-require t
  :init
  (setq font-lock-support-mode 'jit-lock-mode
        jit-lock-stealth-verbose nil
        font-lock-verbose nil
        font-lock-maximum-decoration t)
  :config
  (global-font-lock-mode t))

;; Display line number
(use-package linum
  :defer t
  :bind ("C-c C-n" . linum-mode)
  :init
  (setq linum-format "%6d ")
  :config
  (custom-set-faces
   '(linum ((t (:foreground "#5c5c5c"))))))

;; Enable cursor highlighting
(use-package hl-line+
  :config
  (custom-set-faces
   '(hl-line ((t (:background "#261212" :foreground nil)))))
  (hl-line-when-idle-interval 0.3)
  (hl-line-toggle-when-idle))

;; Enable matching parens highlighting
(use-package paren
  :config
  (setq show-paren-style 'mixed)
  (show-paren-mode t))

;; whitespace highlighting
(use-package whitespace
  :diminish (whitespace-mode global-whitespace-mode)
  :config
  (setq whitespace-style '(face tabs spaces trailing newline indentation tab-mark))
  (custom-set-faces
   '(whitespace-empty ((t (:background "#8b8b00" :foreground "#b22222"))))
   '(whitespace-indentation ((t (:background "#121212" :foreground "#5c5c5c"))))
   '(whitespace-space ((t (:foreground "#5c5c5c"))))
   '(whitespace-space-after-tab ((t (:background "#8b8b00" :foreground "#b22222"))))
   '(whitespace-tab ((t (:background "#262626" :foreground "#5c5c5c"))))
   '(whitespace-trailing ((t (:inherit trailing-whitespace)))))
  (global-whitespace-mode t))


;;; Theme

(use-package cus-face
  :init
  (setq custom-theme-directory (locate-user-emacs-file "share/theme/"))
  :config
  (load-theme 'simple-dark t)
  (enable-theme 'simple-dark))


;;; Window

;; Window Control
(use-package shackle
  :config
  (setq shackle-select-reused-windows t
        ;;shackle-default-rule '(:align below :select t :size 0.5)
        shackle-rules '(("*Buffer List*" :align below :select t :size 0.5)
                        ("*Help*" :align below :select t :size 0.5)
                        ("*Faces*" :align right :select t :size 0.5)
                        ("*Colors*" :align right :select t :size 0.5)
                        ("*Compile-Log*" :align below :select nil :size 0.3)))
  (shackle-mode 1))


;;; Mode-Line

;; display number of current matches.
(use-package anzu
  :diminish (anzu-mode global-anzu-mode)
  :config
  (custom-set-faces
   '(anzu-mode-line ((t (:foreground "#ffd700" :background nil :weight normal)))))
  (global-anzu-mode +1))

;; like powerline
(use-package powerline
  :init
  (setq powerline-default-separator 'box)
  (setq powerline-height nil)
  (setq powerline-text-scale-factor nil)
  :config
  (custom-set-faces
   '(mode-line ((t (:background "#262626" :foreground "#a8a8a8"))))
   '(mode-line-buffer-id ((t (:inherit mode-line :foreground "#cfcfcf"))))
   '(mode-line-emphasis ((t (:inherit mode-line :weight bold))))
   '(mode-line-highlight ((t (:inherit mode-line :foreground "#fcfcfc" :weight bold))))
   '(mode-line-inactive ((t (:inherit mode-line :foreground "#909090" :weight light))))
   '(powerline-active1 ((t (:inherit mode-line :background "#b0b0b0" :foreground "#303030"))))
   '(powerline-active2 ((t (:inherit mode-line :background "#262626" :foreground "#909090"))))
   '(powerline-inactive1 ((t (:inherit powerline-active1 :foreground "#606060" :weight light))))
   '(powerline-inactive2 ((t (:inherit powerline-active2 :foreground "#606060" :weight light)))))
  (powerline-default-theme))


;;; 10-appearance.el ends here
