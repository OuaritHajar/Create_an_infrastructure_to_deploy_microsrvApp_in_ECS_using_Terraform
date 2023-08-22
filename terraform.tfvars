#vpc
vpc_cidr_block = "10.0.0.0/16"
Private_subnete_cidr_block = ["10.0.0.0/24","10.0.2.0/24"]
Public_subnete_cidr_block = ["10.0.3.0/24","10.0.4.0/24"]
number_of_public_subnets = "2"
number_of_private_subnets = "2"
availability_zones= ["us-east-1a", "us-east-1b"]
#ECS
namespace = "dev"
#api_Fargate
api_container_name = "api"
api_image_uri = "258076216385.dkr.ecr.us-east-1.amazonaws.com/repository:api"
app_port_api = 4000
app_count = "1"
api_port_mapping = "api_port"


#client_fargate
client_container_name = "client"
client_image_uri = "258076216385.dkr.ecr.us-east-1.amazonaws.com/repository:client" 
app_port_client = 3000
client_port_mapping = "client_port"


#db_fargate
db_container_name = "mongo"
db_image_uri = "258076216385.dkr.ecr.us-east-1.amazonaws.com/repository:mongo"
app_port_db = 27017
db_port_mapping = "mongo_port" 





