$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 70;             // panel depth
thick = 8;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 63;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 88.2 */
  hull() {
    translate([30.9, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([119.1, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11.8, length 94.5 */
  hull() {
    translate([27.75, 25, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([122.25, 25, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13.6, length 100.8 */
  hull() {
    translate([24.6, 36.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([125.4, 36.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 15.4, length 107.1 */
  hull() {
    translate([21.45, 50.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([128.55, 50.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 13, d = mount_d);
  translate([12, 64, -2.5]) cylinder(h = 13, d = mount_d);
  translate([138, 6, -2.5]) cylinder(h = 13, d = mount_d);
  translate([138, 64, -2.5]) cylinder(h = 13, d = mount_d);
}
