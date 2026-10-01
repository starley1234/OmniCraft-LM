$fn = 32;

// ----------------------------------------------------------------------
// Micro clip: slotted block, 5-20 mm class
// ----------------------------------------------------------------------

// --- parameters (mm) ---
block_l = 12;             // block length, X
block_w = 12;             // block width, Y
block_h = 8;              // block height, Z
slot_w = 2.5;             // slot width
slot_d = 5;               // slot depth from the top
fit_tol = 0.1;            // tolerance for press fits, mm
free_tol = 0.5;           // tolerance for clearance fits, mm

difference() {
  cube([block_l, block_w, block_h]);
  translate([-1, block_w / 2 - slot_w / 2, block_h - slot_d])
    cube([block_l + 2, slot_w, slot_d + 1]);
}
