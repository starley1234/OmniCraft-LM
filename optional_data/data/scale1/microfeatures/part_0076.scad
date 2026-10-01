$fn = 32;

// ----------------------------------------------------------------------
// Micro clip: slotted block, 5-20 mm class
// ----------------------------------------------------------------------

// --- parameters (mm) ---
block_l = 12;             // block length, X
block_w = 14;             // block width, Y
block_h = 8;              // block height, Z
slot_w = 2.5;             // slot width
slot_d = 6;               // slot depth from the top

difference() {
  cube([block_l, block_w, block_h]);
  translate([-1, block_w / 2 - slot_w / 2, block_h - slot_d])
    cube([block_l + 2, slot_w, slot_d + 1]);
}
