# AWS Resource Reporter 

Script Bash para automação de relatórios de infraestrutura AWS.

##  Descrição
Este script executa comandos da AWS CLI para gerar relatórios detalhados de recursos na região `sa-east-1`.

##  Requisitos
- AWS CLI instalado e configurado.
- Permissões de leitura nos serviços listados.

##  Relatórios Gerados
- **Elastic IPs:** `relatorio_elastic_ips.txt`
- **Volumes EBS:** `relatorio_ebs_volumes.txt`
- **Snapshots:** `relatorio_snapshots.txt`
- **Instâncias EC2:** `relatorio_instancias_ec2.txt`
- **S3 Buckets:** `relatorio_s3_buckets.txt` e `s3_bucket_sizes.txt`
- **Security Groups:** `relatorio_security_groups.txt`
- **RDS:** `relatorio_rds.txt`
- **ELB:** `relatorio_elb.txt`
- **Lambda:** `relatorio_lambda_functions.txt`
