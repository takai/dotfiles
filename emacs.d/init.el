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

(el-get-bundle ddskk)
(el-get-bundle migemo)
(el-get-bundle navi2ch)

