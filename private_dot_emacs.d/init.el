;; -*- lexical-binding: t; -*-

;; Do not create backup/auto-save files.
(setq make-backup-files nil
      auto-save-default nil)

;; Keep files clean on save.
(add-hook 'before-save-hook #'delete-trailing-whitespace)
(setq require-final-newline t)
(setq-default show-trailing-whitespace t)

;; Disable audible bell.
(setq ring-bell-function #'ignore)

;; Show time in mode line.
(display-time-mode 1)

;; package.el setup

(require 'package)

;; On Emacs 27+, package.el may auto-initialize before init.el.
;; Disable that to avoid double initialization and ensure a single, predictable flow.
(setq package-enable-at-startup nil)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

;; Refresh archive contents only when needed.
(unless package-archive-contents
  (package-refresh-contents))

;; Ensure required packages are installed

(dolist (pkg '(ddskk))
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; SKK (DD-SKK)

(require 'skk)

(setq skk-server-host "localhost"
      skk-server-portnum 1178)

(global-set-key (kbd "C-x C-j") #'skk-mode)

(add-hook 'isearch-mode-hook
          (lambda ()
            (when (and (boundp 'skk-mode) skk-mode)
              (skk-isearch-mode-setup))))
(add-hook 'isearch-mode-end-hook
          (lambda ()
            (when (and (boundp 'skk-mode) skk-mode)
              (skk-isearch-mode-cleanup))
            (when (and (boundp 'skk-mode-invoked) skk-mode-invoked)
              (skk-set-cursor-properly))))


;; macOS-specific settings

(when (eq system-type 'darwin)
  (setq ns-command-modifier 'meta
        ns-alternate-modifier 'super)
  (when (boundp 'mac-pass-control-to-system)
    (setq mac-pass-control-to-system nil)))


;; Fonts

(defun my/font-available-p (family)
  "Return non-nil if font FAMILY exists on this system."
  (when (and family (fboundp 'find-font))
    (find-font (font-spec :family family))))

(defun my/set-default-font (families height)
  "Set the default font to the first available in FAMILIES at HEIGHT."
  (when-let ((fam (seq-find #'my/font-available-p families)))
    (set-face-attribute 'default nil :family fam :height height)))

;; Default (Latin) font preference per OS.
(cond
 ((eq system-type 'darwin)
  (my/set-default-font '("Monaco" "Menlo" "SF Mono") 130))
 ((eq system-type 'windows-nt)
  (my/set-default-font '("Cascadia Mono" "Consolas") 120))
 (t ;; GNU/Linux and others
  (my/set-default-font '("JetBrains Mono" "DejaVu Sans Mono" "Noto Sans Mono") 120)))

;; Japanese font fallback (only set if present).
;; macOS example: "Hiragino Maru Gothic ProN"
(when (my/font-available-p "Hiragino Maru Gothic ProN")
  (set-fontset-font t 'japanese-jisx0208 (font-spec :family "Hiragino Maru Gothic ProN"))
  (set-fontset-font t 'katakana-jisx0201 (font-spec :family "Hiragino Maru Gothic ProN")))
