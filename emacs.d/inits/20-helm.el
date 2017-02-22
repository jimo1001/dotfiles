;;; inits --- Emacs-helm Settings
;;; Commentary:

;;; Code:

(use-package helm
  :diminish helm-mode
  :bind
  (("M-x" . helm-M-x)
   ("C-x C-f" . helm-find-files)
   ("C-x C-r" . helm-recentf)
   ("C-x b" . helm-buffers-list)
   ("C-c C-f" . helm-find-files+)
   ("C-c C-b" . helm-bookmarks)
   ("C-c h" . helm-mini)
   ("C-c y" . helm-show-kill-ring)
   ("C-c o" . helm-occur)
   ("C-c /" . helm-swoop)
   ("C-c ?" . helm-ag)
   ("C-c p h" . helm-projectile)
   ("C-c z" . helm-perspeen)
   ("C-c v g" . helm-ls-git-ls)
   ("C-c v s" . helm-ls-svn-ls)
   ("<f1> b" . helm-descbinds)
   ("<f1> m" . helm-describe-modes)
   ("<f1> ?" . helm-info)
   :map helm-map ("C-h" . delete-backward-char)
   :map helm-find-files-map ("TAB" . helm-execute-persistent-action)
   :map helm-read-file-map ("TAB" . helm-execute-persistent-action))

  :config
  (use-package helm-config)
  (use-package helm-buffers)
  (use-package helm-files)
  (use-package helm-projectile)
  (use-package helm-ls-git)
  (use-package helm-ls-svn)
  (use-package helm-ag)
  (use-package helm-perspeen)

  (custom-set-faces
   '(helm-buffer-directory ((t (:background "#080808" :foreground "#8787ff"))))
   '(helm-ff-directory ((t (:background "#080808" :foreground "#8787ff"))))
   '(helm-ff-dotted-directory ((t (:background "#080808" :foreground "#8787ff"))))
   '(helm-ff-dotted-symlink-directory ((t (:background "#333333" :foreground "#ab82ff"))))
   '(helm-ff-file ((t (:inherit default :foreground "Gray"))))
   '(helm-ff-symlink ((t (:background "#080808" :foreground "#ffa8a8"))))
   '(helm-header ((t (:background "#1c1c1c" :foreground "#5f87ff"))))
   '(helm-selection ((t (:inherit match))))
   '(helm-candidate-number ((t (:inherit mode-line :inherit font-lock-keyword-face))))
   '(helm-source-header ((t (:background "#262626" :foreground "#e5e5e5" :weight bold))))
   '(helm-visible-mark ((t (:background "#9e1200" :foreground "#ffffff")))))

 (defun helm-find-files+ ()
    (interactive
     (helm '(helm-source-files-in-current-dir helm-source-ls-git helm-source-ls-svn))))
  ;; default sources
  (setq helm-mini-default-sources
        '(helm-source-perspeen-tabs
          helm-source-buffers-list
          helm-source-bookmarks
          helm-source-perspeen-workspaces
          helm-source-projectile-projects
          helm-source-recentf
          helm-source-buffer-not-found))
  (helm-mode 1)
  ;; boring buffers
  (add-to-list 'helm-boring-buffer-regexp-list "\\*Backtrace\\*")
  (add-to-list 'helm-boring-buffer-regexp-list "\\*Buffer List\\*")
  ;; kill buffer hook
  (add-hook 'helm-kill-buffer-hook #'(set-buffer "*scratch*")))

(use-package shackle
  :no-require t
  :defer t
  :config
  ;; split window issue workaround
  ;; https://github.com/wasamasa/shackle/issues/28
  (push '("\\`\\*helm.*?\\*\\'" :regexp t :align below :size 0.5) shackle-rules)

  ;; Turn off `shackle-mode' when there is only one window
  (add-hook 'helm-before-initialize-hook
            (defun helm-disable-shackle-mode-maybe ()
              (when (one-window-p)
                (shackle-mode -1))))

  ;; Turn on `shackle-mode' when quitting helm session normally
  (add-hook 'helm-exit-minibuffer-hook #'shackle-mode)

  (defun helm-keyboard-quit--enable-shackle-mode (orig-func &rest args)
    "Turn on `shackle-mode' when quitting helm session abnormally.
ORIG-FUNC: original helm function.
ARGS: ORIG-FUNC's arguments."
    (shackle-mode)
    (apply orig-func args))
  (advice-add 'helm-keyboard-quit :around #'helm-keyboard-quit--enable-shackle-mode))

;;; 20-helm.el ends here
