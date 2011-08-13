;; -*- coding: utf-8; mode: emacs-lisp; -*-
;; darwin.init.el
;;=======================================================================
;;             Initialization file for Emacs of OSX
;;=======================================================================

;;-----------------------------------------------------------------------
;; Common configurations
;;-----------------------------------------------------------------------

;; set hostname
(setq hostname (shell-command-to-string "echo -n `hostname`"))

;; Add exec-path
(setq exec-path
      (append (list
               "/opt/local/bin"
               "/opt/local/sbin"
               ) exec-path))

;; for gnu screen
(add-hook 'server-done-hook
          (lambda ()
            (shell-command
             "screen -r -X select `cat ~/tmp/emacsclient-caller`")))

;; Tramp
(when (autoload-if-found 'tramp "tramp" nil t)
  (setq tramp-default-user "jimo1001")
  (setq tramp-default-method "ssh")
  (setq tramp-completion-without-shell-p t)
  (setq tramp-shell-prompt-pattern "^[ $]+")
  (setq tramp-debug-buffer t)
  (setq tramp-persistency-file-name "~/.saves/tramp")
  (add-hook 'tramp-hook
            '(lambda()
               (nconc (cadr (assq 'tramp-login-args (assoc "ssh" tramp-methods))) '("/bin/sh" "-i"))
               (setcdr (assq 'tramp-remote-sh (assoc "ssh" tramp-methods)) '("/bin/sh -i"))
               (modify-coding-system-alist 'process "ssh" 'euc-jp-unix))))

;; C/Migemo
(when (featurep 'migemo)
  (when (executable-find "cmigemo")
    (setq migemo-options '("-q" "--emacs" "-i" "\a")))
  ;; set path for migemo-dict
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  ;; charset encoding for migemo
  (setq migemo-coding-system 'utf-8-unix))

;; ce-scroll
;; info: one line scroll
(load "ce-scroll" t)
(setq ce-smooth-scroll nil)

;; ;; for Java
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
;;   ;; Your init file should contain only one such instance.
;;  '(jde-compile-option-classpath (quote ("." "./lib" "../lib" "/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Classes" "/usr/local/tomcat6/lib")))
;;  '(jde-global-classpath (quote ("." "./lib" "../lib" "/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Classes" "/usr/local/tomcat6/lib")))
;;  '(jde-compiler (quote ("javac" "/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home/bin/javac")))
;;  '(jde-jdk-registry (quote (("jkd1.6.0_13" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.6")))))
;; (setq jde-compile-option-encoding "UTF-8")

;; Command-Key and Option-Key
;; (setq ns-command-modifier (quote meta))
;; (setq ns-alternate-modifier (quote super))

;;-----------------------------------------------------------------------
;; for Carbon Emacs package
;;-----------------------------------------------------------------------
(when carbon-p
  ;; font for emacs22
  (when emacs22-p
    (require 'carbon-font)
    (fixed-width-set-fontset "hiramaru" 12))
  (setq-default line-spacing nil)
  (setq default-frame-alist
        (append
         '((foreground-color . "gray")
           (background-color . "black")
           (cursor-color  . "blue")
           (alpha . (90 95)))
         default-frame-alist))
  (setq initial-frame-alist
        (append
         '((fullscreen . fullboth))
         default-frame-alist))
  ;; http://groups.google.com/group/carbon-emacs/msg/287876a967948923
  (defun toggle-fullscreen ()
    (interactive)
    (set-frame-parameter nil
                         'fullscreen
                         (if (frame-parameter nil
                                              'fullscreen)
                             nil 'fullboth)))
  (global-set-key "\C-cm" 'toggle-fullscreen)
  ;; alpha window
  (add-to-list 'default-frame-alist '(alpha . (0.85 0.85)))
  ;; disable AquaSKK
  (setq mac-pass-control-to-system nil))

;; ring bell nil
(when (window-system)
  (setq ring-bell-function (lambda () (message "!! Ring Bell !!"))))

;;-----------------------------------------------------------------------
;; for cocoa Emacs package
;;-----------------------------------------------------------------------
(when (not carbon-p)
  ;; set background-color of region
  (set-face-background 'region "red4")
  ;; for emacs23.1
  (when emacs23.1-p
    ;; initialize screen size for start up emacs
    (setq initial-frame-alist
          (append (list
                   '(width . 270)
                   '(height . 82)
                   '(top . 0)
                   '(left . 0)) initial-frame-alist)))

  ;; set Droid font
  (when (window-system)
    (set-face-attribute 'default nil
                        :family "Droid Sans Mono"
                        :height 130)
    (set-fontset-font "fontset-default"
                      'japanese-jisx0208
                      '("Droid Sans Fallback" . "iso10646-1"))
    (set-fontset-font "fontset-default"
                      'katakana-jisx0201
                      '("Droid Sans Fallback" . "iso10646-1"))
    (setq face-font-rescale-alist
          '((".*Droid_Sans_Mono.*" . 1.0)
            (".*Droid_Sans_Mono-medium.*" . 1.0)
            (".*Droid_Sans_Fallback.*" . 1.3)
            (".*Droid_Sans_Fallback-medium.*" . 1.3)))))
