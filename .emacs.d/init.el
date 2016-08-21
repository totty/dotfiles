;; brewで入れたtool用のpathを追加
(add-to-list 'load-path "/usr/local/homebrew/share/emacs/site-lisp")

(require 'cask "cask.el")
(cask-initialize)

(if window-system
    (custom-set-variables
     '(initial-frame-alist (quote ((fullscreen . maximized))))))

;; メニューバーを表示しない
(menu-bar-mode 0)
;; スタートアップメッセージを表示させない
(setq inhibit-startup-message 1)
;; バックアップを残さない
(setq make-backup-files nil)
;; インデントにTABを使わないようにする
(setq-default indent-tabs-mode nil)

;; 行番号の表示
(require 'linum)
(global-linum-mode)
(setq linum-format "%4d: ")
;;(global-set-key "\M-n" 'linum-mode) ;; 行番号表示切替
;; linum-mode を軽く
;; http://d.hatena.ne.jp/daimatz/20120215/1329248780
(setq linum-delay 1)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; 桁番号の表示
(column-number-mode 1)

;; 時間を表示
(display-time)

;; 対応する括弧をハイライト
(show-paren-mode 1)

;; メタキーの変更設定
;; CommandとOptionを入れ替える
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; '¥' を入力したら '\' となるように
(define-key global-map [?¥] [?\\])

;; キーセットの設定
(global-set-key "\C-z" 'undo) 
(global-set-key "\C-cc" 'comment-region)    ; C-c c を範囲指定コメントに
(global-set-key "\C-cu" 'uncomment-region)  ; C-c u を範囲指定コメント解除に

;; C-Ret で矩形選択
;; 詳しいキーバインド操作：http://dev.ariel-networks.com/articles/emacs/part5/
(cua-mode 1)
(setq cua-enable-cua-keys nil)

;;----- Macの日本語関係
(prefer-coding-system 'utf-8)
(when (fboundp 'mac-input-source)
  (defun my-mac-selected-keyboard-input-source-chage-function ()
    (let ((mac-input-source (mac-input-source)))
      (set-cursor-color
        (if (string-match "com.apple.inputmethod.Kotoeri.Roman" mac-input-source)
            "Yellow" "Red"))))
  (add-hook 'mac-selected-keyboard-input-source-change-hook
            'my-mac-selected-keyboard-input-source-chage-function))

;; ミニバッファに入力時、自動的に英語モード
(when (functionp 'mac-auto-ascii-mode)
  (mac-auto-ascii-mode 1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CUI Only
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (not window-system) (progn

  ;; ここに設定を書く

))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GUI Only
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if window-system (progn

  ;; ツールバーを表示しない
  (tool-bar-mode 0)
  (scroll-bar-mode 0)

  (load-theme 'wombat 1)

  ;(set-frame-parameter nil 'fullscreen 'maximized)            ;; 最大化して開く
  (add-to-list 'default-frame-alist '(alpha . (90 85)))     ;; 透過
;;  (load-theme 'tangotango t)
;;  (require 'server)
;;  (unless (server-running-p)
;;       (server-start) ) ;; GUIで起動するときはサーバーも起動

  ;; C-x C-c で終了させてしまわないように変更
  (global-set-key (kbd "C-x C-c") 'kill-this-buffer)

  (add-to-list 'default-frame-alist '(font . "ricty-13.5"))
  (when (equal system-type 'darwin)
    (setq mac-option-modifier 'meta))


  ;; Magit
  (require 'magit)
  (define-key global-map "\C-x\C-g" 'magit-status)
  (custom-set-faces
   '(magit-diff-added ((t (:background "black" :foreground "green"))))
   '(magit-diff-added-highlight ((t (:background "white" :foreground "green"))))
   '(magit-diff-removed ((t (:background "black" :foreground "blue"))))
   '(magit-diff-removed-hightlight ((t (:background "white" :foreground "blue"))))
   '(magit-hash ((t (:foreground "red"))))
  )

))

