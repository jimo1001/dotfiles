;; -*- coding: utf-8; mode: emacs-lisp; -*-
;;
;; windows.init.el
;;
;; Initialization file for GNU Emacs on Windows
;; ============================================

;; Common configurations
;; ---------------------

;; Path
(setq exec-path (append (list
                         "C:/opt/python-2.6.6/Scripts"
                         "C:/opt/python-2.6.6"
                         "C:/cygwin/usr/local/bin"
                         "C:/cygwin/usr/bin"
                         "C:/cygwin/bin"
                         ) exec-path))

;; Set hostname
(setq hostname (substitute-env-vars "$COMPUTERNAME"))

;; when window-system
(when window-system
  ;; hide mouse cursor
  (setq w32-hide-mouse-timeout 3000))

;; Migemo
(when (featurep 'migemo)
  (when (executable-find "cmigemo")
    (setq migemo-command "cmigemo")
    (setq migemo-options '("-q" "--emacs")))
  ;; set path for migemo-dict
  (setq migemo-dictionary "C:/cygwin/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  ;; charset encoding for migemo
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init))

;; for ssl
(if cygwin-p
    (progn
      (setq ssl-program-name "/bin/openssl")
      (setq ssl-rehash-program-name "/bin/c_rehash")
      ;; coding-system for dired
      (add-hook 'dired-mode-hook
                (lambda ()
                  (make-local-variable 'file-name-coding-system)
                  (make-local-variable 'buffer-file-coding-system)
                  (setq buffer-file-coding-system 'utf-8-unix
                        file-name-coding-system 'utf-8-unix
                        dired-file-coding-system 'utf-8-unix
                        dired-default-file-coding-system 'utf-8-unix)))
      (progn
        (setq ssl-program-name "C:/cygwin/bin/openssl.exe")
        (setq ssl-rehash-program-name "C:/cygwin/bin/c_rehash")
        ;; coding-system for dired
        (add-hook 'dired-mode-hook
                  (lambda ()
                    (make-local-variable 'file-name-coding-system)
                    (make-local-variable 'buffer-file-coding-system)
                    (setq buffer-file-coding-system 'sjis-unix)
                    (setq file-name-coding-system 'sjis-unix))))))


;; ;; JDK の設定
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
;;   ;; Your init file should contain only one such instance.
;;  '(jde-compile-option-classpath (quote ("." "./lib" "../lib" "C:/Java/jdk1.6.0_13/lib" "C:/cygwin/usr/local/tomcat/lib")))
;;  '(jde-global-classpath (quote ("." "./lib" "../lib" "C:/Java/jdk1.6.0_13/lib" "C:/cygwin/usr/local/tomcat/lib")))
;;  '(jde-compiler (quote ("javac" "C:/Java/jdk1.6.0_13/bin/javac.exe")))
;;  '(jde-jdk-registry (quote (("jkd1.6.0_13" . "C:/Java/jdk1.6.0_13")))))

;;; 印刷の設定
;; ak2pr
(setq lpr-command "ak2pr.exe"
      lpr-switches '()
      lpr-add-switches t
      lpr-command-switches '())
(setq ps-multibyte-buffer 'non-latin-printer
      ps-line-number t
      ps-paper-type 'a4
      ps-landscape-mode t
      ps-number-of-columns 2
      ps-lpr-command lpr-command
      ps-lpr-switches '("-mPS_GHOST"))

;; tramp
(when (autoload-if-found 'tramp "tramp" nil t)
  (eval-after-load "tramp"
    '(progn
       (setq tramp-default-method "plink"
             tramp-completion-without-shell-p t
             tramp-shell-prompt-pattern "^[ $]+"
             tramp-debug-buffer t
             tramp-persistency-file-name "~/.saves/tramp")
       (modify-coding-system-alist 'process "plink" 'euc-jp-unix))))

;;
;;  Configuration for Meadow
;; --------------------------
(when meadow-p
  ;; SHELL
  (setq explicit-shell-file-name "bash.exe")
  (setq shell-file-name "sh.exe")
  (setq shell-command-switch "-c")
  ;; argument-editing の設定
  (require 'mw32script)
  (mw32script-init)
  ;; telnet
  (setq telnet-program "C:/meadow/bin/telnet.exe")

  ;; fakecygpty の設定
  ;; この設定で cygwin の仮想端末を要求するプログラムを Meadow から
  ;; 扱えるようになります
  (setq mw32-process-wrapper-alist
        '(("/\\(bash\\|tcsh\\|svn\\|ssh\\|gpg[esvk]?\\)\\.exe" .
           (nil .
                ("fakecygpty.exe" . set-process-connection-type-pty)))))
  (when window-system
    ;; Set Font
    (w32-add-font
     "ARISAKA-fix 13"
     '((spec
        ((:char-spec ascii :height 120)
         strict
         (w32-logfont "ARISAKA-等幅" 0 -13 400 0 nil nil nil 128 1 3 49))
        ((:char-spec ascii :height 120 :weight bold)
         strict
         (w32-logfont "ARISAKA-等幅" 0 -13 400 0 nil nil nil 128 1 3 49))
        ((:char-spec ascii :height 120 :slant italic)
         strict
         (w32-logfont "ARISAKA-等幅" 0 -13 400 0 nil nil nil 128 1 3 49))
        ((:char-spec ascii :height 120 :weight bold :slant italic)
         strict
         (w32-logfont "ARISAKA-等幅" 0 -13 400 0 nil nil nil 128 1 3 49))
        ((:char-spec japanese-jisx0208 :height 120)
         strict
         (w32-logfont "ARISAKA-等幅" 0 -13 400 0 nil nil nil 128 1 3 49))
        ((:char-spec japanese-jisx0208 :height 120 :weight bold)
         strict
         (w32-logfont "ARISAKA-等幅" 0 -13 400 0 nil nil nil 128 1 3 49)
         ((spacing . -1)))
        ((:char-spec japanese-jisx0208 :height 120 :slant italic)
         strict
         (w32-logfont "ARISAKA-等幅" 0 -13 400 0 nil nil nil 128 1 3 49))
        ((:char-spec japanese-jisx0208 :height 120 :weight bold :slant italic)
         strict
         (w32-logfont "ARISAKA-等幅" 0 -13 400 0 nil nil nil 128 1 3 49)
         ((spacing . -1))))))
    (w32-add-font
     "MeiryoKe_Gothic 13"
     '((strict-spec
        ((:char-spec ascii :height any)
         (w32-logfont "MeiryoKe_Gothic" 0 13 400 0 nil nil nil 0 1 3 49))
        ((:char-spec ascii :height any :weight bold)
         (w32-logfont "MeiryoKe_Gothic" 0 13 700 0 nil nil nil 0 1 3 49))
        ((:char-spec ascii :height any :slant italic)
         (w32-logfont "MeiryoKe_Gothic" 0 13 400 0	t nil nil 0 1 3 49))
        ((:char-spec ascii :height any :weight bold :slant italic)
         (w32-logfont "MeiryoKe_Gothic" 0 13 700 0	t nil nil 0 1 3 49))
        ((:char-spec japanese-jisx0208 :height any)
         (w32-logfont "MeiryoKe_Gothic" 0 13 400 0 nil nil nil 128 1 3 49))
        ((:char-spec japanese-jisx0208 :height any :weight bold)
         (w32-logfont "MeiryoKe_Gothic" 0 13 700 0 nil nil nil 128 1 3 49)
         ((spacing . -1)))
        ((:char-spec japanese-jisx0208 :height any :slant italic)
         (w32-logfont "MeiryoKe_Gothic" 0 13 400 0	t nil nil 128 1 3 49))
        ((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
         (w32-logfont "MeiryoKe_Gothic" 0 13 700 0	t nil nil 128 1 3 49)
         ((spacing . -1)))
        ((:char-spec katakana-jisx0201 :height any)
         (w32-logfont "MeiryoKe_Gothic" 0 13 400 0 nil nil nil 128 1 3 49))
        ((:char-spec katakana-jisx0201 :height any :weight bold)
         (w32-logfont "MeiryoKe_Gothic" 0 13 700 0 nil nil nil 128 1 3 49)
         ((spacing . -1)))
        ((:char-spec katakana-jisx0201 :height any :slant italic)
         (w32-logfont "MeiryoKe_Gothic" 0 13 400 0	t nil nil 128 1 3 49))
        ((:char-spec katakana-jisx0201 :height any :weight bold :slant italic)
         (w32-logfont "MeiryoKe_Gothic" 0 13 700 0	t nil nil 128 1 3 49)
         ((spacing . -1))))))
    (set-face-attribute 'variable-pitch nil :family "*")
    ;; フレームフォントの設定
    (setq default-frame-alist
          (cons '(font . "MeiryoKe_Gothic 13")
                default-frame-alist)))

  ;; ウィンドウを半透明に
  ;; 値について info: (通常 アクティブ 移動中 サイズ変更中)
  ;; (modify-all-frames-parameters
  ;; (list (cons 'alpha  '(90 nil nil nil))))

  ;; ;; Full Screen
  ;; (defvar my-frame-state-alist nil)
  ;; (defun my-toggle-frame-size ()
  ;;   (interactive)
  ;;   (let ((state (assq (selected-frame) my-frame-state-alist)))
  ;;     (if state
  ;;         (if (cdr state)
  ;;             (w32-restore-frame)
  ;;           (w32-maximize-frame))
  ;;       (setq state (cons (selected-frame) nil))
  ;;       (setq my-frame-state-alist
  ;;             (cons state my-frame-state-alist))
  ;;       (w32-maximize-frame))
  ;;     (setcdr state (null (cdr state)))))
  ;; (global-set-key "\C-c\C-m" 'my-toggle-frame-size)
  )


;;
;;  Configuration for NTEmacs
;; ---------------------------
(when nt-p
  (when window-system
    (setq default-frame-alist
          (append
           '((foreground-color . "gray")
             (background-color . "black")
             (cursor-color  . "blue")
             (alpha . (100 100)))
           default-frame-alist))
    ;; NT Emacs 用フォント設定
    ;; Consolas + MeiryoKe_Gothic
    (set-face-attribute 'default
                        nil
                        :family "Consolas"
                        :height 100)
    (set-fontset-font "fontset-default"
                      'ascii
                      '("Consolas" . "ascii"))
    (set-fontset-font "fontset-default"
                      'japanese-jisx0208
                      '("MeiryoKe_Gothic" . "jisx0208-sjis"))
    ;; ;; MeiryoKe_Gothic
    ;; (set-face-attribute 'default
    ;; 		      nil
    ;; 		      :family "MeiryoKe_Gothic"
    ;; 		      :height 100)
    ;; (set-fontset-font "fontset-default"
    ;; 		    'japanese-jisx0208
    ;; 		    '("MeiryoKe_Gothic" . "jisx0208-sjis"))
    ;; ;; ARISAKA(Mono)
    ;; (set-face-attribute 'default
    ;;                     nil
    ;;                     :family "ARISAKA_Mono"
    ;;                     :height 100)
    ;; (set-fontset-font "fontset-default"
    ;;                   'japanese-jisx0208
    ;;                   '("ARISAKA_Mono" . "jisx0208-sjis"))
    ;; ;; Ricty
    ;; (set-face-attribute 'default nil
    ;;                     :family "Ricty"
    ;;                     :height 120)
    ;; (set-fontset-font "fontset-default"
    ;;                   'japanese-jisx0208
    ;;                   (font-spec :family "Ricty"))
    ))
