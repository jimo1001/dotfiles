;;; 60-faces --- inits
;;; Commentary:

;;; Code:
(defgroup myface nil
  "my custom faces." :prefix "myface-" :group 'convenience)

(defface myface-highlight-return
  '((t (:background "#000000")))
  "Face for return code(\x0d)." :group 'myface)

(defvar myface-highlight-return-face 'myface-highlight-return
  "Face for return code(\x0d).")

(defface myface-highlight-double-space
  '((t (:background "#444444")))
  "Face for double byte space." :group 'myface)

(defvar myface-highlight-double-space-face 'myface-highlight-double-space
  "Face for double byte space.")

(defface myface-highlight-head-half-space
  '((t (:foreground "#262626" :underline t)))
  "Face for head of half size space." :group 'myface)

(defvar myface-highlight-head-half-space-face 'myface-highlight-head-half-space
  "Face for head of half size space.")

(defface myface-highlight-head-tab
  '((t (:background "#121212")))
  "Face for head of tab." :group 'myface)

(defvar myface-highlight-head-tab-face 'myface-highlight-head-tab
  "Face for head of tab.")

(defface myface-highlight-end-tab-space
  '((t (:foreground "#5f0000" :underline t)))
  "Face for end of tab." :group 'myface)

(defvar myface-highlight-end-tab-space-face 'myface-highlight-end-tab-space
  "Face for end of tab.")

(defadvice font-lock-mode (before my-font-lock-mode ())
  ;; append: face list の後に追加, prepend: 先頭に追加
  (font-lock-add-keywords
   major-mode
   '(("[\r\n]*\n" 0 myface-highlight-return-face prepend)
     ("　" 0 myface-highlight-double-space-face prepend)
     ("^[ ]+" 0 myface-highlight-head-half-space-face prepend)
     ("^[\t]+" 0 myface-highlight-head-tab-face prepend)
     ("[ \t]+$" 0 myface-highlight-end-tab-space-face prepend))))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;;; 60-faces.el ends here
