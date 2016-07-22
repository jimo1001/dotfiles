;;; 25-snippet --- inits
;;; Commentary:

;;; Code:

(when (locate-library "yasnippet")
  (yas-global-mode 1)
  (global-set-key (kbd "C-c C-y") 'yas/insert-snippet))

;;; 25-snippet.el ends here
