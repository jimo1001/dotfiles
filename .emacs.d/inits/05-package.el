;;; 20-package --- inits
;;; Commentary:

;;; Code:

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

;;; 05-package.el ends here
