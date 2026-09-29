$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 100 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 100;            // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 75;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 12, length 112.56 */
  hull() {
    translate([33.72, 13.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([146.28, 13.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.4, length 120.6 */
  hull() {
    translate([29.7, 25.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([150.3, 25.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 16.8, length 128.64 */
  hull() {
    translate([25.68, 39.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([154.32, 39.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 19.2, length 136.68 */
  hull() {
    translate([21.66, 56.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([158.34, 56.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 21.6, length 144.72 */
  hull() {
    translate([17.64, 75.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([162.36, 75.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.8, -2.5]) cylinder(h = 10, d = mount_d);
  translate([15, 95.2, -2.5]) cylinder(h = 10, d = mount_d);
  translate([165, 4.8, -2.5]) cylinder(h = 10, d = mount_d);
  translate([165, 95.2, -2.5]) cylinder(h = 10, d = mount_d);
}
