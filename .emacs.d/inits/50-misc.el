;;; 50-misc --- inits
;;; Commentary:

;;; Code:

;; カーソルが遅くなる問題の対処(emacs-24から)
(when emacs24-p
  (setq-default bidi-display-reordering nil))

;; scratch
(setq scratch-save-file-path "~/.emacs.d/tmp/.scratch")

;; describe face at point
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

;;; dired
(setq dired-dwim-target t)
(setq dired-recursive-copies 'always)
(setq dired-isearch-filenames t)(defvar my-dired-before-buffer nil)

;; When open the folder, don't make a new buffer.
(defadvice dired-find-file
    (before kill-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))

(defadvice dired-find-file
    (after kill-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))

(defadvice dired-up-directory
    (before kill-up-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))

(defadvice dired-up-directory
    (after kill-up-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))

;; kill-summary
(global-set-key (kbd "C-c M-y") 'kill-summary)

;; show-paren-mode
(when window-system
  (when (locate-library "mic-paren")
    (setq paren-match-face 'bold)
    ;; (setq paren-match-face 'underline)
    (setq paren-sexp-mode t)
    (setq parse-sexp-ignore-comments t)
    (with-eval-after-load "mic-paren"
      (paren-activate))))

;; highlight paren
(when (locate-library "paren")
  (show-paren-mode t)
  (setq show-paren-style 'mixed))

;; undo/redo
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)
(when (special-variable-p 'popwin:special-display-config)
  (push '(" *undo-tree*" :width 0.3 :position right) popwin:special-display-config))

;; linum-mode
(when (locate-library "linum")
  (setq linum-format "%6d ")
  ;;(global-linum-mode t)
  (global-set-key (kbd "C-c C-n") 'linum-mode))

;; hl-line.el
;; info: highlight cursor line.
(when (locate-library "hl-line")
  (copy-face 'highlight 'my-hl-line)
  (set-face-attribute 'my-hl-line nil :background "#1c1c1c" :foreground nil)
  (setq hl-line-face 'my-hl-line)
  (global-hl-line-mode t))

;; cua-mode
(when (locate-library "cua-base")
  (setq cua-keep-region-after-copy nil)
  (setq cua-enable-cua-keys nil)
  (cua-mode t)
  (transient-mark-mode 1)
  (define-key cua--region-keymap (kbd "C-c RET") 'cua-set-rectangle-mark))

;; region
;; expand-region.el
(when (locate-library "expand-region")
  (global-set-key (kbd "C-SPC") 'er/expand-region)
  (global-set-key (kbd "C-@") 'er/expand-region)
  (global-set-key (kbd "C-M-@") 'er/contract-region)

  (defadvice er/expand-region (around er-set-mark activate)
    (if (not mark-active)
        (cua-set-mark)
      ad-do-it)))
(when (locate-library "wrap-region")
  (wrap-region-global-mode))

;; tramp
(setq tramp-default-method "ssh")

;; develock
;; highlight spaces
(setq develock-auto-enable nil)

;; w3m
(setq w3m-icon-directory "~/.emacs.d/etc/w3m/icons")

;; eldoc
(setq eldoc-idle-delay 0)
(setq eldoc-echo-area-use-multiline-p t)

;; direx
(setq direx:leaf-icon "  "
      direx:open-icon "- "
      direx:closed-icon "+ ")
(when (special-variable-p 'popwin:special-display-config)
  (push '(direx:direx-mode :position left :width 30 :dedicated t)
        popwin:special-display-config))
(global-set-key (kbd "C-c C-d") 'direx:jump-to-directory-other-window)

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; scroll bar
(when (locate-library "yascroll")
  (global-yascroll-bar-mode 1))

;; all
(when (locate-library "all")
  (require 'all-ext nil t)
  (push '("*All*" :regexp t :height .5) popwin:special-display-config))

;; emoji
;; (when (require 'emojify nil t)
;;   (global-emojify-mode))
(when (locate-library "emoji-fontset")
  (emoji-fontset-enable))

;;; 50-misc.el ends here
