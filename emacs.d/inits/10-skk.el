;;; inits --- SKK Settings
;;; Commentary:

;;; Code:

(use-package skk
  :bind ("C-x j" . skk-mode)
  :init
  ;; Jisyo charactor encoding
  (setq skk-jisyo-code 'euc-jp-unix)

  ;; Default Jisyo
  (setq skk-get-jisyo-directory "~/.emacs.d/share/skk/"
        skk-large-jisyo "~/.emacs.d/share/skk/SKK-JISYO.L")

  ;; Extra Jisyo
  (setq skk-extra-jisyo-file-list
        (list '("~/.emacs.d/share/skk/SKK-JISYO.JIS3_4" . euc-jisx0213)
              "~/.emacs.d/share/skk/SKK-JISYO.zipcode"))

  ;; SKK settings
  (setq skk-auto-insert-paren t
        skk-auto-okuri-process nil
        skk-auto-start-henkan t
        skk-check-okurigana-on-touroku nil
        skk-delete-implies-kakutei t
        skk-egg-like-newline t
        skk-henkan-okuri-strictly nil
        skk-henkan-strict-okuri-precedence nil
        skk-inline-show-background-color "#303030"
        skk-inline-show-background-color-odd "#505050"
        skk-inline-show-face nil
        skk-isearch-start-mode 'latin
        skk-j-mode-function-key-usage nil
        skk-japanese-message-and-error nil
        skk-kakutei-early t
        skk-kuten-touten-alist '((jp . ("。" . "、" )) (en . ("．" . "，")))
        skk-kutouten-type 'jp
        skk-preload t
        skk-share-private-jisyo nil
        skk-show-annotation nil
        skk-show-candidates-always-pop-to-buffer t
        skk-show-icon nil
        skk-show-inline 'vertical
        skk-show-japanese-menu t
        skk-show-tooltip nil
        skk-sticky-key ";"
        skk-use-color-cursor t
        skk-use-face t
        skk-use-jisx0201-input-method nil
        skk-use-look nil
        skk-use-numeric-conversion t
        skk-verbose nil))

;;; 10-skk.el ends here
