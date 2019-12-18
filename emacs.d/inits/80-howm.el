;;; inits --- howm (Hitori Otegaru Wiki Modoki)
;;; Commentary:

;;; Code:

(use-package howm
  :bind
  ("C-c , ," . howm-menu)
  :init
  (setq howm-template "# %title%cursor\n%date %file\n\n")
  (setq howm-excluded-file-regexp "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")
  (setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.md")
  (setq howm-history-file (expand-file-name "~/tmp/howm-history"))
  (setq howm-keyword-file (expand-file-name "~/tmp/howm-keys"))
  ;;(setq howm-list-all-title t)
  (setq howm-list-recent-title t)
  (setq howm-menu-expiry-hours 2)
  (setq howm-menu-file (locate-user-emacs-file "menu.howm"))
  (setq howm-menu-lang 'en)
  (setq howm-menu-name-format "*howm*")
  (setq howm-menu-refresh-after-save nil)
  (setq howm-menu-schedule-days 7)
  (setq howm-menu-schedule-days-before 2)
  (setq howm-refresh-after-save nil)
  ;;(setq howm-view-use-grep t)
  (setq howm-view-split-horizontally nil)
  (setq howm-view-summary-persistent nil)
  (setq howm-view-title-regexp "^\\(=\\|#\\)\\( +[^-]\\(.*\\)\\|\\)$")
  :config
  (custom-set-faces
   '(howm-menu-list-face ((t (:foreground "#a9a9a9"))))
   '(howm-reminder-normal-face ((t (:foreground "#ab82ff"))))
   '(howm-reminder-today-face ((t (:background "#993333" :foreground "white"))))
   '(howm-reminder-todo-face ((t (:foreground "#ffb90f"))))))

;;; 80-howm.el ends here
