name "snap-03"
description "Master role applied to snap-03"

default_attributes(
  :networking => {
    :interfaces => {
      :internal => {
        :inet => {
          :address => "10.0.64.50"
        },
        :bond => {
          :slaves => %w[enp25s0f0np0 enp25s0f1np1]
        }
      }
    }
  },
  :postgresql => {
    :settings => {
      :defaults => {
        :shared_buffers => "128GB",
        :work_mem => "128MB",
        :maintenance_work_mem => "2GB",
        :effective_cache_size => "360GB"
      }
    }
  },
  :sysctl => {
    :postgres => {
      :comment => "Increase shared memory for postgres",
      :parameters => {
        "kernel.shmmax" => 132 * 1024 * 1024 * 1024,
        "kernel.shmall" => 132 * 1024 * 1024 * 1024 / 4096
      }
    }
  }
)

run_list(
  "role[equinix-dub]",
  "role[db-slave]"
)
