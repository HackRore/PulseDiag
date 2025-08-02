# SmartDiag OS - Deep System Diagnostics Report

**Generated on:** 2025-08-02

## Kernel Ring Buffer (dmesg)

```
[    0.000000] Linux version 6.2.0-26-generic (buildd@lcy02-amd64-027) (x86_64-linux-gnu-gcc-12 (Ubuntu 12.3.0-1ubuntu1~22.04) 12.3.0, GNU ld (GNU Binutils for Ubuntu) 2.40) #26~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Jul 13 16:27:29 UTC 2
[   15.658884] ata1.00: READ FPDMA QUEUED
[   15.658891] ata1.00: cmd 60/08:e0:00:10:00/00:00:00:00:00/40 tag 28 ncq dma 4096 in
         res 41/40:00:00:10:00/00:00:00:00:00/40 Emask 0x409 (media error) <F>
[   15.658895] ata1.00: status: { DRDY ERR }
[   15.658897] ata1.00: error: { UNC }
```

## SMART Details for /dev/sda

```
SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  5 Reallocated_Sector_Ct   0x0033   100   100   010    Pre-fail  Always       -       12
197 Current_Pending_Sector  0x0032   100   100   000    Old_age   Always       -       2
198 Offline_Uncorrectable   0x0030   100   100   000    Old_age   Offline      -       2

SMART overall-health self-assessment test result: FAILED
```
