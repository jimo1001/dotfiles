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
(global-set-key "\C-i" 'indent-selector)

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
(global-set-key "\C-cl" 'toggle-truncate-lines)

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
(autoload 'kill-summary "kill-summary" nil t)
(define-key global-map "\C-c\M-y" 'kill-summary)

;; show-paren-mode
(when window-system
  (when (require 'mic-paren nil t)
    (eval-after-load "mic-paren"
      (progn
        (setq paren-match-face 'bold)
        ;; (setq paren-match-face 'underline)
        (setq paren-sexp-mode t)
        (setq parse-sexp-ignore-comments t)
        (paren-activate)))))
;; highlight paren
(show-paren-mode t)
(setq show-paren-style 'mixed)
(set-face-attribute 'show-paren-match nil
                            :foreground "#e5e5e5"
                            :background "#008700"
                            :underline nil
                            :bold t)

;; match-paren
(global-set-key "\C-c\C-o" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; redo
(when (require 'undo-tree nil t)
  (global-undo-tree-mode t)
  (global-set-key (kbd "M-/") 'undo-tree-redo)
  ;; undo-tree
  (push '(" *undo-tree*" :width 0.3 :position right) popwin:special-display-config))

;; linum-mode
;; info: 左側に行数を表示
(when (autoload-if-found 'linum-mode "linum" nil t)
  ;; 5桁分のスペースを確保
  (setq linum-format "%6d ")
  ;; keybind
  (global-set-key "\C-c\C-n" 'linum-mode)
  ;;(global-linum-mode t)
  (add-hook 'linum-mode-hook
            (lambda ()
              ;; face
              (set-face-attribute 'linum nil
                                  :foreground "#303030"
                                  :background "#000000"
                                  :underline nil
                                  :bold nil))))

;; hl-line.el
;; info: highlight cursor line.
(when (require 'hl-line nil t)
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
(when (require 'expand-region nil t)
  (global-set-key (kbd "C-SPC") 'er/expand-region)
  (global-set-key (kbd "C-@") 'er/expand-region)
  (global-set-key (kbd "C-M-@") 'er/contract-region)
  (defadvice er/expand-region (around er-set-mark activate)
    (if (not mark-active)
        (cua-set-mark)
      ad-do-it)))
(require 'wrap-region nil t)

;; backward-delete-char-untabify
(defadvice backward-delete-char-untabify
  (around ys:backward-delete-region activate)
  (if (and transient-mark-mode mark-active)
      (delete-region (region-beginning) (region-end))
    ad-do-it))
(global-set-key "\C-h" 'backward-delete-char-untabify)

;; tramp
(when (require 'tramp nil t)
  (setq tramp-default-method "ssh"))

;; develock
;; info: 余分な空白などを強調表示
(when (require 'develock nil t)
  (setq develock-auto-enable nil))

;; background.el
;; info: execute shell command at background.
(autoload 'background "background" nil t)

;; w3m
(when (executable-find "w3m")
  (when (autoload-if-found 'w3m "w3m" nil t)
    (eval-after-load "w3m"
      '(progn
         (setq w3m-icon-directory "~/.emacs.d/etc/w3m/icons")))))

;; Use Emacs23's eldoc
;; (require 'eldoc)
(when (autoload-if-found 'turn-on-eldoc-mode "eldoc" nil t)
  (when (require 'eldoc-extension nil t)
    ;; (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
    ;; (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
    ;; (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
    (setq eldoc-idle-delay 0)
    (setq eldoc-echo-area-use-multiline-p t)))

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
(when (require 'direx nil t)
  ;; icons
  (setq direx:leaf-icon "  "
        direx:open-icon "- "
        direx:closed-icon "+ ")
  ;; direx:direx-modeのバッファをウィンドウ左辺に幅25でポップアップ
  ;; :dedicatedにtを指定することで、direxウィンドウ内でのバッファの切り替えが
  ;; ポップアップ前のウィンドウに移譲される
  (push '(direx:direx-mode :position left :width 30 :dedicated t)
        popwin:special-display-config)
  ;; keybind
  (global-set-key (kbd "C-c C-d") 'direx:jump-to-directory-other-window))

;; ediff
(when (require 'ediff nil t)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))

;; mark-multiple.el
(when (require 'mark-more-like-this nil t)
  (global-set-key (kbd "C-<") 'mark-previous-like-this)
  (global-set-key (kbd "C->") 'mark-next-like-this))

;; scroll bar
(when (require 'yascroll nil t)
  (global-yascroll-bar-mode 1))

;; all
(when (require 'all nil t)
  (require 'all-ext nil t)
  (push '("*All*" :regexp t :height .5) popwin:special-display-config))


;;; 50-misc.el ends here
