variable "loc" {
    description = "Default Azure region"
    default     =   "australiasoutheast"
}

variable "webapplocs" {
    description = "A list of Azure regions to deploy web apps across"
    default = []

}

variable "tags" {
    default     = {
        source  = "citadel"
        env     = "training"
    }
}