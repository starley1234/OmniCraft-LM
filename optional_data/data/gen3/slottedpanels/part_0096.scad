$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 80 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 80;             // panel depth
thick = 8;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 75;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 112 */
  hull() {
    translate([34, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([146, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.2, length 120 */
  hull() {
    translate([30, 24, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([150, 24, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13.4, length 128 */
  hull() {
    translate([26, 36.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([154, 36.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.6, length 136 */
  hull() {
    translate([22, 49.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([158, 49.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 15.8, length 144 */
  hull() {
    translate([18, 64.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([162, 64.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 13, d = mount_d);
  translate([15, 75, -2.5]) cylinder(h = 13, d = mount_d);
  translate([165, 5, -2.5]) cylinder(h = 13, d = mount_d);
  translate([165, 75, -2.5]) cylinder(h = 13, d = mount_d);
}
