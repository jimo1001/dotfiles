;;; inits --- Mutiple WorkSpace
;;; Commentary:

;;; Code:

(defun start-perspeen-mode ()
  "Enable perspeen-mode."
  (interactive)
  (perspeen-mode +1)
  (perspeen-rename-ws "default"))

(use-package perspeen
  :init
  (setq perspeen-use-tab t
        perspeen-modestring-dividers '("[" "]" "/"))
  :config
  (custom-set-faces
   '(perspeen-selected-face ((t (:inherit mode-line :foreground "#fcfcfc"))))
   '(perspeen-tab--header-line-active ((t (:inherit mode-line :background "#cfcfcf" :foreground "#262626"))))
   '(perspeen-tab--header-line-inactive ((t (:inherit mode-line :background "#404040" :foreground "#bfbfbf"))))
   '(perspeen-tab--powerline-inactive1 ((t (:inherit mode-line)))))
  (add-hook 'after-init-hook #'start-perspeen-mode)
  (unbind-key "t" perspeen-command-map)
  (unbind-key "n" perspeen-command-map)
  (unbind-key "p" perspeen-command-map)
  (unbind-key "k" perspeen-command-map)
  (unbind-key "c" perspeen-command-map)
  (bind-keys :map perspeen-command-map
             ;; tab
             ("n" . perspeen-tab-next)
             ("p" . perspeen-tab-prev)
             ("c" . perspeen-tab-create-tab)
             ("k" . perspeen-tab-del)
             ;; workspace
             ("w n" . perspeen-next-ws)
             ("w p" . perspeen-previous-ws)
             ("w c" . perspeen-create-ws)
             ("w k" . perspeen-delete-ws)
             ("w r" . perspeen-rename-ws)
             ("w /" . perspeen-change-root-dir)))

;;; 05-workspace.el ends here
