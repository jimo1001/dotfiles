;;; 50-migemo --- inits
;;; Commentary:

;;; Code:

;; C/Migemo -- incremental searches by ro-maji
(when (and (or (executable-find "migemo")
               (executable-find "cmigemo"))
           (require 'migemo nil t))
  (when (executable-find "cmigemo")
    (setq migemo-command "cmigemo")
    (setq migemo-options '("-q" "--emacs")))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (setq search-whitespace-regexp nil)
  (load-library "migemo"))

;;; 50-migemo.el ends here
