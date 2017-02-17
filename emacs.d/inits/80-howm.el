;;; inits --- howm (Hitori Otegaru Wiki Modoki)
;;; Commentary:

;;; Code:

(use-package howm
  :bind ("C-c , ," . howm-menu)
  :init
  (setq howm-excluded-file-regexp "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$"
        howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.org"
        howm-history-file (expand-file-name "~/tmp/howm-history")
        howm-keyword-file (expand-file-name "~/tmp/howm-keys")
        howm-list-all-title t
        howm-list-recent-title t
        howm-menu-expiry-hours 2
        howm-menu-file (locate-user-emacs-file "menu.howm")
        howm-menu-lang 'en
        howm-menu-name-format "*howm*"
        howm-menu-schedule-days 7
        howm-menu-schedule-days-before 2
        howm-view-split-horizontally t
        howm-view-summary-persistent nil
        howm-view-title-regexp "^\\(=\\|#\\)\\( +[^-]\\(.*\\)\\|\\)$")
  :config
  (add-to-list 'helm-boring-buffer-regexp-list "\\*howmM:")
  (custom-set-faces
   '(howm-menu-list-face ((t (:foreground "#a9a9a9"))))
   '(howm-reminder-normal-face ((t (:foreground "#ab82ff"))))
   '(howm-reminder-today-face ((t (:background "#993333" :foreground "white"))))
   '(howm-reminder-todo-face ((t (:foreground "#ffb90f"))))))

;;; 80-howm.el ends here
