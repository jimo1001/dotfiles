;; -*- coding: utf-8; mode: emacs-lisp; -*-
;;; init.el --- Initialization file for GNU Emacs


;; load ~/.emacs.d/site-lisp
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;; cask
(when (require 'cask nil t)
  (cask-initialize))

;; pallet
(when (require 'pallet nil t)
  (pallet-mode t))

;; package.el
(when (require 'package nil t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  ;; initialzie
  (package-initialize))

;; load init files
(when (require 'init-loader nil t)
  (setq init-loader-show-log-after-init nil)
  (init-loader-load "~/.emacs.d/inits"))

;; EOF
