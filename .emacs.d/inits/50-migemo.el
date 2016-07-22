;;; 50-migemo --- inits
;;; Commentary:

;;; Code:

;; C/Migemo -- incremental searches by ro-maji
(when (and (or (executable-find "migemo")
               (executable-find "cmigemo"))
           (locate-library "migemo"))
  (load-library "migemo")
  (when (executable-find "cmigemo")
    (setq migemo-command "cmigemo")
    (setq migemo-options '("-q" "--emacs")))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (setq search-whitespace-regexp nil)
  (add-hook 'after-init-hook 'migemo-init))

;;; 50-migemo.el ends here
