;;; 00-functions --- inits
;;; Commentary:

;;; Code:

;; Add info-path
(setq Info-default-directory-list
      (append (list "~/.emacs.d/info") Info-default-directory-list))

;; for debug
(defun init-loader-re-load (re dir &optional sort)
  (let ((load-path (cons dir load-path)))
    (dolist (el (init-loader--re-load-files re dir sort))
      (condition-case e
          (let ((time (car (benchmark-run (load (file-name-sans-extension el))))))
            (init-loader-log (format "loaded %s. %s" (locate-library el) time)))
        (error
         ;; (init-loader-error-log (error-message-string e))
         (init-loader-error-log
          (format "%s. %s" (locate-library el) (error-message-string e))))))))

;; create empty file
(defun create-empty-file (file)
  (rename-file (make-temp-file file) file))

;; create temp directory
(if (not (file-directory-p "~/.emacs.d/tmp"))
    (make-directory "~/.emacs.d/tmp" t))

;; Autoload for "when" function
(defun autoload-if-found (functions file &optional docstring interactive type)
  "set autoload iff. FILE has found."
  (if (not (listp functions))
      (setq functions (list functions)))
  (if (locate-library file)
      (progn
        (dolist (function functions)
          (autoload function file docstring interactive type))
        t)
    (message "[WARNING] file %s is not found. (autoload-if-found)" file)))


(defun x->bool (elt) (not (not elt)))

;; emacs-version predicates
(dolist (ver '("22" "23" "24" "23.0" "23.1" "23.2" "23.3" "24.1" "24.2" "24.3" "24.4"))
  (set (intern (concat "emacs" ver "-p"))
       (if (string-match (concat "^" ver) emacs-version)
           t nil)))
;; verification
;; (mapcar (lambda (x) (if (boundp x) (symbol-value x) 'none))
;; '(emacs22-p emacs23-p emacs23.0-p
;; emacs23.1-p emacs23.2-p emacs23.3-p))

;; system-type predicates
(setq darwin-p (eq system-type 'darwin)
      ns-p (eq window-system 'ns)
      carbon-p (eq window-system 'mac)
      linux-p (eq system-type 'gnu/linux)
      colinux-p (when linux-p
                  (let ((file "/proc/modules"))
                    (and
                     (file-readable-p file)
                     (x->bool
                      (with-temp-buffer
                        (insert-file-contents file)
                        (goto-char (point-min))
                        (re-search-forward "^cofuse\.+" nil t))))))
      cygwin-p (eq system-type 'cygwin)
      nt-p (eq system-type 'windows-nt)
      meadow-p (featurep 'meadow)
      windows-p (or cygwin-p nt-p meadow-p))

;;; 00-functions.el ends here
