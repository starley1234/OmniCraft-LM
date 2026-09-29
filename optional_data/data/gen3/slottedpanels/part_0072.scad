$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 80 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 80;             // panel depth
thick = 6;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 48;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 70.56 */
  hull() {
    translate([24.72, 12.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([95.28, 12.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11.8, length 75.6 */
  hull() {
    translate([22.2, 22.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([97.8, 22.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13.6, length 80.64 */
  hull() {
    translate([19.68, 34.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100.32, 34.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 15.4, length 85.68 */
  hull() {
    translate([17.16, 48, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([102.84, 48, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 17.2, length 90.72 */
  hull() {
    translate([14.64, 63.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([105.36, 63.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 75.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 4.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 75.2, -2.5]) cylinder(h = 11, d = mount_d);
}
