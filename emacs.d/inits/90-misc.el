;;; inits --- Utility functions, settings of trial used packages and so on.
;;; Commentary:

;;; Code:

(defun indent-selector ()
  "Indent all lines in region."
  (interactive)
  (if mark-active
      (indent-region (region-beginning) (region-end) nil)
    (indent-for-tab-command)))
(global-set-key (kbd "C-i") 'indent-selector)

(defun toggle-truncate-lines (&optional arg)
  "Toggle the truncate lines.
Truncate lines if ARG is non-nil."
  (interactive)
  (if (or arg (not truncate-lines))
      (setq truncate-lines t)
    (setq truncate-lines nil))
  (recenter))
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert ARG."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(global-set-key (kbd "C-c . o") 'match-paren)

(defun backward-delete-char-untabify (n &optional killflag)
  "Delete selection charactors with backward-delete.
Delete the previous N characters (following if N is negative).
Optional second arg KILLFLAG, if non-nil, means to kill (save in
kill ring) instead of delete."
  (interactive "p")
  (if (and transient-mark-mode mark-active)
      (delete-region (region-beginning) (region-end)))
  (backward-delete-char n killflag))
(global-set-key (kbd "C-h") 'backward-delete-char-untabify)

(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))
(global-set-key (kbd "C-c . f") 'describe-face-at-point)

(defun beginning-of-indented-line (current-point)
  "Move the cursor to beginning line.
CURRENT-POINT is current cursor point."
  (interactive "d")
  (if (string-match
       "^[ ¥t]+$"
       (save-excursion
         (buffer-substring-no-properties
          (progn (beginning-of-line) (point))
          current-point)))
      (beginning-of-line)
    (back-to-indentation)))

(advice-add 'move-beginning-of-line
            :around #'(lambda (orig-func &rest args)
                        (beginning-of-indented-line (point))))

(use-package ansible-inventory-generic-mode
  :commands (ansible-inventory-generic-mode)
  :load-path "site-lisp/")

(use-package outline
  :defer t
  :diminish (outline-mode outline-minor-mode))

;;; 90-misc.el ends here
