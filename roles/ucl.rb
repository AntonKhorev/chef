name "ucl"
description "Role applied to all servers at UCL"

default_attributes(
  :location => "Slough, England",
  :networking => {
    :interfaces => {
      :internal => {
        :role => :internal,
        :metric => 200,
        :inet => {
          :prefix => "20",
          :gateway => "10.0.0.3",
          :routes => {
            "10.0.0.0/8" => { :via => "10.0.0.3" }
          }
        }
      }
    },
    :wireguard => {
      :keepalive => 180
    }
  }
)

override_attributes(
  :networking => {
    :nameservers => ["10.0.0.3", "8.8.8.8", "8.8.4.4"],
    :search => ["ucl.openstreetmap.org", "openstreetmap.org"]
  },
  :ntp => {
    :servers => ["ntp1.ucl.ac.uk", "ntp2.ucl.ac.uk"]
  }
)

run_list(
  "role[gb]"
)
