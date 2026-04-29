# Database Terraform (RDS PostgreSQL)

Provisionar AWS RDS PostgreSQL via Terraform com backup, encryption e multi-AZ.

## 🎯 Propósito

- ✅ RDS PostgreSQL 15
- ✅ Multi-AZ (alta disponibilidade)
- ✅ Criptografia em repouso
- ✅ Backups automáticos (7 dias)
- ✅ Security groups
- ✅ Parameter groups customizados

## 🛠️ Tech Stack

- Terraform 1.5+
- AWS RDS
- PostgreSQL 15

## 🚀 Quick Start

```bash
# Setup
terraform init -backend-config="bucket=seu-bucket"

# Plan
terraform plan -var-file=envs/prod.tfvars

# Deploy
terraform apply -var-file=envs/prod.tfvars
```

## 📊 Outputs

```bash
terraform output endpoint
terraform output database_name
```

## 💾 Backup & Restore

```bash
# Database dumps estão em S3
aws s3 ls s3://seu-bucket/rds-backups/

# Restore
pg_restore -h ENDPOINT -U postgres backup.sql
```

