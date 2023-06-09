name "faffy"
description "Master role applied to faffy"

default_attributes(
  :networking => {
    :interfaces => {
      :internal => {
        :interface => "bond0",
        :role => :internal,
        :inet => {
          :address => "10.0.48.3"
        },
        :bond => {
          :mode => "802.3ad",
          :lacprate => "fast",
          :xmithashpolicy => "layer3+4",
          :slaves => %w[eno1 eno2 eno3 eno4 eno5 eno6]
        }
      },
      :external_cogent => {
        :interface => "bond0.2",
        :role => :external,
        :metric => 150,
        :source_route_table => 100,
        :inet => {
          :address => "130.117.76.3",
          :prefix => "27",
          :gateway => "130.117.76.1"
        },
        :inet6 => {
          :address => "2001:978:2:2c::172:3",
          :prefix => "64",
          :gateway => "2001:978:2:2c::172:1",
          :routes => {
            "2001:470:1:b3b::/64" => { :type => "unreachable" }
          }
        }
      },
      :external => {
        :interface => "bond0.3",
        :role => :external,
        :source_route_table => 150,
        :inet => {
          :address => "184.104.179.131",
          :prefix => "27",
          :gateway => "184.104.179.129"
        },
        :inet6 => {
          :address => "2001:470:1:fa1::3",
          :prefix => "64",
          :gateway => "2001:470:1:fa1::1"
        }
      }
    }
  }
)

run_list(
  "role[equinix-ams]",
  "role[dev]"
)
