;; -*- coding: utf-8; mode: emacs-lisp; -*-
;;; init.el --- Initialization file for GNU Emacs

;; Recursively add load-path
(defun load-my-lisp-dir ()
  (let* ((my-lisp-dir "~/.emacs.d/elisp/")
         (default-directory my-lisp-dir))
    (setq load-path (cons my-lisp-dir load-path))
    (normal-top-level-add-subdirs-to-load-path)))
(if (not (fboundp 'normal-top-level-add-subdirs-to-load-path))
    (load "~/.emacs.d/elisp/startup.el" t)
  (load-my-lisp-dir))

;; init variables
(defvar hostname "")

;; Add info-path
(setq Info-default-directory-list
      (append (list "~/.emacs.d/info") Info-default-directory-list))

;; for debug
(defun init-loader-re-load (re dir &optional sort)
  (let ((load-path (cons dir load-path)))
    (dolist (el (init-loader--re-load-files re dir sort))
      (condition-case e
          (let ((time (car (benchmark-run (load (file-name-sans-extension el))))))
            (init-loader-log (format "loaded %s. %s" (locate-library el) time)))
        (error
         ;; (init-loader-error-log (error-message-string e))
         (init-loader-error-log
          (format "%s. %s" (locate-library el) (error-message-string e))))))))

;; create empty file
(defun create-empty-file (file)
  (rename-file (make-temp-file file) file))

;; create ~/.saves
(if (not (file-directory-p "~/.saves"))
    (make-directory "~/.saves" t))

;; Autoload for "when" function
(defun autoload-if-found (functions file &optional docstring interactive type)
  "set autoload iff. FILE has found."
  (if (not (listp functions))
      (setq functions (list functions)))
  (if (locate-library file)
      (progn
        (dolist (function functions)
          (autoload function file docstring interactive type))
        t)
    (message "[WARNING] file %s is not found. (autoload-if-found)" file)))


(defun x->bool (elt) (not (not elt)))

;; emacs-version predicates
(dolist (ver '("22" "23" "23.0" "23.1" "23.2" "23.3"))
  (set (intern (concat "emacs" ver "-p"))
       (if (string-match (concat "^" ver) emacs-version)
           t nil)))
;; verification
;; (mapcar (lambda (x) (if (boundp x) (symbol-value x) 'none))
;; '(emacs22-p emacs23-p emacs23.0-p
;; emacs23.1-p emacs23.2-p emacs23.3-p))

;; theme
(if (functionp 'load-theme)
    ;; built-in (Since: 24.1)
    (when (load "~/.emacs.d/etc/themes/theme-jimo1001.el" t)
      (enable-theme 'jimo1001))
  ;; use color-theme
  (when (require 'color-theme nil t)
    (eval-after-load "color-theme"
      (progn
        (color-theme-initialize)
        (autoload 'my-color-theme "my-color-theme" t)
        (my-color-theme)))))

;; system-type predicates
(setq darwin-p (eq system-type 'darwin)
      ns-p (eq window-system 'ns)
      carbon-p (eq window-system 'mac)
      linux-p (eq system-type 'gnu/linux)
      colinux-p (when linux-p
                  (let ((file "/proc/modules"))
                    (and
                     (file-readable-p file)
                     (x->bool
                      (with-temp-buffer
                        (insert-file-contents file)
                        (goto-char (point-min))
                        (re-search-forward "^cofuse\.+" nil t))))))
      cygwin-p (eq system-type 'cygwin)
      nt-p (eq system-type 'windows-nt)
      meadow-p (featurep 'meadow)
      windows-p (or cygwin-p nt-p meadow-p))

;; Add path
(when (or darwin-p linux-p)
  (progn
    (setq exec-path
      (append (list "/usr/local/bin" ) exec-path))))

;; Load initialization files
(load "~/.emacs.d/common.init.el" t)
(cond
 (windows-p
  (load "~/.emacs.d/windows.init.el" t))
 (darwin-p
  (load "~/.emacs.d/darwin.init.el" t))
 (linux-p
  (load "~/.emacs.d/linux.init.el" t)))
(load "~/private.init.el" t)
(load "~/work.init.el" t)

;;Warning: `mapcar' called for effect; use `mapc' or `dolist' instead を防ぐ
;; (setq byte-compile-warnings
;;       '(free-vars
;; 	unresolved
;; 	callargs
;; 	redefine
;; 	obsolete
;; 	noruntime
;; 	cl-functions
;; 	interactive-only
;; 	make-local))

;; Load at after initialization files
(defun after-init-setup ()
  (progn
    ;; default encoding
    (set-default-coding-systems 'utf-8-unix)
    (set-buffer-file-coding-system 'utf-8-unix)
    ;; (set-clipboard-coding-system 'utf-8-unix)
    ;; (set-file-name-coding-system 'utf-8-unix)
    ;; not display error message
    (setq debug-on-error nil)
    ;; (read-scratch-data)
    ))
(add-hook 'after-init-hook 'after-init-setup)
(put 'narrow-to-region 'disabled nil)

;; package.el ELPA
(when (require 'package nil t)
  (package-initialize))
