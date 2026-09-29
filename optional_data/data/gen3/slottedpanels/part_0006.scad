$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 90 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 90;             // panel depth
thick = 6;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 48;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 70.56 */
  hull() {
    translate([24.72, 12.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([95.28, 12.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.2, length 75.6 */
  hull() {
    translate([22.2, 23.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([97.8, 23.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13.4, length 80.64 */
  hull() {
    translate([19.68, 35.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100.32, 35.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.6, length 85.68 */
  hull() {
    translate([17.16, 49.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([102.84, 49.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 15.8, length 90.72 */
  hull() {
    translate([14.64, 63.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([105.36, 63.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 85.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 4.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 85.2, -2.5]) cylinder(h = 11, d = mount_d);
}
