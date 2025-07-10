provider "aws" {
  region = "TODO"
}

provider "coralogix" {
  #api_key = "" # Will come from the .env file
  env = "US2"
}