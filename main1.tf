module "VPC_Network"{
    source = "./VPC-Network"
    vpc_cidr_block = var.vpc_cidr_block
    Private_subnete_cidr_block = var.Private_subnete_cidr_block
    Public_subnete_cidr_block = var.Public_subnete_cidr_block
    number_of_public_subnets = var.number_of_public_subnets
    number_of_private_subnets = var.number_of_private_subnets
    availability_zones = var.availability_zones
}
module "Cluster_ECS"{
    source = "./ECS-cluster"
    name = "ecs-cluster"
    namespace = var.namespace
}
module "Fargete_cluster_api"{
    source = "./Fargate-cluster"
    family_name = "api"
    container_name = var.api_container_name
    image_uri = var.api_image_uri
    cpu = 1024
    memory = 2048
    app_port = var.app_port_api
    logs = "api_logs"
    cluster_id = module.Cluster_ECS.id
    app_count = var.app_count
    namespace = var.namespace
    port_mapping = var.api_port_mapping
    service_connect_port = 4006 
    vpc_id = module.VPC_Network.vpc_id 
    public_subnet_ids = module.VPC_Network.Public_subnet_ids 
    private_subnet_ids = module.VPC_Network.Private_subnet_ids 
    tg_name = "api"
    security_group_ecs_tasks_name = "security_group_ecs_tasks_api"
    dns_name="api_cluster"
}
module "Fargete_cluster_client"{
    source = "./Fargate-cluster"
    family_name = "client"
    container_name = var.client_container_name
    image_uri = var.client_image_uri
    cpu = 1024
    memory = 2048
    app_port = var.app_port_client
    logs = "client_logs"
    cluster_id = module.Cluster_ECS.id
    app_count = var.app_count
    namespace = var.namespace
    port_mapping = var.client_port_mapping
    service_connect_port = 3006
    vpc_id = module.VPC_Network.vpc_id 
    public_subnet_ids = module.VPC_Network.Public_subnet_ids 
    private_subnet_ids = module.VPC_Network.Private_subnet_ids 
    tg_name = "client"
    security_group_ecs_tasks_name = "security_group_ecs_tasks_client"
    dns_name= "client_cluster"
}
module "Fargete_cluster_db"{
    source = "./Fargate-cluster"
    family_name = "mongo"
    container_name = var.db_container_name
    image_uri = var.db_image_uri
    cpu = 1024
    memory = 2048
    app_port = var.app_port_db
    logs = "mongo_logs"
    cluster_id = module.Cluster_ECS.id
    app_count = var.app_count
    namespace = var.namespace
    port_mapping = var.db_port_mapping
    service_connect_port = 27006
    vpc_id = module.VPC_Network.vpc_id 
    public_subnet_ids = module.VPC_Network.Public_subnet_ids 
    private_subnet_ids = module.VPC_Network.Private_subnet_ids 
    tg_name = "mongo"
    security_group_ecs_tasks_name ="security_group_ecs_tasks_db"
    dns_name= "mongo_cluster"
}
