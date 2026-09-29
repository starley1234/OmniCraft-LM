$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 80 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 80;             // panel depth
thick = 6;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 9;               // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 48;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 9, length 100 */
  hull() {
    translate([10, 12.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 12.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 10.8, length 100 */
  hull() {
    translate([10, 21.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 21.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 9, length 100 */
  hull() {
    translate([10, 32.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 32.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 10.8, length 100 */
  hull() {
    translate([10, 41.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 41.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 9, length 100 */
  hull() {
    translate([10, 52.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 52.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 10.8, length 100 */
  hull() {
    translate([10, 61.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 61.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 75, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 75, -2.5]) cylinder(h = 11, d = mount_d);
}
