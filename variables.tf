variable "loc" {
    description = "Default Azure region"
    default     =   "Australia Southeast"
}

variable "tags" {
    default     = {
        source  = "citadel"
        env     = "training"
    }
}