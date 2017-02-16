;;; ansible-inventory-generic-mode --- Generic major-mode for ansible inventory files.
;;; Commentary:

;;; Code:

(require 'generic-x)

;; Ansible inventory files
;;;###autoload
(define-generic-mode ansible-inventory-generic-mode
  '(?#)
  nil
  '(("^\\s-*\\(\\[.*\\]\\)" 1 font-lock-constant-face)
    ("\\([^ =\n\r]+\\)=\\([^ \n\r]*\\)"
     (1 font-lock-variable-name-face)
     (2 font-lock-keyword-face))
    ("^\\s-*\\([^ =\n\r]*\\)" 1 font-lock-function-name-face))
  '("inventory")
  (list
   (function
    (lambda ()
      (setq imenu-generic-expression
            '((nil "^\\s-*\\[\\(.*\\)\\]" 1)
              ("*Variables*" "\\s-+\\([^ =\n\r]+\\)=" 1))))))
  "Generic mode for Ansible inventory files.")
(add-to-list 'generic-extras-enable-list 'ansible-inventory-generic-mode t)

;;; ansible-inventory-generic-mode.el ends here
