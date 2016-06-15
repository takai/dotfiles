(require 'nginx-mode)
(add-to-list 'auto-mode-alist '("nginx\\(.*\\).conf[^/]*$" . nginx-mode))
(custom-set-variables '(nginx-indent-level 2))
