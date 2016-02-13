;;; 30-snippet --- inits
;;; Commentary:

;;; Code:

(when (require 'yasnippet nil t)
  (global-set-key (kbd "C-c C-y") 'yas/insert-snippet)
  (yas-global-mode 1))

;;; 30-snippet.el ends here
