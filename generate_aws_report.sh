#!/bin/bash
###################################################################################
#Descrição: Script Bash que executa os comandos AWS CLI para gerar os relatórios. #
#Nome: Guilherme Said                                                             #
#E-mail: guilherme.said1@outlook.com                                              #
###################################################################################

# Elastic IPs
aws ec2 describe-addresses --region sa-east-1 --query 'Addresses[*].{PublicIP:PublicIp, AllocationId:AllocationId, AssociationId:AssociationId, NetworkInterfaceId:NetworkInterfaceId, Description:"Elastic IP não associado"}' --output table > relatorio_elastic_ips.txt

# Volumes EBS
aws ec2 describe-volumes --region sa-east-1 --query 'Volumes[*].{VolumeId:VolumeId, Size:Size, State:State, VolumeType:VolumeType, SnapshotId:SnapshotId, Description:"Volume EBS"}' --output table > relatorio_ebs_volumes.txt

# Snapshots
aws ec2 describe-snapshots --region sa-east-1 --owner-ids self --query 'Snapshots[*].{SnapshotId:SnapshotId, VolumeId:VolumeId, StartTime:StartTime, VolumeSize:VolumeSize, Description:"Snapshot"}' --output table > relatorio_snapshots.txt

# Instâncias EC2
aws ec2 describe-instances --region sa-east-1 --query 'Reservations[*].Instances[*].{InstanceId:InstanceId, InstanceType:InstanceType, State:State.Name, LaunchTime:LaunchTime, Description:"Instância EC2"}' --output table > relatorio_instancias_ec2.txt

# Buckets S3
aws s3api list-buckets --query 'Buckets[*].{Name:Name, CreationDate:CreationDate, Description:"Bucket S3"}' --output table > relatorio_s3_buckets.txt
echo "Tamanhos dos Buckets S3" > s3_bucket_sizes.txt
for bucket in $(aws s3api list-buckets --query 'Buckets[*].Name' --output text); do
    echo "Bucket: $bucket" >> s3_bucket_sizes.txt
    aws s3 ls s3://$bucket --recursive --summarize --human-readable --region sa-east-1 | grep "Total Size" >> s3_bucket_sizes.txt
done

# Security Groups
aws ec2 describe-security-groups --region sa-east-1 --query 'SecurityGroups[*].{GroupId:GroupId, GroupName:GroupName, Description:Description, VpcId:VpcId}' --output table > relatorio_security_groups.txt

# RDS Instances
aws rds describe-db-instances --region sa-east-1 --query 'DBInstances[*].{DBInstanceIdentifier:DBInstanceIdentifier, DBInstanceClass:DBInstanceClass, Engine:Engine, DBInstanceStatus:DBInstanceStatus, Description:"Instância RDS"}' --output table > relatorio_rds.txt

# Elastic Load Balancers (ELB)
aws elb describe-load-balancers --region sa-east-1 --query 'LoadBalancerDescriptions[*].{LoadBalancerName:LoadBalancerName, DNSName:DNSName, Instances:Instances[*].InstanceId, Description:"Elastic Load Balancer"}' --output table > relatorio_elb.txt

# Lambda Functions
aws lambda list-functions --region sa-east-1 --query 'Functions[*].{FunctionName:FunctionName, Runtime:Runtime, LastModified:LastModified, Description:"Função Lambda"}' --output table > relatorio_lambda_functions.txt

echo "Relatório completo gerado com sucesso!"
