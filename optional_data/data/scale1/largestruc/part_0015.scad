$fn = 32;

// ----------------------------------------------------------------------
// Gantry bracket: 200-250 mm L bracket
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_l = 200;             // base arm length, X
arm_w = 40;               // arm width, Y
thick = 10;               // arm thickness
up_h = 80;                // vertical arm height, Z
slot_w = 14;              // adjustment slot width in the base

total_h = up_h + thick;  // overall height

difference() {
  union() {
    cube([base_l, arm_w, thick]);
    cube([thick, arm_w, total_h]);
  }
  translate([base_l / 2 - slot_w / 2, arm_w / 2 - slot_w / 2, -1])
    cube([slot_w, slot_w, thick + 2]);
}
