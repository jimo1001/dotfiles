;;; inits --- Initialization file for GNU Emacs
;;; Commentary:

;;; Code:

;; Load custom-file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file t t)

;; Initialize Packages
(require 'package)
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t))

;; Activate all the packages (in particular autoloads)
(package-initialize)

;; Fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; Install required packages
(dolist (pkg '(package-utils init-loader use-package))
  (unless (package-installed-p pkg)
    (package-install pkg))
  (require pkg))

(eval-when-compile
  (require 'use-package))
(require 'diminish) ;; if you use :diminish
(require 'bind-key) ;; if you use any :bind variant

;; Install the missing packages
(when package-selected-packages
  (package-install-selected-packages))

;; Load init files
(require 'init-loader)
;; Show loading log message if this value is t.
(setq init-loader-show-log-after-init nil)

(init-loader-load (locate-user-emacs-file "inits"))

;;; init.el ends here
(put 'downcase-region 'disabled nil)
