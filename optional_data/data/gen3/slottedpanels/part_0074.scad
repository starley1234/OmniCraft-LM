$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 70 mm, 4 ряда of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 70;             // panel depth
thick = 6;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 4;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 63;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 88.2 */
  hull() {
    translate([30.9, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([119.1, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11.2, length 94.5 */
  hull() {
    translate([27.75, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([122.25, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12.4, length 100.8 */
  hull() {
    translate([24.6, 35.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([125.4, 35.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.6, length 107.1 */
  hull() {
    translate([21.45, 48.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([128.55, 48.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 64, -2.5]) cylinder(h = 11, d = mount_d);
  translate([138, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([138, 64, -2.5]) cylinder(h = 11, d = mount_d);
}
