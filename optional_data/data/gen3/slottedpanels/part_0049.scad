$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 80 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 80;             // panel depth
thick = 5;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 9;               // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 48;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 9, length 96 */
  hull() {
    translate([12, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 10.8, length 96 */
  hull() {
    translate([12, 23.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 23.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 9, length 96 */
  hull() {
    translate([12, 34.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 34.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 10.8, length 96 */
  hull() {
    translate([12, 43.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 43.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 9, length 96 */
  hull() {
    translate([12, 54.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 54.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 10.8, length 96 */
  hull() {
    translate([12, 63.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 63.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([12, 74, -2.5]) cylinder(h = 10, d = mount_d);
  translate([108, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([108, 74, -2.5]) cylinder(h = 10, d = mount_d);
}
