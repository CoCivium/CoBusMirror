# CoBus Attach State Model v1

Only these states may be claimed:

- bootstrapped
- read_attached
- write_attached
- fully_hitched
- blocked
- local_receipt_only

## Rules

- local artifacts alone imply only local_receipt_only
- bootstrap success does not imply write attachment
- write_attached requires:
  - writable CoBusMirror repo
  - intended payload written
  - intended payload committed
  - push success
  - raw refetch 200 of payload
  - raw refetch 200 of .sha256
- ully_hitched requires an additional gate beyond write_attached, to be defined explicitly elsewhere