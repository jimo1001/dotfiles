;;; theme --- custom theme
;;; Commentary:

;;; Code:

(deftheme simple-dark
  "User custom theme")

(custom-theme-set-faces
 'simple-dark

 ;; Built-in Faces
 '(bold ((t (:bold t :weight bold))))
 '(bold-italic ((t (:inherit italic :bold t :weight bold))))
 '(border ((t (:background "#080808"))))
 '(cursor ((t (:background "#90ee90" :foreground "#080808"))))
 '(default ((t (:background "#080808" :foreground "#cfcfcf"))))
 '(error ((t (:background "#870000"))))
 '(escape-glyph ((t (:foreground "#00cdcd"))))
 '(fixed-pitch ((t (nil))))
 '(fringe ((t (:background "#121212"))))
 '(header-line ((t (:background "#121212" :foreground "#ffffff" :inverse-video nil :underline nil))))
 '(help-argument-name ((t (nil))))
 '(highlight ((t (:background "#00005f" :foreground "#e5e5e5"))))
 '(italic ((t (:italic t :slant italic))))
 '(link ((t (:foreground "#00cdcd" :underline t))))
 '(link-visited ((t (:foreground "#cd00cd" :underline t))))
 '(match ((t (:background "#871212"))))
 '(menu ((t (nil))))
 '(minibuffer-prompt ((t (:bold t :foreground "#5f5fd7" :weight bold))))
 '(mode-line ((t (:background "#262626" :foreground "#a8a8a8"))))
 '(mode-line-buffer-id ((t (:inherit mode-line :foreground "#cfcfcf"))))
 '(mode-line-emphasis ((t (:inherit mode-line :weight bold))))
 '(mode-line-highlight ((t (:inherit mode-line :foreground "#fcfcfc" :weight bold))))
 '(mouse ((t (nil))))
 '(nobreak-space ((t (:inherit escape-glyph :underline t))))
 '(region ((t (:background "#870000"))))
 '(scroll-bar ((t (nil))))
 '(secondary-selection ((t (:background "#5f5fd7"))))
 '(shadow ((t (:foreground "#a8a8a8"))))
 '(show-paren-match ((t (:background "#104e8b" :foreground nil :weight bold))))
 '(show-paren-mismatch ((t (:background "#870000" :foreground nil :weight bold))))
 '(success ((t (:foreground "#04f900"))))
 '(tool-bar ((t (nil))))
 '(underline ((t (:underline t))))
 '(variable-pitch ((t (nil))))
 '(vertical-border ((t (:background "#303030" :foreground "#666666" :box (:line-width -1 :color "#303030" :style nil) :weight light))))
 '(warning ((t (:background "#666600"))))
 '(whitespace-trailing ((t (:background "#8a0f00"))))

 ;; Basic Editor Colors
 '(font-lock-builtin-face ((t (:foreground "#5f5fff"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#a9a9a9"))))
 '(font-lock-comment-face ((t (:foreground "#878787"))))
 '(font-lock-constant-face ((t (:foreground "#d75f00"))))
 '(font-lock-doc-face ((t (:foreground "#cdcd00"))))
 '(font-lock-function-name-face ((t (:foreground "#00afaf"))))
 '(font-lock-keyword-face ((t (:foreground "#1e90ff"))))
 '(font-lock-negation-char-face ((t (:foreground "#afafaf"))))
 '(font-lock-preprocessor-face ((t (:foreground "#8c8cff"))))
 '(font-lock-regexp-grouping-backslash ((t (:foreground "#5faf5f"))))
 '(font-lock-regexp-grouping-construct ((t (:foreground "#00ee76"))))
 '(font-lock-string-face ((t (:foreground "#cdcd33" :weight light))))
 '(font-lock-type-face ((t (:foreground "#90ee90"))))
 '(font-lock-variable-name-face ((t (:foreground "#5fd75f"))))
 '(font-lock-warning-face ((t (:background nil :foreground "#afaf00"))))

 ;; Misc
 '(buffer-menu-buffer ((t (:bold t :weight bold))))
 '(button ((t (:underline t))))
 '(change-log-acknowledgement ((t (:foreground "#cd0000"))) t)
 '(change-log-conditionals ((t (:bold t :foreground "#e5e5e5" :weight bold))))
 '(change-log-date ((t (:foreground "#5c5cff"))))
 '(change-log-email ((t (:bold t :foreground "#e5e5e5" :weight bold))))
 '(change-log-file ((t (:foreground "#5f87af"))))
 '(change-log-function ((t (:bold t :foreground "#e5e5e5" :weight bold))))
 '(change-log-list ((t (:foreground "#00ffff"))))
 '(change-log-name ((t (:foreground "#ffff00"))))
 '(file-name-shadow ((t (:foreground "#a8a8a8"))))
 '(info-node ((t (:bold t :foreground "#5f5faf" :underline t :weight bold))))
 '(info-xref ((t (:foreground "#5f5fd7" :underline t))))
 '(isearch ((t (:background "#0000ee"))))
 '(isearch-fail ((t (:background "#870000"))))
 '(lazy-highlight ((t (:background "#870000" :foreground "#e5e5e5"))))
 '(list-mode-item-selected ((t (:background "#5f5faf" :foreground "#e5e5e5"))))
 '(message-cited-text-face ((t (:foreground "#e5e5e5"))) t)
 '(message-header-cc-face ((t (:foreground "#5f87af"))) t)
 '(message-header-name-face ((t (:foreground "#e5e5e5"))) t)
 '(message-header-newsgroups-face ((t (:bold t :foreground "#0000ee" :weight bold))) t)
 '(message-header-other-face ((t (:foreground "#5f5faf"))) t)
 '(message-header-subject-face ((t (:bold t :foreground "#5f87af" :weight bold))) t)
 '(message-header-to-face ((t (:bold t :foreground "#5f87af" :weight bold))) t)
 '(message-header-xheader-face ((t (:foreground "#0000ee"))) t)
 '(message-separator-face ((t (:foreground "#875f00"))) t)
 '(next-error ((t (:background "#000087" :foreground "#e5e5e5"))))
 '(outline-1 ((t (:foreground "#ff6666"))))
 '(outline-2 ((t (:foreground "#ff9200"))))
 '(outline-3 ((t (:foreground "#ab82ff"))))
 '(outline-4 ((t (:foreground "#90ee90"))))
 '(outline-5 ((t (:foreground "#4876ff"))))
 '(outline-6 ((t (:foreground "#ffb90f"))))
 '(outline-8 ((t (:foreground "#8b8b00"))))
 '(query-replace ((t (:background "#0000d7"))))
 '(tooltip ((t (:background "#121212" :foreground "#ffffff"))))
 '(widget-button ((t (:bold t :weight bold))))
 '(widget-button-pressed ((t (:background "#080808" :foreground "#cd0000"))))
 '(widget-documentation ((t (:background "#e5e5e5" :foreground "#00cd00"))))
 '(widget-field ((t (:background "#dadada" :foreground "#080808"))))
 '(widget-inactive ((t (:background "#cd0000" :foreground "#7f7f7f"))))
 '(widget-single-line-field ((t (:background "#dadada" :foreground "#080808")))))

(provide-theme 'simple-dark)

;;; simple-dark-theme.el ends here
