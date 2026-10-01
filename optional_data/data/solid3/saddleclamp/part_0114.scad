$fn = 32;

// ----------------------------------------------------------------------
// Saddle clamp: plain shaft clamp
// ----------------------------------------------------------------------

// --- parameters (mm) ---
blk_l = 70;               // block length, X
blk_w = 30;               // block width, Y
blk_h = 36;               // block height
clamp_r = 12;             // shaft groove radius
hole_r = 3;               // bolt hole radius
hole_m = 8;               // bolt hole margin from the ends

saw_depth = clamp_r + 3;  // saw kerf depth

difference() {
  cube([blk_l, blk_w, blk_h]);
  translate([blk_l / 2, -1, blk_h])
    rotate([-90, 0, 0])
      cylinder(h = blk_w + 2, r = clamp_r);
  for (sx = [0, 1])
    translate([sx ? blk_l - hole_m : hole_m, blk_w / 2, -1])
      cylinder(r = hole_r, h = blk_h + 2);
}
