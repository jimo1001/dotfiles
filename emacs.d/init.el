;;; inits --- Initialization file for GNU Emacs
;;; Commentary:

;;; Code:

;; Load ~/.emacs.d/env.el
(load (locate-user-emacs-file "env.el") t)

;; Packages Initialization
(setq package-directory-list '("~/.emacs.d/elpa/"))
(when (require 'package nil t)
  ;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  ;;(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
  ;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (when (< emacs-major-version 24)
    (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t))

  ;; Load my custom-file (~/.emacs.d/custom.el)
  (setq custom-file (locate-user-emacs-file "custom-autogen.el"))
  (load (locate-user-emacs-file "custom.el") t)

  ;; Activate all packages (in particular autoloads)
  (package-initialize)

  ;; Fetch the list of packages available
  (unless package-archive-contents
    (package-refresh-contents))

  ;; Install required packages
  (dolist (pkg '(package-utils
                 init-loader
                 use-package
                 diminish ;; if you use :diminish
                 bind-key ;; if you use any :bind variant
                 ))
    (unless (package-installed-p pkg)
      (package-install pkg))
    (require pkg))

  (eval-when-compile
    (require 'use-package nil t))

  ;; Install missing packages
  (when package-selected-packages
    (package-install-selected-packages))

  ;; Load user's init files
  (require 'init-loader)
  ;; Show loading log message if this value is t.
  (setq init-loader-show-log-after-init nil)

  (init-loader-load (locate-user-emacs-file "inits")))


;;; init.el ends here
