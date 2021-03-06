(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(setq el-get-dir (locate-user-emacs-file "packages"))
(setq el-get-user-package-directory (locate-user-emacs-file "init-files"))
(add-to-list 'el-get-recipe-path (locate-user-emacs-file "recipes"))

(el-get-bundle init-loader)

(el-get-bundle auto-complete)
(el-get-bundle ddskk)
(el-get-bundle dockerfile-mode)
(el-get-bundle exec-path-from-shell)
(el-get-bundle js2-mode)
(el-get-bundle matlab-mode)
(el-get-bundle markdown-mode)
(el-get-bundle migemo)
(el-get-bundle navi2ch)
(el-get-bundle nginx-mode)
(el-get-bundle yaml-mode)
