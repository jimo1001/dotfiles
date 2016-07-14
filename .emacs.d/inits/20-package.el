;;; 20-package --- inits
;;; Commentary:

;;; Code:

(when (require 'package nil t)
  ;; MELPA
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  ;; Marmalade
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  ;; Org
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

  ;; cask + pallet
  (when (require 'cask nil t)
    (cask-initialize))
  (when (require 'pallet nil t)
    (pallet-mode t))

  ;; initialzie
  (package-initialize))

;;; 20-package.el ends here
