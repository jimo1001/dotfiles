;;; inits --- howm (Hitori Otegaru Wiki Modoki)
;;; Commentary:

;;; Code:

(use-package howm
  :bind ("C-c , ," . howm-menu)
  :init
  (setq howm-view-title-regexp "^\\(=\\|#\\)\\( +[^-]\\(.*\\)\\|\\)$"
        howm-menu-lang 'en
        howm-menu-name-format "*howm*"
        howm-view-split-horizontally t
        howm-list-recent-title t
        howm-list-all-title t
        howm-menu-expiry-hours 2
        howm-menu-file "~/.emacs.d/menu.howm"
        howm-view-summary-persistent nil
        howm-menu-schedule-days-before 2
        howm-menu-schedule-days 7
        howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.org"
        howm-excluded-file-regexp "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")
  :config
  (add-to-list 'helm-boring-buffer-regexp-list "\\*howmM:")
  (custom-set-faces
   '(howm-menu-list-face ((t (:foreground "#a9a9a9"))))
   '(howm-reminder-normal-face ((t (:foreground "#ab82ff"))))
   '(howm-reminder-today-face ((t (:background "#993333" :foreground "white"))))
   '(howm-reminder-todo-face ((t (:foreground "#ffb90f"))))))

;;; 80-howm.el ends here
