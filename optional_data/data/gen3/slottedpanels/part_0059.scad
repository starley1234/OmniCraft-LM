$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 80 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 80;             // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 63;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 93.24 */
  hull() {
    translate([28.38, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([121.62, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.4, length 99.9 */
  hull() {
    translate([25.05, 22.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([124.95, 22.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 15.8, length 106.56 */
  hull() {
    translate([21.72, 36.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([128.28, 36.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 18.2, length 113.22 */
  hull() {
    translate([18.39, 52.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([131.61, 52.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.2, -2.5]) cylinder(h = 10, d = mount_d);
  translate([12, 75.8, -2.5]) cylinder(h = 10, d = mount_d);
  translate([138, 4.2, -2.5]) cylinder(h = 10, d = mount_d);
  translate([138, 75.8, -2.5]) cylinder(h = 10, d = mount_d);
}
