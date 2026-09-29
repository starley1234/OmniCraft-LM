$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 90 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 90;             // panel depth
thick = 6;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 60;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 13, length 88.2 */
  hull() {
    translate([30.9, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([119.1, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.2, length 94.5 */
  hull() {
    translate([27.75, 28.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([122.25, 28.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 15.4, length 100.8 */
  hull() {
    translate([24.6, 42.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([125.4, 42.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 16.6, length 107.1 */
  hull() {
    translate([21.45, 58.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([128.55, 58.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([15, 84, -2.5]) cylinder(h = 11, d = mount_d);
  translate([135, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([135, 84, -2.5]) cylinder(h = 11, d = mount_d);
}
