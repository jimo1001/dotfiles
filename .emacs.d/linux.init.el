;; -*- coding: utf-8; mode: emacs-lisp; -*-
;; linux.init.el
;;=======================================================================
;;        Initialization file for Emacs of Linux/Unix
;;=======================================================================

;;-----------------------------------------------------------------------
;; Common configurations
;;-----------------------------------------------------------------------

;; Add exec-path
(setq exec-path (append (list
                         "/usr/local/bin"
                         "/usr/local/sbin"
                         "/opt/local/bin"
                         ) exec-path))

;; set hostname
(setq hostname (substitute-env-vars "$HOSTNAME"))

;; dont create backup files
(setq make-backup-files nil)
(setq auto-save-default nil)

;; screen 使用時用設定
(add-hook 'server-done-hook
          (lambda ()
            (shell-command
             "screen -r -X select `cat ~/tmp/emacsclient-caller`")))

;; for migemo
(when (featurep 'migemo)
  ;; PATH of migemo-dict for emacs
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  ;; charset encoding
  (setq migemo-coding-system 'utf-8-unix))

;; ce-scroll
;; info: 一行毎にスクロール
;; windows 環境だとキーリートしたときに画面描画されないためLinuxのみ
(load "ce-scroll" t)
(setq ce-smooth-scroll nil)

;; emacs23.1 用フォント設定
(when emacs23.1-p
  (when (window-system)
    (setq my-font "-*-*-medium-r-normal--12-*-*-*-*-*-fontset-hiramaru")
    (setq fixed-width-use-QuickDraw-for-ascii t)
    (setq mac-allow-anti-aliasing t)
    (if (= emacs-major-version 22)
        (require 'carbon-font))
    (set-default-font my-font)
    (add-to-list 'default-frame-alist `(font . ,my-font))
    (when (= emacs-major-version 23)
      (set-fontset-font
       (frame-parameter nil 'font)
       'japanese-jisx0208
       '("Hiragino Maru Gothic Pro" . "iso10646-1"))
      (setq face-font-rescale-alist
            '(("^-apple-hiragino.*" . 1.2)
              (".*osaka-bold.*" . 1.2)
              (".*osaka-medium.*" . 1.2)
              (".*courier-bold-.*-mac-roman" . 1.0)
              (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
              (".*monaco-bold-.*-mac-roman" . 0.9)
              ("-cdac$" . 1.3))))))


;; open file by sudo when user has none permission.
(defun file-other-p (filename)
  "Return t if file FILENAME created by others."
  (if (file-exists-p filename)
      (/= (user-real-uid) (nth 2 (file-attributes filename)))))
(defun file-username (filename)
  "Return File Owner."
  (user-full-name (nth 2 (file-attributes filename))))
(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))7
        (rename-buffer
         (format "%s:%s"
                 (file-remote-p (buffer-file-name) 'method)
                 (buffer-name)))))
(add-hook 'find-file-hook
          'th-rename-tramp-buffer)
(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (file-other-p (ad-get-arg 0))
           (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0) " is read-only.  Open it as "
                             (file-username (ad-get-arg 0)) "? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))
(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file
               (concat "/sudo:"
                       (file-username file) "@" (system-name) ":" file))))
