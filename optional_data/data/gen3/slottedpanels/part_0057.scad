$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 90 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 90;             // panel depth
thick = 6;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 45;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 67.2 */
  hull() {
    translate([26.4, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([93.6, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.4, length 72 */
  hull() {
    translate([24, 25.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([96, 25.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 15.8, length 76.8 */
  hull() {
    translate([21.6, 38.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([98.4, 38.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 18.2, length 81.6 */
  hull() {
    translate([19.2, 54.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100.8, 54.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 20.6, length 86.4 */
  hull() {
    translate([16.8, 72.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([103.2, 72.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([15, 84, -2.5]) cylinder(h = 11, d = mount_d);
  translate([105, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([105, 84, -2.5]) cylinder(h = 11, d = mount_d);
}
