$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 70;             // panel depth
thick = 8;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 45;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 72.24 */
  hull() {
    translate([23.88, 10.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([96.12, 10.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.2, length 77.4 */
  hull() {
    translate([21.3, 21.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([98.7, 21.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13.4, length 82.56 */
  hull() {
    translate([18.72, 34.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([101.28, 34.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.6, length 87.72 */
  hull() {
    translate([16.14, 47.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([103.86, 47.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.2, -2.5]) cylinder(h = 13, d = mount_d);
  translate([15, 65.8, -2.5]) cylinder(h = 13, d = mount_d);
  translate([105, 4.2, -2.5]) cylinder(h = 13, d = mount_d);
  translate([105, 65.8, -2.5]) cylinder(h = 13, d = mount_d);
}
