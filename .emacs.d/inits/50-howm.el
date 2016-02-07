;;; 50-howm --- inits
;;; Commentary:
;;;   howm (Hitori Otegaru Wiki Modoki)

;;; Code:
(when (autoload-if-found (list 'howm-menu 'howm-mode)
                         "howm" "Hitori Otegaru Wiki Modoki" t)
  (setq howm-menu-lang 'ja
        howm-view-split-horizontally t
        howm-list-recent-title t
        howm-list-all-title t
        howm-menu-expiry-hours 2
        howm-menu-file "~/howm/menu.howm"
        howm-view-summary-persistent nil
        howm-menu-schedule-days-before 2
        howm-menu-schedule-days 7
        howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")

  ;; Global mode
  (add-to-list 'auto-mode-alist '("\\.howm\\'" . org-mode))

  ;; exclude files
  (setq howm-excluded-file-regexp
        "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")

  (global-set-key "\C-c,," 'howm-menu)

  ;; The link is traced in the tab.
  (eval-after-load "howm-menu"
    '(progn
       ;; elscreen
       (if (featurep 'elscreen)
           (define-key howm-mode-map (kbd "M-C") 'cfw:elscreen-open-howm-calendar)
         (define-key howm-mode-map (kbd "M-C") 'cfw:open-howm-calendar)
         (require 'elscreen-howm nil t)))))

;;; 50-howm.el ends here
