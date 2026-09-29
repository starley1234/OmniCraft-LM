$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 100 mm, 7 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 100;            // panel depth
thick = 6;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 7;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 48;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 38.4 */
  hull() {
    translate([40.8, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([79.2, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11, length 49.92 */
  hull() {
    translate([35.04, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([84.96, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 61.44 */
  hull() {
    translate([29.28, 37.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([90.72, 37.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 11, length 72.96 */
  hull() {
    translate([23.52, 48.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([96.48, 48.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 84.48 */
  hull() {
    translate([17.76, 59.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([102.24, 59.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 11, length 96 */
  hull() {
    translate([12, 70.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 70.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 6: pitch 11, length 96 */
  hull() {
    translate([12, 81.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 81.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 94, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 94, -2.5]) cylinder(h = 11, d = mount_d);
}
