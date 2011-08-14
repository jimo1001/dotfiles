;; -*- coding: utf-8; mode: emacs-lisp; -*-
;;; surround.el --- mark support

;; Author: Yoshinobu Fujimoto
;; Keywords: support mark control

;; This file is part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; * 設定(通常)
;; (require 'surround)
;; (global-set-key (kbd "C-SPC") 'surround-set-mark-command)
;;
;; * 設定(cuaと併用する場合)
;; (defadvice cua-set-mark (around extended-CUA-set-mark activate)
;;   (if mark-active
;;       (surround-set-mark)
;;     ad-do-it))
;;

;;; Code:

;;; Customization
(defgroup surround nil
  "surround.el"
  :prefix "surround"
  :group 'editing-basics
  :group 'convenience
  :group 'emulations
  :version "23.3")

;; keymap variables
(defvar surround-region-keymap (make-sparse-keymap))
(defvar surround--ena-region-keymap nil)
(defvar surround-keymap-alist
  `((surround--ena-region-keymap . ,surround-region-keymap)))

(defvar surround-keymaps-initiazied nil)

;; status string for mode line indications
(defvar surround-status-string nil)
(make-variable-buffer-local 'surround-status-string)

(defun surround-select-keymaps ()
  (setq surround--ena-region-keymap
        (and mark-active (not deactivate-mark))))

(defun surround-set-mark-command ()
  (interactive)
  (if (and mark-active (not deactivate-mark))
      (surround-set-mark)
    (set-mark (point))))

(defun surround-set-mark (&optional pos)
  (interactive)
  (let ((begin (region-beginning))
        (end (region-end))
        (syntax (string (char-syntax (char-after)))))
    (or pos (setq pos begin))
    (goto-char pos)
    (cond
     ((eq begin end) ;; no region
      (if (member syntax '("w" " "))
          (skip-syntax-backward syntax))
      (set-mark (point))
      (if (string= syntax " ")
          (skip-syntax-forward " ")
        (surround-forward)) t)
     (t
      (set-mark (point))
      (cond
       ;; page
       ((surround-page-at-region begin end)
        nil)
       ;; defun
       ((surround-defun-at-region begin end)
         (goto-char (point-min))
         (set-mark (point))
         (goto-char (point-max)))
       ;; line
       ((surround-line-at-region begin end)
        (goto-char pos)
        (if (string= (string (char-syntax (char-after))) " ")
            (skip-syntax-forward " "))
        (forward-char 1)
        (beginning-of-defun)
        (skip-syntax-forward " >")
        (set-mark (point))
        (end-of-defun)
        (skip-syntax-backward " >"))
       ;; sexp
       ((surround-sexp-at-region begin end)
        (goto-char (line-beginning-position))
        (skip-syntax-forward " ")
        (set-mark (point))
        (goto-char (line-end-position)))
       ;; word
       (t
        (if (not (surround-special-syntax-before))
            (progn
              (backward-sexp)
              (set-mark (point))
              (goto-char end)))
        (if (not (surround-special-syntax-after))
            (surround-forward "sexp")))))))
  (surround-select-keymaps))

(defun surround-forward (&optional skip)
  (cond
   ((eolp)
    (skip-chars-forward " \t\n")
    (beginning-of-line))
   ((or
     (= (char-syntax (char-after)) ?\()
     (string= skip "sexp"))
    (forward-sexp 1))
   ((or (= (char-syntax (char-after)) ?\<)
        (string= skip "comment"))
    (forward-comment 1)
    (and (bolp) (backward-char 1)))
   ((string= skip "paragraph")
    (forward-paragraph 1))
   ((= (char-syntax (char-after)) ?\ )
    (cond
     ((bolp)
      (skip-syntax-forward " "))
     (t
      (skip-syntax-forward " ")
      (cond
       ((member (char-syntax (char-after)) '(?w ?_))
        (skip-syntax-forward "w_"))
       ((= (char-syntax (char-after)) ?\()
        (forward-sexp 1))
       ((= (char-syntax (char-after)) ?\")
        (re-search-forward
         (concat "[^\\]\\(\\\\\\\\\\)*" (string (char-after)))))
       ))
     ))
   ((= (char-syntax (char-after)) ?\")
    (re-search-forward
     (concat "[^\\]\\(\\\\\\\\\\)*" (string (char-after)))))
   (t
    (skip-syntax-forward (string (char-syntax (char-after)))))
   ))

(defun surround-page-at-region (&optional begin end)
  (or begin (setq begin (region-beginning)))
  (or end (setq end (region-end)))
  (and (= begin (point-min))
       (= end (point-max))
       t))

(defun surround-defun-at-region (&optional begin end)
  (interactive)
  (or begin (setq begin (region-beginning)))
  (or end (setq end (region-end)))
  (let ((ret nil)
        (begin-defun nil)
        (end-defun nil))
    (goto-char begin)
    (forward-char 1)
    (beginning-of-defun)
    (setq begin-defun (append begin-defun (list (point))))
    (skip-syntax-forward " >")
    (setq begin-defun (append begin-defun (list (point))))
    (end-of-defun)
    (setq end-defun (append end-defun (list (point))))
    (skip-syntax-backward " >")
    (setq end-defun (append end-defun (list (point))))
    (setq ret (and (member begin begin-defun)
                 (member end end-defun) t))
    (goto-char end)
    ret))

(defun surround-word-at-region (&optional begin end)
  (or begin (setq begin (region-beginning)))
  (or end (setq end (region-end)))
  (eq (string-match "^\\([a-zA-Z]\\)+$" (buffer-substring begin end)) 0))

(defun surround-sexp-at-region (&optional begin end)
  (or begin (setq begin (region-beginning)))
  (or end (setq end (region-end)))
  (and (or (not (surround-word-at-region begin end))
           (and (surround-special-syntax-after end)
                (surround-special-syntax-before begin)))
       (> (length (buffer-substring begin end)) 1)
       (eq (string-match "^\\([^ ]\\)*\\(\\|_\\|-\\)+\\([^ ]\\)*$" (buffer-substring begin end)) 0)))

(defun surround-line-at-region (&optional begin end)
  (interactive)
  (or begin (setq begin (region-beginning)))
  (or end (setq end (region-end)))
  (let ((ret nil)
        (pos-list nil))
    (beginning-of-line)
    (setq pos-list (append pos-list (list (point))))
    (skip-syntax-forward " ")
    (setq pos-list (append pos-list (list (point))))
    (end-of-line)
    (setq pos-list (append pos-list (list (point))))
    (skip-syntax-backward " ")
    (setq pos-list (append pos-list (list (point))))
    (setq ret (and
               (member begin pos-list)
               (member end pos-list) t))
    (goto-char end)
    ret))

;; *memo: syntax tables*
;;  -   whitespace character        /   character quote character
;;  w   word constituent            $   paired delimiter
;;  _   symbol constituent          '   expression prefix
;;  .   punctuation character       <   comment starter
;;  (   open delimiter character    >   comment ender
;;  )   close delimiter character   !   generic comment delimiter
;;  "   string quote character      |   generic string delimiter
;;  \   escape character
(defun surround-check-syntaxes (syntaxes &optional char)
  (or char (setq char (char-after (point))))
  (if (member (char-to-string (char-syntax char)) syntaxes)
      t nil))

(defun surround-special-syntax-before (&optional pos)
  (or pos (setq pos (point)))
  (surround-check-syntaxes '(" "  "'" "\"" "(" ")" "<") (char-before pos)))

(defun surround-special-syntax-after (&optional pos)
  (or pos (setq pos (point)))
  (surround-check-syntaxes '(" "  "'" "\"" "(" ")" ">") (char-after pos)))

(defun surround-insert (args1 &optional args2 begin end)
  (interactive)
  (or begin (setq begin (region-beginning)))
  (or end (setq end (region-end)))
  (or args2 (setq args2 args1))
  (let ((len (length args1)))
    (goto-char begin)
    (insert args1)
    (goto-char (+ len end))
    (insert args2)))

(defun surround-insert-quort ()
  (interactive)
  (surround-insert "'"))

(defun surround-insert-dblquort ()
  (interactive)
  (surround-insert "\""))

(defun surround-insert-paren ()
  (interactive)
  (surround-insert "(" ")"))

(defun surround-insert-bracket ()
  (interactive)
  (surround-insert "<" ">"))

(defun surround-insert-brace ()
  (interactive)
  (surround-insert "{" "}"))

(defun surround-init-keymaps ()
  ;; actual keymap
  (define-key surround-region-keymap (kbd "'") 'surround-insert-quort)
  (define-key surround-region-keymap (kbd "\"") 'surround-insert-dblquort)
  (define-key surround-region-keymap (kbd "(") 'surround-insert-paren)
  (define-key surround-region-keymap (kbd "<") 'surround-insert-bracket)
  (define-key surround-region-keymap (kbd "{") 'surround-insert-brace))

(unless surround-keymaps-initiazied
  (surround-init-keymaps)
  (setq surround-keymaps-initiazied t))

(defun surround-post-command-handler ()
  (when surround-mode
    (condition-case nil
        (surround-select-keymaps)
      (error nil))))

(defun surround-pre-command-handler ()
  (when surround-mode
    (condition-case nil t
      (error nil))))

(define-minor-mode surround-mode
  "Toggle surround key-binding mode."
  :global t
  :group 'surround
  :link '(emacs-commentary-link "surround.el")

  (unless surround-keymaps-initiazied
    (surround-init-keymaps)
    (setq surround-keymaps-initiazied t))

  (if surround-mode
      (progn
        (add-hook 'pre-command-hook 'surround-pre-command-handler)
        (add-hook 'post-command-hook 'surround-post-command-handler)
        (if (not (assoc 'surround-mode minor-mode-alist))
            (setq minor-mode-alist (cons '(surround-mode surround-status-string) minor-mode-alist))))
    (remove-hook 'pre-command-hook 'cua--pre-command-handler)
    (remove-hook 'post-command-hook 'surround-post-command-handler))
  
  (if (not surround-mode)
      (setq emulation-mode-map-alists (delq 'surround-keymap-alist emulation-mode-map-alists))
    (add-to-ordered-list 'emulation-mode-map-alists 'surround-keymap-alist 400)
    (surround-select-keymaps)))

(provide 'surround)
