;;; 50-misc --- inits
;;; Commentary:

;;; Code:

;; カーソルが遅くなる問題の対処(emacs-24から)
(when emacs24-p
  (progn
    (setq-default bidi-display-reordering nil)))

;; info: 選択範囲内でインデント
(defun indent-selector ()
  (interactive)
  (progn
    (if mark-active
        (indent-region (region-beginning) (region-end) nil)
      (indent-for-tab-command))))
(global-set-key (kbd "C-i") 'indent-selector)

;; describe face at point
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

;; 折り返し表示ON/OFF
(defun toggle-truncate-lines ()
  "折り返し表示をトグル動作します."
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

;; delete the empty file
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (= (point-min) (point-max)))
    (when (y-or-n-p "Delete file and kill buffer?")
      (delete-file
       (buffer-file-name (current-buffer)))
      (kill-buffer (current-buffer)))))

;; When open the folder, don't make a new buffer.
(defvar my-dired-before-buffer nil)
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
  (when (functionp 'mic-paren)
    (setq paren-match-face 'bold)
    ;; (setq paren-match-face 'underline)
    (setq paren-sexp-mode t)
    (setq parse-sexp-ignore-comments t)
    (with-eval-after-load "mic-paren"
      (paren-activate))))

;; highlight paren
(show-paren-mode t)
(setq show-paren-style 'mixed)
(set-face-attribute 'show-paren-match nil
                    :foreground "#e5e5e5"
                    :background "#008700"
                    :underline nil
                    :bold t)

;; match-paren
(global-set-key (kbd "C-c C-o") 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; redo
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)
;; undo-tree
(push '(" *undo-tree*" :width 0.3 :position right) popwin:special-display-config)

;; linum-mode
(setq linum-format "%6d ")
(global-set-key (kbd "C-c C-n") 'linum-mode)
;;(global-linum-mode t)
(add-hook 'linum-mode-hook
          (lambda ()
            ;; face
            (set-face-attribute 'linum nil
                                :foreground "#303030"
                                :background "#000000"
                                :underline nil
                                :bold nil)))

;; hl-line.el
;; info: highlight cursor line.
(when (functionp 'hl-line-mode)
  (copy-face 'highlight 'my-hl-line)
  (set-face-attribute 'my-hl-line nil :background "#1c1c1c" :foreground nil)
  (setq hl-line-face 'my-hl-line)
  (global-hl-line-mode t))

;; cua-mode
(cua-mode t)
(transient-mark-mode 1)
(setq cua-keep-region-after-copy nil)
(setq cua-enable-cua-keys nil)
(define-key cua--region-keymap (kbd "C-c RET") 'cua-set-rectangle-mark)
(set-face-attribute 'cua-rectangle nil
                    :foreground "#e5e5e5"
                    :background "#af005f"
                    :underline nil
                    :bold nil)

;; region
;; expand-region.el
(when (functionp 'er/expand-region)
  (global-set-key (kbd "C-SPC") 'er/expand-region)
  (global-set-key (kbd "C-@") 'er/expand-region)
  (global-set-key (kbd "C-M-@") 'er/contract-region)

  (defadvice er/expand-region (around er-set-mark activate)
    (if (not mark-active)
        (cua-set-mark)
      ad-do-it)))
(when (functionp 'wrap-region-mode)
  (wrap-region-global-mode))

;; backward-delete-char-untabify
(defadvice backward-delete-char-untabify
    (around ys:backward-delete-region activate)
  (if (and transient-mark-mode mark-active)
      (delete-region (region-beginning) (region-end))
    ad-do-it))
(global-set-key (kbd "C-h") 'backward-delete-char-untabify)

;; tramp
(setq tramp-default-method "ssh")

;; develock
;; highlight spaces
(setq develock-auto-enable nil)

;; w3m
(setq w3m-icon-directory "~/.emacs.d/etc/w3m/icons")

;; Use Emacs23's eldoc
(setq eldoc-idle-delay 0)
(setq eldoc-echo-area-use-multiline-p t)

;; decodeUrl
(defun url-decode-region (start end)
  "Replace a region with the same contents, only URL decoded."
  (interactive "r")
  (let ((text (url-unhex-string (buffer-substring start end))))
    (delete-region start end)
    (insert text)))

;; \C-aでインデントを飛ばした行頭に移動
(defun beginning-of-indented-line (current-point)
  "インデント文字を飛ばした行頭に戻る。ただし、ポイントから行頭までの間にインデント文字しかない場合は、行頭に戻る。"
  (interactive "d")
  (if (string-match
       "^[ ¥t]+$"
       (save-excursion
         (buffer-substring-no-properties
          (progn (beginning-of-line) (point))
          current-point)))
      (beginning-of-line)
    (back-to-indentation)))

(defadvice move-beginning-of-line
    (around move-beginnging-of-indented-line activate)
  (beginning-of-indented-line (point)))

;; direx
;; src: https://github.com/m2ym/direx-el
;; doc: http://cx4a.blogspot.com/2011/12/popwineldirexel.html
;; (install-elisp "https://raw.github.com/m2ym/direx-el/master/direx.el")
(setq direx:leaf-icon "  "
      direx:open-icon "- "
      direx:closed-icon "+ ")
;; direx:direx-modeのバッファをウィンドウ左辺に幅25でポップアップ
;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
;; ポップアップ前のウィンドウに移譲される
(push '(direx:direx-mode :position left :width 30 :dedicated t)
      popwin:special-display-config)
;; keybind
(global-set-key (kbd "C-c C-d") 'direx:jump-to-directory-other-window)

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; mark-multiple.el
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)

;; scroll bar
(when (functionp 'yascroll-bar-mode)
  (global-yascroll-bar-mode 1))

;; all
(when (functionp 'all-completions)
  (require 'all-ext nil t)
  (push '("*All*" :regexp t :height .5) popwin:special-display-config))

;; emoji
;; (when (require 'emojify nil t)
;;   (global-emojify-mode))
(when (functionp 'emoji-fontset/turn-on)
  (emoji-fontset/turn-on))

;;; 50-misc.el ends here
