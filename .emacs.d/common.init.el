;; -*- coding: utf-8; mode: emacs-lisp; -*-
;; common.init.el
;;
;; Initialization file for Emacs of all packages.
;; ==============================================
;;
;; The linguistic environment is set to Japanese.
(when (not cygwin-p)
  (set-language-environment "Japanese"))

;; non-displayed tool bar
(when (require 'tool-bar nil t)
  (when tool-bar-mode
    (tool-bar-mode nil)))

;; non-displayed menu bar
(when (require 'menu-bar nil t)
  (when menu-bar-mode
    (menu-bar-mode nil)))

;; show column number at mode-line
(when (not column-number-mode)
  (column-number-mode t))

;; delete region (C-d)
(when (not delete-selection-mode)
  (delete-selection-mode t))

;; The scroll bar is non-displayed.
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode nil))

;; auto-save-list saved path.
(setq auto-save-list-file-prefix (expand-file-name "~/.saves"))

;; not make backup file
(setq make-backup-files nil)

;; Highlight region
(setq transient-mark-mode t)

;; The width of tab/indent to 4.
(setq-default c-basic-offset 4
              tab-width 4
              standard-indent 4
              indent-tabs-mode nil)

;; When open new buffer , set lisp-interacion-mode.
;;(setq major-mode 'lisp-interaction-mode)

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
            (format-time-string "%Y/%m/%d(%a) %p %l:%M" now))))
  (display-time))

