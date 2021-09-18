;;; inits --- Version Control System
;;; Commentary:

;;; Code:

(use-package magit
  :defer 5)

(use-package git-gutter
  :ensure t
  :init
  (custom-set-variables
   '(git-gutter:handled-backends '(git hg bzr)))
  (global-git-gutter-mode +1))

;;; 60-vcs.el ends here
