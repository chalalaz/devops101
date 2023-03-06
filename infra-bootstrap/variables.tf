variable "cidr_block" {
  description = "CIDR Block to allow Site Access"
  default     = "0.0.0.0/0"
}

variable "key_name" {
  description = "Name of keypair to ssh"
  default     = "" # Your key pair name
}