;; eshell
(when (autoload-if-found 'eshell "eshell" nil t)
  ;; 補完時に大文字小文字を区別しない
  (setq eshell-cmpl-ignore-case t)
  ;; 確認なしでヒストリ保存
  (setq eshell-ask-to-save-history (quote always))
  ;; 補完時にサイクルする
  (setq eshell-cmpl-cycle-completions t)
  ;; 補完候補がこの数値以下だとサイクルせずに候補表示
  (setq eshell-cmpl-cycle-cutoff-length 5)
  ;; 履歴で重複を無視する
  (setq eshell-hist-ignoredups t)
  ;; プロンプトの設定
  (eval-after-load "eshell"
    '(progn
       (setq  eshell-prompt-function
              (lambda ()
                (concat (eshell/whoami) "@" hostname
                        " (" (eshell/basename (eshell/pwd)) ") "
                        (if (= (user-uid) 0) "# " "$ "))))
       (add-hook 'eshell-mode-hook
                 (lambda ()
                   (set-face-foreground 'eshell-prompt-face "green")
                   (define-key (current-local-map) "\C-a" 'eshell-bol)
                   (define-key (current-local-map) "\C-p" 'eshell-previous-matching-input-from-input)
                   (define-key (current-local-map) "\C-n" 'eshell-next-matching-input-from-input)
                   (define-key (current-local-map) "\C-c\C-l" 'eshell/clear)))))
  (setq eshell-prompt-regexp "^[^#$]*[$#] ")
  ;; バッファをクリアする
  (defun eshell/clear ()
    "Clear the current buffer, leaving one prompt at the top."
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer))))

;; KeyBind
;; minibuffer backward kill
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)
;; Global Set Key
(global-set-key [end] 'end-of-buffer)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key "\C-cn" 'narrow-to-region)
(global-set-key "\C-cw" 'widen)
(global-set-key "\C-c\C-r" 'revert-buffer)
(global-set-key "\C-cc" 'comment-region)

;; revert-mode
;; info: 自動的に最新に
(add-hook 'text-mode-hook (lambda()
                            (global-auto-revert-mode t)))
;; info: 選択範囲内でインデント
(defun indent-selector ()
  (interactive)
  (progn
    (if mark-active
        (indent-region (region-beginning) (region-end) nil)
      (indent-for-tab-command))))
(global-set-key "\C-i" 'indent-selector)

(setq custom-file (expand-file-name "~/.saves/.customized"))
(defun load-custom-file ()
  (if (not (file-exists-p custom-file))
      (copy-file "~/.emacs.d/.saves/.customized" (file-name-directory custom-file)))
  (load-file (expand-file-name custom-file)))
(load-custom-file)

;; ;; ファイル名の補完を強力に
;; (partial-completion-mode 1)
;; (icomplete-mode 1)


;; describe face at point
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

;; save completions file
(defvar save-completions-file-name
  ;(convert-standard-filename "~/.emacs.d/.completions")
  (expand-file-name "~/.emacs.d/.completions")
  "*The file name to save completions to.")

;; yasnippet
(autoload 'yas/dropdown-prompt "dropdown-list" nil t)
(when (autoload-if-found 'yas/minor-mode "yasnippet" nil t)
  (setq yas/root-directory "~/.emacs.d/snippets")
  (eval-after-load "yasnippet"
    '(progn
       (require 'dropdown-list)
       (setq yas/prompt-functions '(yas/dropdown-prompt))
       (yas/load-directory yas/root-directory))))

;; auto-complite
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/auto-complete/dict")
(when (autoload-if-found 'auto-complete-mode "auto-complete" nil t)
  (setq ac-comphist-file (expand-file-name "~/.saves/ac-comphist.dat"))
  (eval-after-load "auto-complete"
    '(progn
       (define-key ac-complete-mode-map "\t" 'ac-expand)
       (define-key ac-complete-mode-map "\r" 'ac-complete)
       (define-key ac-complete-mode-map "\C-n" 'ac-next)
       (define-key ac-complete-mode-map "\C-p" 'ac-previous)
       ;;(setq ac-auto-start 3)
       (when (require 'anything nil t)
         (require 'ac-anything)
         (define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything))

       (set-face-attribute 'ac-completion-face nil
                           :foreground "#e5e5e5"
                           :background "#5f0000"
                           :underline nil)
       (set-face-attribute 'ac-candidate-face nil
                           :foreground "#e5e5e5"
                           :background "#262626"
                           :underline nil)
       (set-face-attribute 'ac-selection-face nil
                           :foreground "#e5e5e5"
                           :background "#5f0000"
                           :underline nil)
       (set-face-attribute 'popup-tip-face nil
                           :foreground "#e5e5e5"
                           :background "#262626"
                           :underline nil))))

;; anything.el
(when (require 'anything nil t)
  (require 'anything-config)
  ;; anything-sources の定義
  (setq anything-sources '(anything-c-source-buffers+
                           anything-c-source-recentf
                           anything-c-source-files-in-current-dir+
                           anything-c-source-files-in-all-dired
                           anything-c-source-create))
  (global-set-key (kbd "C-c ;") 'anything)
  ;; History file
  (setq anything-c-adaptive-history-file
        (expand-file-name "~/.saves/anything-c-adaptive-history"))
  ;; Command
  (global-set-key (kbd "C-c :") 'anything-execute-extended-command)

  ;; anything-migemo
  ;; info: migemo search for anything.
  ;; (require 'anything-migemo nil t)

  ;; anything-match-plugin
  ;; info: スペース区切りで複数の正規表現で絞り込み可能にする
  (require 'anything-match-plugin)

  ;; anything-etags, tags
  (require 'anything-etags nil t)
  (global-set-key (kbd "C-c .")
                  (lambda ()
                    (interactive)
                    (anything '(anything-c-source-imenu))))
  (when (require 'anything-tags nil t)
    (global-set-key (kbd "C-c .")
                    (lambda ()
                      (interactive)
                      (anything '(anything-c-source-tags-select
                                  anything-c-source-imenu)))))
  ;; anythin-c-dabbrev
  (when (require 'anything-dabbrev-expand nil t)
    (global-set-key "\M-i" 'anything-dabbrev-expand)
    (define-key anything-dabbrev-map "\M-i" 'anything-dabbrev-find-all-buffers))

  ;; anything-rcodetools.el
  (when (require 'anything-rcodetools nil t)
    (define-key anything-map "\M-o" 'anything-execute-persistent-action))

  ;; anything-c-moccur
  (when (require 'anything-c-moccur nil t)
    ;; http://d.hatena.ne.jp/IMAKADO/20080724/1216882563
    (setq anything-c-moccur-anything-idle-delay 0.2
          anything-c-moccur-higligt-info-line-flag t
          anything-c-moccur-enable-auto-look-flag t
          anything-c-moccur-enable-initial-pattern t)
    (global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur)
    (global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur)
    (add-hook 'dired-mode-hook
              '(lambda ()
                 (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))
    (global-set-key (kbd "C-M-s") 'anything-c-moccur-isearch-forward)
    (global-set-key (kbd "C-M-r") 'anything-c-moccur-isearch-backward))

  ;; anything for descbinds
  ;; info: descbinds-anything を anything の UI に置き換える
  ;; http://d.hatena.ne.jp/buzztaiki/20081115/1226760184
  (when (require 'descbinds-anything nil t)
    (descbinds-anything-install))

  ;; set-face for anything
  (eval-after-load "anything-config"
    '(progn
       (set-face-attribute 'anything-dir-priv nil
                           :foreground "#00cdcd"
                           :background "#000000"
                           :underline nil)
       (set-face-attribute 'anything-file-name nil
                           :foreground "#5fd75f"
                           :background "#000000"
                           :underline nil)
       (set-face-attribute 'anything-header nil
                           :foreground "#5f87ff"
                           :background "#1c1c1c"
                           :underline nil
                           :bold t)
       (set-face-attribute 'anything-visible-mark nil
                           :foreground "#e5e5e5"
                           :background "#5f0000")
       (set-face-attribute 'anything-grep-match nil
                           :foreground "#e5e5e5"
                           :background "#870000")
       (set-face-attribute 'anything-match nil
                           :foreground "#e5e5e5"
                           :background "#870000")))

  ;; for anything-c-source-recentf
  (setq recentf-save-file "~/.saves/.recentf")
  (setq recentf-max-saved-items 500)
  (recentf-mode 1)

  ;;(anything-iswitchb-setup)

  ;; キーバインドの割当
  (define-key anything-map "\C-h" 'backward-delete-char-untabify)
  (define-key anything-map "\C-p" 'anything-previous-line)
  (define-key anything-map "\C-n" 'anything-next-line)
  (define-key anything-map "\C-v" 'anything-next-page)
  (define-key anything-map "\M-v" 'anything-previous-page)
  (define-key anything-map (kbd "M-;") 'anything-toggle-visible-mark)

  ;; anything for emacs-info
  (defun anything-c-emacs-help ()
    "show emacs-help on anything."
    (interactive)
    (require 'info)
    (anything '(anything-c-source-man-pages
                anything-c-source-info-pages
                anything-c-source-info-elisp
                anything-c-source-info-cl)))
  (global-set-key (kbd "<f1> <f1>") 'anything-c-emacs-help)

  ;; anything for describe-variables
  (defun anything-c-emacs-variables ()
    "show emacs-variables on anything."
    (interactive)
    (anything 'anything-c-source-emacs-variables))
  (global-set-key (kbd "<f1> v") 'anything-c-emacs-variables)

  ;; anything for describe-functions
  (defun anything-c-emacs-functions ()
    "show emacs-functions on anything."
    (interactive)
    (anything 'anything-c-source-emacs-functions))
  (global-set-key (kbd "<f1> f") 'anything-c-emacs-functions)

  ;; anything for kill-ring
  (defun anything-c-kill-ring ()
    "kill ring visual selection by anything."
    (interactive)
    (anything 'anything-c-source-kill-ring))
  (global-set-key "\C-cy" 'anything-c-kill-ring)

  ;; anything for switch-buffer
  (defun anything-switch-buffers ()
    (interactive)
    (anything 'anything-c-source-buffers))
  ;;(global-set-key "\C-xb" 'anything-switch-buffers)

  ;; anything for bookmark
  (setq bookmark-default-file "~/.emacs.d/data/bookmark.bmk")
  (defvar anything-c-source-my-register-set
    '((name . "Set Register")
      (dummy)
      (action . point-to-register)))
  (global-set-key "\C-cb"
                  (lambda ()
                    (interactive)
                    (anything '(anything-c-source-bookmarks
                                anything-c-source-register
                                anything-c-source-ctags
                                anything-c-source-bookmark-set
                                anything-c-source-my-register-set
                                ))))

  ;; anything for Perl
  (autoload-if-found 'perl-completion-mode "perl-completion" nil t)

  ;; anything for PHP
  (when (autoload-if-found 'php-completion-mode "php-completion" nil t)
    (eval-after-load "php-completion"
      '(progn
         (php-mode)
         ;; (php-completion-mode t)
         (when (require 'auto-complete nil t)
           (make-variable-buffer-local 'ac-sources)
           (add-to-list 'ac-sources 'ac-source-php-completion)
           (auto-complete-mode t))))
    (eval-after-load "php-mode"
      '(progn
         (define-key php-mode-map (kbd "C-o") 'phpcmp-complete))))

  ;; anything for Hatena Bookmark
  (when (autoload-if-found (list
                            'anything-hatena-bookmark
                            'anything-hatena-bookmark-get-dump)
                           "anything-hatena-bookmark" nil t)
    (setq anything-hatena-bookmark-file "~/.emacs.d/data/hatena.bmk"))

  ;; anything-auto-install
  (when (require 'anything-auto-install)
    (global-set-key (kbd "C-c I") 'anything-auto-install))

  ;; anything-complete
  (require 'anything-complete))

;; ウィンドウ分割を制御
;; split-root
(when (require 'split-root nil t)
  (defvar anything-compilation-window-height-percent 50.0)
  (defun anything-compilation-window-root (buf)
    (setq anything-compilation-window
          (split-root-window (truncate (* (window-height)
                                          (/ anything-compilation-window-height-percent
                                             100.0)))))
    (set-window-buffer anything-compilation-window buf))
  (setq anything-display-function 'anything-compilation-window-root))

;; 折り返し表示ON/OFF
(defun toggle-truncate-lines ()
  "折り返し表示をトグル動作します."
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))
;; 折り返し表示ON/OFF
(global-set-key "\C-cl" 'toggle-truncate-lines)

;; setting of emacsclient when use screen
;; (setq server-auth-dir "~/.saves/")
(when (>= 1 (length (split-string (shell-command-to-string "pgrep emacs"))))
  (add-hook 'after-init-hook 'server-start))

;; Delete an empty file.
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

;; custom faces
(defgroup myface nil
  "my custom faces." :prefix "myface-" :group 'convenience)

(defface myface-highlight-return
  '((t (:background "#000000")))
  "Face for return code(\x0d)." :group 'myface)

(defvar myface-highlight-return-face 'myface-highlight-return
  "Face for return code(\x0d).")

(defface myface-highlight-double-space
  '((t (:background "#444444")))
  "Face for double byte space." :group 'myface)

(defvar myface-highlight-double-space-face 'myface-highlight-double-space
  "Face for double byte space.")

;; (defface myface-highlight-head-half-space
;;   '((t (:background "#121212" :underline nil)))
;;   "Face for head of half size space." :group 'myface)
(defface myface-highlight-head-half-space
  '((t (:foreground "#262626" :underline t)))
  "Face for head of half size space." :group 'myface)

(defvar myface-highlight-head-half-space-face 'myface-highlight-head-half-space
  "Face for head of half size space.")

(defface myface-highlight-head-tab
  '((t (:background "#303030")))
  "Face for head of tab." :group 'myface)

(defvar myface-highlight-head-tab-face 'myface-highlight-head-tab
  "Face for head of tab.")

;; (defface myface-highlight-end-tab-space
;;   '((t (:background "#5f0000" :underline nil)))
;;   "Face for end of tab." :group 'myface)
(defface myface-highlight-end-tab-space
  '((t (:foreground "#5f0000" :underline t)))
  "Face for end of tab." :group 'myface)

(defvar myface-highlight-end-tab-space-face 'myface-highlight-end-tab-space
  "Face for end of tab.")

(defadvice font-lock-mode (before my-font-lock-mode ())
  ;; append: face list の後に追加, prepend: 先頭に追加
  (font-lock-add-keywords
   major-mode
   '(("[\r\n]*\n" 0 myface-highlight-return-face prepend)
     ("　" 0 myface-highlight-double-space-face prepend)
     ("^[ ]+" 0 myface-highlight-head-half-space-face prepend)
     ("^[\t]+" 0 myface-highlight-head-tab-face prepend)
     ("[ \t]+$" 0 myface-highlight-end-tab-space-face prepend))))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; Setting dered
;; The character-code of the file is converted at a dash.
(require 'dired-aux nil t)

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

;;; etags
(defadvice find-tag (before c-tag-file activate)
  "Automatically create tags file."
  (let ((tag-file (concat default-directory "TAGS")))
    (unless (file-exists-p tag-file)
      (shell-command "etags *.[ch] *.el .*.el *.js -o TAGS 2>/dev/null"))
    (visit-tags-table tag-file)))

;; ibuffer
(when (autoload-if-found 'ibuffer "ibuffer" nil t)
  (setq ibuffer-formats
        '((mark modified read-only " " (name 30 30)
                " " (size 6 -1) " " (mode 16 16) " " filename)
          (mark " " (name 30 -1) " " filename)))
  ;; 無視するバッファリスト
  (setq ibuffer-never-show-regexps '("*Messages*"))
  ;; カスタマイズ可能な shell 補完機能
  (add-hook 'shell-mode-hook 'pcomplete-shell-setup)
  ;; shell-mode でエスケープを綺麗に表示
  (autoload 'ansi-color-for-comint-mode-on "ansi-color"
    "Set `ansi-color-for-comint-mode' to t." t)
  (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
  (eval-after-load "shell-mode"
    '(progn
       ;; shell-modeで上下でヒストリ補完
       (define-key shell-mode-map [up] 'comint-previous-input)
       (define-key shell-mode-map [down] 'comint-next-input)))
  ;; keybind
  (global-set-key "\C-x\C-b" 'ibuffer))

;; ndmacro
(defconst *ndmacro-key* (kbd "M-m") "繰返し指定キー")
(global-set-key *ndmacro-key* 'ndmacro-exec)
(autoload 'ndmacro-exec "ndmacro" t)

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
        (paren-activate)
        ))))
;; highlight paren
(show-paren-mode t)
(setq show-paren-style 'mixed)
;; (setq show-paren-style 'expression)
(set-face-attribute 'show-paren-match nil
                            :foreground "#e5e5e5"
                            :background "#008700"
                            :underline nil
                            :bold t)
;; ffap
(when (require 'ffap nil t)
  (ffap-bindings))

;; match-paren
(global-set-key "\C-c\C-o" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; auto-fill-mode
(setq fill-column 72)
(setq paragraph-start '"^\\([ 　・○<\t\n\f]\\|(?[0-9a-zA-Z]+)\\)")

;; SKK
(when (require 'skk nil t)
  ;; cursor color (hiragana)
  (setq skk-cursor-hiragana-color "#af5f5f")
  ;; charactor encoding
  (setq skk-jisyo-code 'euc-jp-unix)
  ;; Specify dictonary location
  (setq skk-large-jisyo "~/.emacs.d/elisp/skk/dict/SKK-JISYO.L")
  ;; Specify tutorial Location
  (setq skk-tut-file "~/.emacs.d/elisp/skk/SKK.tut")
  ;; stickey shift
  (setq skk-sticky-key ";")
  ;; より洗練されたインライン候補表示
  (setq skk-show-inline 'vertical)
  ;; 変換時，改行でも確定
  (setq skk-egg-like-newline t)
  ;; 句読点
  (setq skk-kuten-touten-alist
        '((jp . ("．" . "，")) ;(jp . ("。" . "、" ))
          (en . ("．" . "，"))))
  ;; jp にすると「。、」を使います
  (setq-default skk-kutouten-type 'jp)
  ;; "「"を入力したら"」"も自動で挿入
  (setq skk-auto-insert-paren t)
  ;; isearch時にSKKをオフ
  (setq skk-isearch-start-mode 'latin)
  ;; auto save (idle 10min)
  (defvar skk-auto-save-jisyo-interval 600)
  (defun skk-auto-save-jisyo ()
    (skk-save-jisyo))
  (run-with-idle-timer skk-auto-save-jisyo-interval
                       skk-auto-save-jisyo-interval
                       'skk-auto-save-jisyo)
  ;; keybind
  (global-set-key "\C-xj" 'skk-mode))

;; CSS
(when (autoload-if-found 'css-mode "css-mode" "major mode for css" t)
  (add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
  (setq css-indent-level 4)
  (setq css-indent-function #'cssm-c-style-indenter))

;; HTML
(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))

;; XML
(when (autoload-if-found 'xml-mode "xml" "Major mode to edit XML files." t)
  (setq auto-mode-alist
        (append
         '(("\\.xml\\'" . xml-mode)
           ("\\.xhtml\\'" . xml-mode))
         auto-mode-alist)))

;; psgml
(when (autoload-if-found 'sgml-mode "psgml" "Major mode to edit SGML files." t)
  ;; カタログファイルの指定
  (setq sgml-catalog-files '("~/DTD/xhtml11-20010531/DTD/xhtml11.cat"))
  ;; DOCTYPE 宣言の設定
  (setq sgml-custom-dtd
        '(("XHTML 1.1"
           "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">")))
  (eval-after-load "sgml-mode"
    '(progn
       (add-hook 'sgml-mode-hook
                 (lambda ()
                   (setq sgml-indent-step 4
                         indent-tabs-mode nil
                         sgml-xml-p t
                         sgml-always-quote-attributes t
                         sgml-system-identifiers-are-preferred t
                         sgml-auto-activate-dtd t
                         sgml-recompile-out-of-date-cdtd t
                         sgml-auto-insert-required-elements t
                         sgml-insert-missing-element-comment t
                         sgml-balanced-tag-edit t
                         sgml-default-doctype-name "XHTML 1.1"
                         sgml-ecat-files nil
                         sgml-general-insert-case 'lower
                         sgml-entity-insert-case 'lower
                         sgml-normalize-trims t
                         sgml-insert-defaulted-attributes nil
                         sgml-live-element-indicator t
                         sgml-active-dtd-indicator t
                         sgml-minimize-attributes nil
                         sgml-omittag nil
                         sgml-omittag-transparent nil
                         sgml-shorttag nil
                         sgml-tag-region-if-active t
                         sgml-xml-validate-command "xmllint --noout --valid %s %s"))))))

;; JavaScript
;; js-mode
(when (autoload-if-found 'js-mode "js" "major mode for JavaScript" t)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
  (defun indent-and-back-to-indentation ()
    (interactive)
    (indent-for-tab-command)
    (let ((point-of-indentation
           (save-excursion
             (back-to-indentation)
             (point))))
      (skip-chars-forward "\s " point-of-indentation)))
  (eval-after-load "js"
    '(progn
       (setq js-cleanup-whitespace nil
             js-mirror-mode nil
             js-bounce-indent-flag nil
             js-indent-level 2)
       (define-key js-mode-map "\C-i" 'indent-and-back-to-indentation)
       (define-key js-mode-map "\C-m" nil)
       (define-key js-mode-map "\C-m" 'newline-and-indent))))

;; php-mode
(when (autoload-if-found 'php-mode "php-mode" "Major mode to edit HTML files." t)
  (defcustom php-file-patterns (list "\\.php[s34]?\\'" "\\.phtml\\'" "\\.inc\\'")
    "*List of file patterns for which to automatically invoke php-mode."
    :type '(repeat (regexp :tag "Pattern"))
    :group 'php)
  (let ((php-file-patterns-temp php-file-patterns))
    (while php-file-patterns-temp
      (add-to-list 'auto-mode-alist
                   (cons (car php-file-patterns-temp) 'php-mode))
      (setq php-file-patterns-temp (cdr php-file-patterns-temp))))
  (eval-after-load "php-mode"
    '(progn
       (add-hook 'php-mode-user-hook
                 (lambda ()
                   (setq tab-width 4)
                   (setq c-basic-offset 4)
                   (global-set-key "\M-\\" 'php-complete-function)
                   (c-set-offset 'arglist-intro '+)
                   (c-set-offset 'arglist-close 0)
                   (setq outline-regexp "<\\?\\| *function\\|class")
                   (outline-minor-mode)
                   ;; C-c C-c でコンパイル
                   (make-local-variable 'compile-command)
                   (setq compile-command
                         (concat "php " (buffer-file-name)))
                   (define-key php-mode-map "\C-j" 'php-complete-function)
                   (define-key php-mode-map "\C-m" 'newline-and-indent)
                   (setq php-manual-path "~/doc/php/html")
                   (setq php-manual-url "http://www.phppro.jp/phpmanual/")
                   (setq tags-file-name "~/doc/phpetags/TAGS")
                   (define-key php-mode-map "\C-c\C-c" 'compile))))))

;; Ruby
;; ruby-electric
(when (autoload-if-found 'ruby-electric-mode "ruby-electric" nil t)
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode)))
;; ruby-mode
(when (autoload-if-found 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
  (setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                       interpreter-mode-alist))
  (when (executable-find "ruby")
    (autoload 'run-ruby "inf-ruby"
      "Run an inferior Ruby process")
    (autoload 'inf-ruby-keys "inf-ruby"
      "Set local key defs for inf-ruby in ruby-mode")
    (eval-after-load "ruby-mode"
      '(progn
         (add-hook 'ruby-mode-hook
                   (lambda ()
                     (inf-ruby-keys)
                     (setq indent-tabs-mode 't)
                     (setq ruby-indent-level tab-width)
                     (setq ruby-deep-indent-paren-style nil)
                     (ruby-electric-mode t)))))))

;; yaml-mode
(when (autoload-if-found 'yaml-mode "yaml-mode" "Major mode to edit SGML files." t)
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

;; mmm-mode
(when (autoload-if-found 'mmm-mode "mmm-mode" "multi mode" t)
  (setq mmm-submode-decoration-level 2)
  ;;  (invert-face 'mmm-default-submode-face t)
  (setq mmm-font-lock-available-p t)
  (setq mmm-global-mode 'maybe)
  (eval-after-load "mmm-mode"
    '(progn
       (add-hook 'mmm-mode-hook
                 (lambda ()
                   (save-mmm-c-locals)
                   (defun save-mmm-c-locals ()
                     (with-temp-buffer
                       (php-mode)
                       (dolist (v (buffer-local-variables))
                         (when (string-match "\\`c-" (symbol-name (car v)))
                           (add-to-list 'mmm-save-local-variables
                                        `(,(car v) nil, mmm-c-derived-modes))))))
                   ;; (set-face-bold-p 'mmm-default-submode-face t)
                   (set-face-background 'mmm-default-submode-face nil)
                   (define-key mmm-mode-map "\C-cm" 'mmm-parse-buffer)
                   ;; for PHP
                   (mmm-add-mode-ext-class nil "\\.\\(inc\\|tpl\\|php[s34]?\\)$" 'html-php)
                   (add-to-list 'auto-mode-alist '("\\.\\(inc\\|tpl\\|php[s34]?\\)\\'" . html-mode))
                   ;;                           (mmm-add-mode-ext-class nil "\\.php?\\'" 'html-symfony_js)
                   (mmm-add-classes
                    '((html-php
                       :submode php-mode
                       :front "<\\?\\(php\\)?"
                       :back "\\?>")))
                   (mmm-add-classes
                    '((html-symfony_js
                       :submode javascript-mode
                       :front "<script"
                       :back "</script>")))
                   ;; For JSP
                   (mmm-add-mode-ext-class nil "\\.jsp$" 'html-jsp)
                   (add-to-list 'auto-mode-alist '("\\.jsp\\'" . html-mode))
                   (mmm-add-classes
                    `((html-jsp
                       :submode java-mode
                       :front "<%[@!=]?"
                       :back "%>"))))))))

;; C/Migemo -- incremental searches by ro-maji
;; base
(when (require 'migemo nil t)
  (when (executable-find "cmigemo")
    (setq migemo-command "cmigemo")
    (setq migemo-options '("-q" "--emacs")))
  (setq migemo-pattern-alist-file "~/.saves/.migemo-pattern")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  ;; use cache
  (setq migemo-use-pattern-alist t)
  (setq migemo-use-frequent-pattern-alist t)
  (setq migemo-pattern-alist-length 1024)
  (load-library "migemo")
  ;; initialization
  (migemo-init))

;; abbrev
(add-hook 'pre-command-hook
          (lambda ()
            (setq abbrev-mode nil)))
(global-set-key "\C-ca" 'abbrev-mode)

(setq abbrev-file-name (expand-file-name "~/.saves/.abbrev_defs"))
(if (not (file-exists-p abbrev-file-name))
    (create-empty-file abbrev-file-name))
(define-key esc-map "i" 'expand-abbrev)
(quietly-read-abbrev-file)
(setq save-abbrevs t)

;; dabbrev-ja
(autoload 'dabbrev-ja "dabbrev-ja" nil t)

;; dabbrev-highlight
(autoload 'dabbrev-highlight "dabbrev-highlight" nil t)

;; pabbrev
(autoload 'pabbrev "pabbrev" nil t)

;; ac-mode
(autoload 'ac-mode "ac-mode" nil t)

;; changelog
(when (autoload-if-found 'clmemo "clmemo" "ChangeLog memo mode." t)
  (define-key ctl-x-map "M" 'clmemo)
  (setq clmemo-entry-list
        '("emacs" "book" "url" "idea" "download" "soft" "meadowmemo"))
  (autoload 'clgrep "clgrep" "grep mode for ChangeLog file." t)
  (autoload 'clgrep-title "clgrep" "grep first line of entry in ChangeLog." t)
  (autoload 'clgrep-header "clgrep" "grep header line of ChangeLog." t)
  (autoload 'clgrep-other-window "clgrep" "clgrep in other window." t)
  (autoload 'clgrep-clmemo "clgrep" "clgrep directly ChangeLog MEMO." t)
  (eval-after-load "clmemo"
    '(progn
       (define-key change-log-mode-map "\C-c\C-g" 'clgrep)
       (define-key change-log-mode-map "\C-c\C-t" 'clgrep-title))))

;; highlight-completion
(when emacs22-p
  (global-set-key "\C-\\" 'toggle-input-method)
  (when (require 'highlight-completion nil t)
    ;;(setq hc-ctrl-x-c-is-completion t)
    ;;(highlight-completion-mode 1)
    ))

;; ireplace
(require 'ireplace nil t)

;; redo
(when (require 'redo nil t)
  (global-set-key "\M-/" 'redo))

;; swbuff
(require 'swbuff nil t)

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

;; dsvn.el
(autoload-if-found (list 'svn-status 'svn-update) "dsvn" "Run `svn status/update'." t)

;; perl-electric
;; info: ( complite quart ["]['] & arc [)] )
(when (autoload-if-found 'perl-electric "perl-electric" nil t)
  (eval-after-load "perl-electric"
    '(progn
       (add-hook 'cperl-mode-hook
                 (lambda()
                   (progn
                     (perl-electric-mode t)))))))

;; slime
(when (autoload-if-found 'slime "slime" nil t)
  (eval-after-load "slime"
    '(progn
       (add-hook 'lisp-mode-hook (lambda ()
                                   (slime-mode t)
                                   (show-paren-mode))))))

;; tails-comint-history.el
(load-library "tails-comint-history")

;; ispell
(setq ispell-grep-command "grep")
(setq ispell-alternate-dictionary "/usr/share/dict/words")
(eval-after-load "ispell"
  '(progn
     (setq ispell-skip-region-alist (cons '("[^\000-\377]")
                                          ispell-skip-region-alist))
     (when (and (boundp 'ispell-program-name)
                (string-match "aspell" ispell-program-name )
                (fboundp 'ispell-init-process))
       (defadvice ispell-init-process (around set-lang activate)
         (let ((process-environment (copy-sequence process-environment)))
           (setenv "LANGUAGE" "C")
           (setenv "LC_ALL" "C")
           (setenv "LANG" "C")
           ad-do-it)))))

;; hl-line.el
;; info: highlight cursor line.
(when (require 'hl-line nil t)
  (copy-face 'highlight 'my-hl-line)
  (set-face-background 'my-hl-line "#1c1c1c")
  (setq hl-line-face 'my-hl-line)
  (global-hl-line-mode t))

;; html-helper-mode
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)

;;; install-elisp
(when (autoload-if-found '(install-elisp
                           install-elisp-from-emacswiki
                           install-elisp-from-gist)
                         "install-elisp" nil t)
  (setq install-elisp-repository-directory "~/.emacs.d/elisp/"))

;;; auto-install
(when (autoload-if-found
       '(auto-install-batch
         auto-install-from-buffer
         auto-install-from-directory
         auto-install-from-dired
         auto-install-from-emacswiki
         auto-install-from-gist
         auto-install-from-library
         auto-install-from-url
         auto-install-minor-mode
         auto-install-mode
         auto-install-update-emacswiki-package-name) "auto-install" nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/"))

;; view-mode setting
(when (autoload-if-found 'view-mode "view" nil t)
  (eval-after-load "view"
    '(progn
       (setq view-read-only t)
       (defvar pager-keybind
         `( ;; vi-like
           ("h" . backward-char)
           ("l" . forward-char)
           ("j" . next-line)
           ("k" . previous-line)
           (";" . gene-word)
           ("v" . scroll-up)
           ("V" . scroll-down)
           ("/" . isearch-forward)
           ("n" . isearch-repeat-forward)
           ("N" . isearch-repeat-backward)))
       (defun define-many-keys (keymap key-table &optional includes)
         (let (key cmd)
           (dolist (key-cmd key-table)
             (setq key (car key-cmd)
                   cmd (cdr key-cmd))
             (if (or (not includes) (member key includes))
                 (define-key keymap key cmd))))
         keymap)
       (defun view-mode-hook0 ()
         (define-many-keys view-mode-map pager-keybind)
         (hl-line-mode 1)
         (define-key view-mode-map " " 'scroll-up))
       (add-hook 'view-mode-hook 'view-mode-hook0)
       ;; 書き込み不能なファイルはview-modeで開くように
       (defadvice find-file
         (around find-file-switch-to-view-file (file &optional wild) activate)
         (if (and (not (file-writable-p file))
                  (not (file-directory-p file)))
             (view-file file)
           ad-do-it))
       ;; 書き込み不能な場合はview-modeを抜けないように
       (defvar view-mode-force-exit nil)
       (defmacro do-not-exit-view-mode-unless-writable-advice (f)
         `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
            (if (and (buffer-file-name)
                     (not view-mode-force-exit)
                     (not (file-writable-p (buffer-file-name))))
                (message "File is unwritable, so stay in view-mode.")
              ad-do-it)))
       (do-not-exit-view-mode-unless-writable-advice view-mode-exit)
       (do-not-exit-view-mode-unless-writable-advice view-mode-disable)
       (put 'narrow-to-region 'disabled nil))))

;; mayu-mode
(autoload 'mayu-mode "mayu-mode" nil t)

;; ejacs.el
(autoload 'js-console "js-console" nil t)

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

;; surround.el
(when (require 'surround nil t)
  (surround-mode t)
  (defadvice cua-set-mark (around extended-CUA-set-mark activate)
    (if mark-active
        (surround-set-mark)
      ad-do-it)))

;; backward-delete-char-untabify
(defadvice backward-delete-char-untabify
  (around ys:backward-delete-region activate)
  (if (and transient-mark-mode mark-active)
      (delete-region (region-beginning) (region-end))
    ad-do-it))
(global-set-key "\C-h" 'backward-delete-char-untabify)

;; nav.el
(when (autoload-if-found 'nav-toggle "nav" nil t)
  (global-set-key "\C-c\C-d" 'nav-toggle))

;; wdired.el
(when (autoload-if-found 'wdired "wdired" nil t)
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode))

;; moccur.el
(when (autoload-if-found 'moccur-mode "moccur" nil t)
  ;; color-moccur.el
  (load "color-moccur" t)
  ;; 複数の検索語や、特定のフェイスのみマッチ等の機能を有効にする
  ;; 詳細は http://www.bookshelf.jp/soft/meadow_50.html#SEC751
  (setq moccur-split-word t)
  ;; migemoがrequireできる環境ならmigemoを使う
  ;; 第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
  (when (featurep 'migemo)
    (setq moccur-use-migemo t)))

;; tramp
(when (require 'tramp nil t)
  (setq tramp-default-method "ssh"))

;; elscreen
(when (require 'elscreen nil t)
  (global-set-key "\M-j" 'elscreen-next)
  (global-set-key "\M-k" 'elscreen-previous)
  (set-face-attribute 'elscreen-tab-background-face nil
                      :height 1.0
                      :background "#121212"
                      :underline nil)
  (set-face-attribute 'elscreen-tab-control-face nil
                      :height 1.0
                      :background "#121212"
                      :foreground "#6c6c6c"
                      :underline nil)
  (set-face-attribute 'elscreen-tab-current-screen-face nil
                      :height 1.0
                      :background "#444444"
                      :foreground "#ffffff"
                      :underline nil)
  (set-face-attribute 'elscreen-tab-other-screen-face nil
                      :height 1.0
                      :background "#121212"
                      :foreground "#e5e5e5"
                      :underline nil))

;; session.el
(when (require 'session nil t)
  (setq session-save-file "~/.saves/.session")
  (add-hook 'after-init-hook 'session-initialize))


;; ReST
(when (autoload-if-found 'rst-mode "rst" "reStructuredText mode" t)
  (setq auto-mode-alist
        (append '(("\\.rst\\'" . rst-mode)
                  ("\\.rest\\'" . rst-mode)) auto-mode-alist))
  (eval-after-load "rst"
    '(progn
       (custom-set-faces
        '(rst-level-1-face ((t (:foreground "#afcdcd" :background "#000000" :weight bold))))
        '(rst-level-2-face ((t (:foreground "#87cdcd" :background "#000000" :weight bold))))
        '(rst-level-3-face ((t :foreground "#5faf5f" :background "#000000" :weight bold)))
        '(rst-level-4-face ((t :foreground "#5f5faf" :background "#000000")))
        '(rst-level-5-face ((t :background "5fcd5f" :background "#000000")))
        '(rst-level-6-face ((t :foreground "#00cdcd" :background "#000000")))))))

;; org-mode
(when (require 'org-install nil t)
  (if (not (file-exists-p "~/howm/memo/"))
      (make-directory "~/howm/memo/" t))
  (org-remember-insinuate)
  (setq org-startup-folded nil
        org-startup-truncated nil
        org-return-follows-link t
        org-directory "~/howm/memo/"
        org-default-notes-file (concat org-directory "agenda.org")
        org-remember-templates '(("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")
                                 ("Bug" ?b "** TODO %?   :bug:\n   %i\n   %a\n   %t" nil "Inbox")
                                 ("Idea" ?i "** %?\n   %i\n   %a\n   %t" nil "New Ideas")))
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  ;;(setq howm-view-title-header "*")
  ;; faces
  (set-face-attribute 'org-level-1 nil
                      :foreground "#00cdcd"
                      :background "#000000"
                      :underline nil
                      :bold nil)
  (set-face-attribute 'org-level-2 nil
                      :foreground "#5f5fff"
                      :background "#000000"
                      :underline nil
                      :bold nil)
  (set-face-attribute 'org-level-3 nil
                      :foreground "#5faf5f"
                      :background "#000000"
                      :underline nil
                      :bold nil)
  (set-face-attribute 'org-level-4 nil
                      :foreground "#5f5faf"
                      :background "#000000"
                      :underline nil
                      :bold nil))

;; howm (Hitori Otegaru Wiki Modoki)
;; info: memo tool
(defvar my-howm-schedule-page "TITLE") ; 予定を入れるメモのタイトル
;; for cfw
(defun my-cfw-open-schedule-buffer ()
  (interactive)
  (let*
      ((date (cfw:cursor-to-nearest-date))
       (howm-items
        (howm-folder-grep
         howm-directory
         (regexp-quote my-howm-schedule-page))))
    (cond
     ((null howm-items) ; create
      (howm-create-file-with-title my-howm-schedule-page nil nil nil nil))
     (t
      (howm-view-open-item (car howm-items))))
    (goto-char (point-max))
    (unless (bolp) (insert "\n"))
    (insert
     (format "[%04d-%02d-%02d]@ "
             (calendar-extract-year date)
             (calendar-extract-month date)
             (calendar-extract-day date)))))
(setq cfw:howm-schedule-summary-transformer
  (lambda (line) (split-string (replace-regexp-in-string "^[^@!]+[@!] " "" line) " / ")))
;; autoload
(when (autoload-if-found (list 'howm-menu 'howm-mode)
                         "howm" "Hitori Otegaru Wiki Modoki" t)
  (setq howm-menu-lang 'ja
        howm-view-split-horizontally t
        howm-list-recent-title t
        howm-list-all-title t
        howm-menu-expiry-hours 2
        howm-menu-file "~/howm/menu.howm"
        howm-view-summary-persistent nil
        howm-menu-schedule-days-before 2
        howm-menu-schedule-days 7
        howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
  (add-to-list 'auto-mode-alist '("\\.howm\\'" . org-mode))
  ;; (setq howm-view-use-grep t)
  ;; (setq howm-view-grep-parse-line
  ;;    "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
  (setq howm-excluded-file-regexp
        "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")
  (add-hook 'text-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)))
  ;; The link is traced in the tab.
  (eval-after-load "howm-menu"
    '(progn
       ;; calfw for howm
       (require 'calfw-howm)
       (cfw:install-howm-schedules)
       (define-key howm-mode-map (kbd "M-C") 'cfw:elscreen-open-howm-calendar)
       (define-key cfw:howm-schedule-map (kbd "i") 'my-cfw-open-schedule-buffer)
       (define-key cfw:howm-schedule-inline-keymap (kbd "i") 'my-cfw-open-schedule-buffer)
       ;; change faces
       (custom-set-faces
        '(cfw:face-title ((t (:foreground "#f0dfaf" :weight bold :height 2.0 :inherit variable-pitch))))
        '(cfw:face-header ((t (:foreground "#d0bf8f" :weight bold))))
        '(cfw:face-sunday ((t :foreground "#cc9393" :background "grey10" :weight bold)))
        '(cfw:face-saturday ((t :foreground "#8cd0d3" :background "grey10" :weight bold)))
        '(cfw:face-holiday ((t :background "grey10" :foreground "#8c5353" :weight bold)))
        '(cfw:face-default-content ((t :foreground "#bfebbf")))
        '(cfw:face-regions ((t :foreground "#366060")))
        '(cfw:face-day-title ((t :background "grey10")))
        '(cfw:face-periods ((t :foreground "#8cd0d3")))
        '(cfw:face-today-title ((t :background "#7f9f7f" :weight bold)))
        '(cfw:face-today ((t :background: "grey10" :weight bold)))
        '(cfw:face-select ((t :background "#2f2f2f")))
        '(cfw:face-toolbar ((t (:foreground "#808080" :background "#303030"))))
        '(cfw:face-toolbar-button-off ((t (:foreground "#585858" :background "#303030"))))
        '(cfw:face-toolbar-button-on ((t (:foreground "#c6c6c6" :background "#303030" :bold t)))))
       ;; Elescreen
       (require 'elscreen-howm nil t)
       ;;(define-key howm-mode-map [tab] 'action-lock-goto-next-link)
       ;;(define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)
       (set-face-attribute 'howm-reminder-normal-face nil
                           :foreground "#5faf5f"
                           :background "#000000"
                           :underline nil
                           :bold nil)
       (set-face-attribute 'action-lock-face nil
                           :foreground "#8787af"
                           :background "#000000"
                           :underline nil
                           :bold t)))

  ;; hilightのカラーを変更
  (defface howm-reminder-today-face
    '((((class color)) (:foreground "#e5e5e5" :background "#870000"))
      (t ()))
    "*Face for today."
    :group 'howm-faces)
  (defface howm-reminder-tomorrow-face
    '((((class color)) (:foreground "#e5e5e5" :background "#5f5fd7"))
      (t ()))
    "*Face for tommorow."
    :group 'howm-faces)
  (global-set-key "\C-c,," 'howm-menu))

;; develock
;; info: 余分な空白などを強調表示
(when (require 'develock nil t)
  (setq develock-auto-enable nil))

;; imenu.el
;; info: TAGSファイルを生成せずにタグジャンプ
(when (autoload-if-found 'imenu "imenu" nil t)
  (eval-after-load "imenu"
    '(progn
       (defcustom imenu-modes
         '(emacs-lisp-mode c-mode c++-mode makefile-mode)
         "List of major modes for which Imenu mode should be used."
         :group 'imenu
         :type '(choice (const :tag "All modes" t)
                        (repeat (symbol :tag "Major mode"))))
       (defun my-imenu-ff-hook ()
         "File find hook for Imenu mode."
         (if (member major-mode imenu-modes)
             (imenu-add-to-menubar "imenu")))
       ;;(add-hook 'find-file-hooks 'my-imenu-ff-hook t)
       ))
  ;;(global-set-key "\C-c." 'imenu)
  )

;; wanderlust
;; info: Mailer
(when (autoload-if-found
       '(wl wl-other-frame) "wl" "Wanderlust" t)
  (eval-after-load "wl"
    '(progn
       (require 'elscreen-wl nil t)
       (if (boundp 'mail-user-agent)
           (setq mail-user-agent 'wl-user-agent))
       (if (fboundp 'define-mail-user-agent)
           (define-mail-user-agent
             'wl-user-agent
             'wl-user-agent-compose
             'wl-draft-send
             'wl-draft-kill
             'mail-send-hook))))
  (global-set-key (kbd "C-c m m") 'wl))
(autoload-if-found '(wl-draft wl-user-agent-compose)
                   "wl-draft" "Write draft with Wanderlust." t)

;; background.el
;; info: execute shell command at background.
(autoload 'background "background" nil t)


;; pukiwiki-mode
;; info: pukiwiki を emacs 上で編集
;; http://www.bookshelf.jp/pukiwiki/pukiwiki.php?%A5%A2%A5%A4%A5%C7%A5%A2%BD%B8%2Fpukiwiki-mode
(when (autoload-if-found '(pukiwiki-edit
                           pukiwiki-index
                           pukiwiki-edit-url)
                         "pukiwiki-mode" "pukiwiki" t)
  (eval-after-load "pukiwiki-mode"
    '(progn
       (setq pukiwiki-auto-insert t))))

;; ditz.el
;; info: repository management
(when (autoload-if-found 'gitz "gitz" nil t)
  ;; Path to the ditz command (default: "ditz")
  ;; (setq ditz-program "/path/to/ditz")
  ;; Issue directory name (default: "bugs")
  (setq ditz-issue-directory "issues")
  ;; Enable automatic finding functionality (default: nil)
  (setq ditz-find-issue-directory-automatically-flag t))

;; w3m
(when (executable-find "w3m")
  (when (autoload-if-found 'w3m "w3m" nil t)
    (setq w3m-icon-directory "~/.emacs.d/etc/w3m/icons")))

;; hatena keyword
(when (autoload-if-found 'hatekey "hatena-keyword" nil t)
  (global-set-key "\C-ck" 'hatekey))

;; scheme
;; 要インストール: Gauche
(when (autoload-if-found 'inferior-gauche-mode "inferior-gauche" nil t)
  (add-to-list 'auto-mode-alist '("\\.scm\\'" . inferior-gauche-mode))
  (setq quack-default-program "gosh")
  (setq scheme-program-name "gosh")
  (autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process. " t)
  (defun scheme-interaction-mode ()
    "interaction-mode for scheme"
    (interactive)
    (get-buffer-create "*scratch-scheme*")
    (switch-to-buffer "*scratch-scheme*")
    (inferior-gauche-mode)
    (keyboard-quit)))

;; hatenahelper-mode
(when (autoload-if-found 'hatenahelper-mode "hatenahelper-mode" nil t)
  (eval-after-load "hatenahelper-mode"
    '(define-key hatenahelper-mode-map "\C-cy" 'anything-c-kill-ring)))
;; simple-hatena-mode
(when (autoload-if-found '(simple-hatena simple-hatena-mode) "simple-hatena-mode" nil t)
  (setq-default simple-hatena-default-id "")
  (setq simple-hatena-bin "~/.emacs.d/bin/hw.pl")
  (setq simple-hatena-root "~/.emacs.d/data/hatena")
  (set-file-modes "~/.emacs.d/bin/hw.pl" 448)
  (eval-after-load "simple-hatena-mode"
    '(progn
       (add-hook 'simple-hatena-mode-hook
                 (lambda ()
                   (interactive)
                   (hatenahelper-mode t))))))

;; ky-indent
;; info: http://d.hatena.ne.jp/mzp/20090620/indent
(autoload 'ky-indent "ky-indent" nil t)

;; goby
;; http://www.mew.org/~kazu/proj/goby/ja/
;; info: presentation tool
(autoload 'goby "goby" nil t)

;; twittering-mode
(when (autoload-if-found 'twittering-mode "twittering-mode" nil t)
  (setq-default twittering-username ""))

;; id-manager
(when (autoload-if-found 'id-manager "id-manager" nil t)
  (setq epa-file-cache-passphrase-for-symmetric-encryption t)
  (setq idm-database-file "~/.emacs.d/etc/.idm-db.gpg")
  (setenv "GPG_AGENT_INFO" nil)
  (global-set-key (kbd "\C-c7") 'id-manager))

;; Use Emacs23's eldoc
;; (require 'eldoc)
(when (autoload-if-found 'turn-on-eldoc-mode "eldoc" nil t)
  (when (require 'eldoc-extension nil t)
    ;; (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
    ;; (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
    ;; (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
    (setq eldoc-idle-delay 0)
    (setq eldoc-echo-area-use-multiline-p t)))


;; shell-pop
(when (autoload-if-found 'shell-pop "shell-pop" nil t)
  (setq system-uses-terminfo nil)
  (global-set-key [f7] 'shell-pop)
  (eval-after-load "shell-pop"
    '(progn
       (shell-pop-set-internal-mode "ansi-term")
       (shell-pop-set-internal-mode-shell "/bin/zsh")
       (shell-pop-set-window-height 60))))


;; python-mode
(when (autoload-if-found 'python-mode "python-mode" "Python editing mode." t)
  ;; pylint
  (load-library "pylint")
  ;; http://pylint-messages.wikidot.com/all-messages
  ;; C0103: Invalid name "%s" (should match %s)
  ;; C0111: Missing docstring
  ;; E1101: %s %r has no %r member
  (setq pylint-options "-f parseable -d C0103,C0111,E1101,C0301")
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (setq interpreter-mode-alist (cons '("python" . python-mode)
                                     interpreter-mode-alist))
  (eval-after-load "python-mode"
    '(progn
       (add-hook 'python-mode-hook
                 (lambda ()
                   ;; (when (require 'pymacs nil t)
                   ;;   (add-to-list 'pymacs-load-path "~/.emacs.d/elisp/progmodes/python-mode")
                   ;;   (require 'pycomplete nil t)
                   ;;   (define-key py-mode-map (kbd "C-c i")  'py-complete))
                   ;; (lambda ()
                   ;;   (define-key (current-local-map) "\C-h"
                   ;;     'python-backspace))
                   (local-unset-key (kbd "C-c :"))
                   (define-key (current-local-map) (kbd "C-a") 'move-beginning-of-line)
                   (set-face-attribute 'py-pseudo-keyword-face nil
                                       :foreground "#5faf5f")
                   (set-face-attribute 'py-builtins-face nil
                                       :foreground "#5fafd7")
                   (set-face-attribute 'py-class-name-face nil
                                       :foreground "#d7875f")
                   )))))

;; decodeUrl
(defun url-decode-region (start end)
  "Replace a region with the same contents, only URL decoded."
  (interactive "r")
  (let ((text (url-unhex-string (buffer-substring start end))))
    (delete-region start end)
    (insert text)))

;; sr-speedbar
(when (autoload-if-found (list 'sr-speedbar-open
                               'sr-speedbar-toggle) "sr-speedbar" nil t)
  (global-set-key (kbd "s-s") 'sr-speedbar-toggle)
  (setq sr-speedbar-right-side nil))


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

;; ido-mode
(when (require 'ido  nil t)
  (ido-mode t)
  (global-set-key (kbd "C-x C-f") 'ido-find-file)
  (global-set-key (kbd "C-x b") 'ido-switch-buffer)
  (global-set-key (kbd "C-x d") 'ido-dired)
  (setq ido-save-directory-list-file "~/.saves/.ido.last")
  (add-hook 'ido-setup-hook
            (lambda ()
              (message "setup ido")
              (define-key ido-completion-map "\C-h" 'backward-delete-char-untabify)
              (define-key ido-completion-map " " 'ido-next-match))))

;; trac-wiki
(autoload-if-found 'trac-wiki-mode "trac-wiki" "Trac Wiki Mode" t)
