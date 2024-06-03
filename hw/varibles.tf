variable "vnets" {
    type = map(object({
        address_space= string
        subnets=list(object({
          name =string
          newbits=number
          netnum=number 
        })) 
    }))
    default = {
      "vnet1" = {
        address_space = "10.0.0.0/16"
        subnets =[
            {name="vnet1subnet1",newbits=8,netnum=5},
            {name="vnet1subnet2",newbits=8,netnum=6}
        ]
        
      },
      "vnet2"={
        address_space = "10.1.0.0/16"
        subnets=[
            {name="vnet2subnet1",newbits=8,netnum=5},
            {name="vnet2subnet2",newbits=8,netnum=6}
        ]
      }
    }
  
}
  variable "rules" {
    type = string
    default = "rules.csv"

    }