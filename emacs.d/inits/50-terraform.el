;;; inits --- Terraform
;;; Commentary:

;;; Code:

(use-package terraform-mode
  :defer t
  :mode (("\\.tf\\'" . terraform-mode))
  :config
  (require 'company-terraform)
  (company-terraform-init))

;;; 50-terraform.el ends here
