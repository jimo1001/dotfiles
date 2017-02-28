;;; inits --- Mutiple WorkSpace
;;; Commentary:

;;; Code:

(defun start-perspeen-mode ()
  "Enable perspeen-mode."
  (interactive)
  (perspeen-mode +1)
  (perspeen-rename-ws "main"))

(use-package perspeen
  :init
  (setq perspeen-use-tab t
        perspeen-modestring-dividers '("[" "]" "/")
        ;; WorkSpace's Command Prefix: `C-z w'
        perspeen-keymap-prefix (kbd "C-z w"))
  :config
  (custom-set-faces
   '(perspeen-selected-face ((t (:inherit mode-line :foreground "#fcfcfc"))))
   '(perspeen-tab--header-line-active ((t (:inherit mode-line :background "#cfcfcf" :foreground "#262626"))))
   '(perspeen-tab--header-line-inactive ((t (:inherit mode-line :background "#404040" :foreground "#bfbfbf"))))
   '(perspeen-tab--powerline-inactive1 ((t (:inherit mode-line)))))
  (add-hook 'after-init-hook #'start-perspeen-mode)

  ;; for Tab
  (bind-keys :map perspeen-mode-map
             ("C-z n" . perspeen-tab-next)
             ("C-z p" . perspeen-tab-prev)
             ("C-z c" . (lambda ()
                          (interactive)
                          (perspeen-tab-create-tab nil 0 t)))
             ("C-z k" . perspeen-tab-del)))

;;; 05-workspace.el ends here
