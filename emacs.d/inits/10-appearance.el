;;; inits --- Emacs Appearance Settings
;;; Commentary:

;;; Code:

;; Emacs startup message
(setq inhibit-startup-screen t)

;; Ignore ring-bell
(setq ring-bell-function 'ignore)

;; Enable region highlighting
(setq transient-mark-mode t)

(setq delete-selection-mode t)

;; Display column number
(setq column-number-mode t)

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

;; Enable matching parens highlighting
(use-package paren
  :config
  (setq show-paren-style 'mixed)
  (show-paren-mode t))

;; whitespace highlighting
(use-package whitespace
  :diminish (whitespace-mode global-whitespace-mode)
  :config
  (setq whitespace-style '(face tabs spaces indentation indentation::space indentation::tab trailing newline tab-mark space-mark newline-mark))
  (setq whitespace-display-mappings
        '(
          ;;(space-mark ?\  [?_] [?.])
          ;;(space-mark ?\  [?␣] [?.])
          (space-mark ?\  [?·] [?.])
          (space-mark ?\xA0 [?¤] [?_])
          (newline-mark ?\n [?⏎ ?\n] [?$ ?\n])
          (tab-mark ?\t [?⌘ ?\t] [?\\ ?\t])))
  (custom-set-faces
   '(whitespace-empty ((t (:background "#8b8b00" :foreground "#b22222"))))
   '(whitespace-indentation ((t (:background "#121212" :foreground "#5c5c5c"))))
   '(whitespace-space ((t (:foreground "#303030"))))
   '(whitespace-newline ((t (:foreground "#363636"))))
   '(whitespace-space-after-tab ((t (:background "#8b8b00" :foreground "#b22222"))))
   '(whitespace-tab ((t (:background "#262626" :foreground "#5c5c5c"))))
   '(whitespace-trailing ((t (:inherit trailing-whitespace)))))

  ;; for company-mode
  (defvar my-prev-whitespace-mode nil)
  (make-variable-buffer-local 'my-prev-whitespace-mode)
  (defun pre-popup-draw ()
    "Turn off whitespace mode before showing company complete tooltip"
    (if (or whitespace-mode global-whitespace-mode)
        (progn
          (setq my-prev-whitespace-mode t)
          (whitespace-mode -1)
          (setq my-prev-whitespace-mode t))))
  (defun post-popup-draw ()
    "Restore previous whitespace mode after showing company tooltip"
    (if my-prev-whitespace-mode
        (progn
          (whitespace-mode 1)
          (setq my-prev-whitespace-mode nil))))
  (advice-add 'company-pseudo-tooltip-unhide :before #'pre-popup-draw)
  (advice-add 'company-pseudo-tooltip-hide :after #'post-popup-draw)

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
        shackle-rules '(("*Buffer List*" :align below :select t :size 0.5)
                        ("*Help*" :align below :select t :size 0.5)
                        ("*Faces*" :align right :select t :size 0.5)
                        ("*Colors*" :align right :select t :size 0.5)
                        ("*Compile-Log*" :align below :ignore t :size 0.3)))
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
  (setq powerline-default-separator 'utf-8)
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

;; (use-package cyphejor
;;   :init
;;   (setq cyphejor-rules
;;       '(:upcase
;;           ("bookmark"    "")
;;           ("buffer"      "")
;;           ("diff"        "")
;;           ("dired"       "")
;;           ("emacs"       "")
;;           ("go"          "")
;;           ("fundamental" "")
;;           ("interaction" "" :prefix)
;;           ("interactive" "" :prefix)
;;           ("lisp"        "λ" :postfix)
;;           ("mode"        "")
;;           ("package"     "")
;;           ("python"      "")
;;           ("shell"       "" :postfix)
;;           ("web"         "")
;;           ("js2"         "")
;;           ("js"          "")
;;           ("mustash"     "")
;;           ("text"        "")
;;           ("folder"      "")))
;;   :config
;;   (cyphejor-mode 1))


;;; 10-appearance.el ends here
