## Açıklamalar
Sanal makineleri içinde açacağımız hipervizörün (Compute Node) bilgilerini getiriyoruz.

Çıktımız şöyle:
```
Changes to Outputs:
  + Bulunan_hypervisor = {
      + disk     = 548
      + host_ip  = "192.168.11.115"
      + hostname = "com115"
      + id       = "16"
      + memory   = 128607
      + state    = "up"
      + status   = "enabled"
      + type     = "QEMU"
      + vcpus    = 64
    }
```

Ancak `TF_LOG=DEBUG` ile göreceğimiz veri daha geniş:

```
[DEBUG] OpenStack Response Body: {
  "hypervisors": [
    ...
    {
      ---- diğer hipervizörleri gösteren elemanlar ----
    },
    ...
    {
      "cpu_info": "{\"vendor\": \"Intel\", \"model\": \"Skylake-Client-IBRS\", \"arch\": \"x86_64\", \"features\": [\"rtm\", \"tsc_adjust\", \"tsc-deadline\", \"pge\", \"vmx\", \"smep\", \"fpu\", \"monitor\", \"lm\", \"tsc\", \"adx\", \"fxsr\", \"tm\", \"pclmuldq\", \"xgetbv1\", \"vme\", \"arat\", \"de\", \"aes\", \"pse\", \"sse\", \"f16c\", \"ds\", \"mpx\", \"avx512f\", \"avx2\", \"pbe\", \"mbm_local\", \"cx16\", \"ds_cpl\", \"movbe\", \"cmt\", \"xsaveopt\", \"sep\", \"xsave\", \"erms\", \"hle\", \"est\", \"smx\", \"abm\", \"sse4.1\", \"sse4.2\", \"acpi\", \"pni\", \"pdcm\", \"mmx\", \"osxsave\", \"dca\", \"popcnt\", \"invtsc\", \"tm2\", \"pcid\", \"rdrand\", \"x2apic\", \"smap\", \"clflush\", \"dtes64\", \"xtpr\", \"msr\", \"fma\", \"cx8\", \"mce\", \"avx512cd\", \"ht\", \"lahf_lm\", \"rdseed\", \"apic\", \"fsgsbase\", \"rdtscp\", \"ssse3\", \"pse36\", \"mtrr\", \"avx\", \"syscall\", \"invpcid\", \"cmov\", \"spec-ctrl\", \"clflushopt\", \"pat\", \"3dnowprefetch\", \"nx\", \"pae\", \"md-clear\", \"mca\", \"pdpe1gb\", \"xsavec\", \"mbm_total\", \"sse2\", \"ss\", \"bmi1\", \"bmi2\", \"xsaves\"], \"topology\": {\"cores\": 16, \"cells\": 2, \"threads\": 2, \"sockets\": 1}}",
      "current_workload": 0,
      "disk_available_least": 211,
      "free_disk_gb": 248,
      "free_ram_mb": 42079,
      "host_ip": "192.168.11.115",
      "hypervisor_hostname": "com115",
      "hypervisor_type": "QEMU",
      "hypervisor_version": 2008000,
      "id": 16,
      "local_gb": 548,
      "local_gb_used": 169,
      "memory_mb": 128607,
      "memory_mb_used": 5476,
      "running_vms": 6,
      "service": {
        "disabled_reason": null,
        "host": "com115",
        "id": 21
      },
      "state": "up",
      "status": "enabled",
      "vcpus": 64,
      "vcpus_used": 32
    }
  ]
}
```


## Komutlar
`hostname` Bilgisini komut satırında veriyorum ancak `*.tfvars` dosyalarında belirtebiliriz

```shell
clear
terraform plan -var-file=vto.tfvars -var hostname=compute105
```

```shell
clear
terraform apply -var-file=vto.tfvars
```