;;; inits --- org-mode: outline processor, memo, todo etc
;;; Commentary:

;;; Code:

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :init
  (setq org-startup-folded nil)
  :config
  (custom-set-faces
   '(org-checkbox ((t (:foreground "#3b99fc"))))
   '(org-todo ((t (:foreground "#ff6666" :weight bold)))))
  (add-hook 'org-mode-hook 'toc-org-enable))

(use-package toc-org :defer t)

(use-package org-present
  :defer t
  :bind (:map org-present-mode-keymap
              (("q" . org-present-quit)))
  :config
  (add-hook 'org-present-mode-hook
            (lambda ()
              (org-present-big)
              (org-display-inline-images)
              (org-present-hide-cursor)
              (org-present-read-only)))
  (add-hook 'org-present-mode-quit-hook
            (lambda ()
              (org-present-small)
              (org-remove-inline-images)
              (org-present-show-cursor)
              (org-present-read-write))))

(use-package org-projectile
  :bind (("C-c M-p" . org-projectile:project-todo-completing-read)
         ("C-c M-c" . org-capture))
  :config
  (progn
    (setq org-agenda-files (append org-agenda-files (org-projectile:todo-files)))
    (add-to-list 'org-capture-templates (org-projectile:project-todo-entry "p"))))


;;; 50-org.el ends here
