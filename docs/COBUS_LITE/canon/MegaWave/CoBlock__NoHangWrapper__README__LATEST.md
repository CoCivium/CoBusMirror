# CoBlock No-Hang Wrapper (LATEST)

**Goal:** No “hanging cursor,” no Ctrl+C.  
**How:** Run the real work in a background Job while the foreground prints a heartbeat line every N seconds, then prints a definitive END marker.

## Usage pattern (for ALL future CoPings)
- Put your whole wave inside:
  Invoke-CoNoHang -Label "<WaveName>" -Work { <actual work> }
- Always ends with: # COPY_SAFE:TRUE | END_OF_BLOCK

## Notes
- Heartbeat uses plain lines (safe for PS7 panels, logs, copy/paste).
- If the work errors, wrapper throws after printing a FAIL line (so you get a clean failure marker, still no Ctrl+C).
