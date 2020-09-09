#### Export e Import

```
expdp "'/ as sysdba'" dumpfile=BACKUP$(date +%Y%m%d_%H%M).dmp logfile=LOG$(date +%Y%m%d_%H%M).log directory=DUMPS exclude=statistics schemas=SANKHYA

impdp \" / as sysdba\" schemas=SANKHYA dumpfile=????.dmp logfile=LOG_IMPORT_$(date +%Y%m%d_%H%M).log remap_schema=sankhya:teste directory=DUMPS
```
