name "jakelong"
description "Master role applied to jakelong"

default_attributes(
  :dhcpd => {
    :first_address => "10.0.78.1",
    :last_address => "10.0.78.254"
  },
  :networking => {
    :interfaces => {
      :internal_ipv4 => {
        :interface => "bond0",
        :role => :internal,
        :family => :inet,
        :address => "10.0.64.12",
        :bond => {
          :mode => "802.3ad",
          :lacprate => "fast",
          :xmithashpolicy => "layer3+4",
          :slaves => %w[eno1 eno2 eno3 eno4 ens1f0 ens1f1]
        }
      },
      :external_ipv4 => {
        :interface => "bond0.101",
        :role => :external,
        :family => :inet,
        :address => "184.104.226.108"
      },
      :external_ipv6 => {
        :interface => "bond0.101",
        :role => :external,
        :family => :inet6,
        :address => "2001:470:1:b3b::c"
      }
    }
  }
)

run_list(
  "role[equinix-dub]",
  "role[hp-dl360e-g8]",
  "recipe[dhcpd]"
)