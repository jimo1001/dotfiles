;; -*- coding: utf-8; mode: emacs-lisp; -*-
;;; init.el --- Initialization file for GNU Emacs

;; load ~/.emacs.d/site-lisp
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;; ~/.cask
(let ((default-directory
        (expand-file-name (concat "~/.emacs.d/.cask/" emacs-version))))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;; load init files
(when (require 'init-loader nil t)
  (setq init-loader-show-log-after-init nil)
  (init-loader-load "~/.emacs.d/inits"))

;; EOF
